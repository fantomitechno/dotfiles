{ pkgs, ... }:

{
  systemd.user.services."battery-low" = {
    enable = true;
    description = "Notify user if battery is below 10%";
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "battery-low-notification" ''
        BATTERIES=$(${pkgs.lib.getExe pkgs.acpi} -b)
        LEVEL=200
        N=$(echo "$BATTERIES" | wc -l)
        for ((i = 1 ; i <= N ; i++)); do
          BATTERY=$(echo "$BATTERIES" | sed -n "''${i}p")
          if echo "$BATTERY" | grep -q "rate information unavailable"; then
            echo "Skipping: $BATTERY"
          else
            NEW_LEVEL=$(echo "$BATTERY" | ${pkgs.lib.getExe pkgs.ripgrep} -o "\d+%" | ${pkgs.lib.getExe pkgs.ripgrep} -o "\d+")
            if ((NEW_LEVEL < LEVEL)); then
              LEVEL=$NEW_LEVEL
            fi
          fi 
        done
        echo "$LEVEL"
        if echo "$BATTERY" | ${pkgs.lib.getExe pkgs.ripgrep} -q "Discharging" && (( 10 >= LEVEL )); then
        ${pkgs.lib.getExe pkgs.libnotify} --urgency=critical "low battery" "$LEVEL%"
        fi
      '';
    };
  };
  systemd.user.timers."battery-low" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* *:*:00";
      Unit = "battery-low.service";
    };
  };
}
