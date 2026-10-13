{ lib, pkgs, ... }:

let
  fanControl = pkgs.writeShellApplication {
    name = "ipmi-fan-control";

    runtimeInputs = with pkgs; [
      ipmitool
      gawk
      gnused
      gnugrep
      coreutils
    ];

    text = ''
      INTERVAL=30      # seconds between adjustments
      RETRY_DELAY=10   # seconds between retries after a failed read
      MAX_FAILS=3      # consecutive failures before forcing 100% fans

      fails=0
      last1=""
      last2=""

      # Percentage -> hex value for the Lenovo raw command
      set_fan_speed() {
        local bank=$1 pct=$2 hex
        case $pct in
          0)   hex=0x01 ;;
          25)  hex=0x07 ;;
          30)  hex=0x30 ;;
          35)  hex=0x3A ;;
          40)  hex=0x40 ;;
          50)  hex=0x50 ;;
          60)  hex=0x60 ;;
          70)  hex=0x70 ;;
          80)  hex=0x80 ;;
          90)  hex=0x90 ;;
          95)  hex=0xA0 ;;
          100) hex=0xFF ;;
          *) echo "Unknown fan speed: $pct" >&2; return 1 ;;
        esac
        ipmitool raw 0x3a 0x07 "$bank" "$hex" 0x01 > /dev/null
      }

      set_all_fans() {
        set_fan_speed 0x01 "$1"
        set_fan_speed 0x02 "$1"
      }

      # Extract an integer temperature for a sensor label from the SDR dump
      get_temp() {
        local label=$1 data=$2 raw
        raw=$(grep -w "$label" <<< "$data" | awk -F'|' '{print $5}' | sed 's/[^0-9.]//g') || true
        echo "''${raw%%.*}"
      }

      calc_speed() {
        local t=$1
        if   (( t < 40 )); then echo 0
        elif (( t < 45 )); then echo 25
        elif (( t < 50 )); then echo 30
        elif (( t < 55 )); then echo 35
        elif (( t < 60 )); then echo 40
        elif (( t < 65 )); then echo 50
        elif (( t < 70 )); then echo 60
        elif (( t < 75 )); then echo 70
        elif (( t < 80 )); then echo 80
        elif (( t < 85 )); then echo 90
        elif (( t < 90 )); then echo 95
        else echo 100
        fi
      }

      echo "ipmi-fan-control started"

      while true; do
        cpu1=""
        cpu2=""
        if data=$(ipmitool sdr type temperature); then
          cpu1=$(get_temp "CPU 1 Temp" "$data")
          cpu2=$(get_temp "CPU 2 Temp" "$data")
        fi

        if [[ -z $cpu1 || -z $cpu2 ]]; then
          fails=$((fails + 1))
          echo "Failed to read CPU temperatures ($fails/$MAX_FAILS)" >&2
          if (( fails >= MAX_FAILS )); then
            echo "Too many failures, forcing fans to 100%" >&2
            set_all_fans 100 || true
          fi
          sleep "$RETRY_DELAY"
          continue
        fi
        fails=0

        s1=$(calc_speed "$cpu1")
        s2=$(calc_speed "$cpu2")
        set_fan_speed 0x01 "$s1"
        set_fan_speed 0x02 "$s2"

        # Only log when something changes, to keep the journal quiet
        if [[ $s1 != "$last1" || $s2 != "$last2" ]]; then
          echo "CPU1 ''${cpu1}C -> fan bank 1 at $s1% | CPU2 ''${cpu2}C -> fan bank 2 at $s2%"
          last1=$s1
          last2=$s2
        fi

        sleep "$INTERVAL"
      done
    '';
  };
in
{
  # Make sure the local IPMI device (/dev/ipmi0) exists
  boot.kernelModules = [
    "ipmi_devintf"
    "ipmi_si"
  ];

  systemd.services.ipmi-fan-control = {
    description = "Lenovo x3650 M5 IPMI fan control";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];

    serviceConfig = {
      ExecStart = lib.getExe fanControl;
      Restart = "always";
      RestartSec = 10;

      # Failsafe: whenever the service stops or crashes, push both banks to 100%
      ExecStopPost = [
        "${pkgs.ipmitool}/bin/ipmitool raw 0x3a 0x07 0x01 0x40 0x01"
        "${pkgs.ipmitool}/bin/ipmitool raw 0x3a 0x07 0x02 0x40 0x01"
      ];
    };
  };
}
