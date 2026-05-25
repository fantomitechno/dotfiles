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
        LAST_BATTERY=$(${pkgs.lib.getExe pkgs.acpi} -b | tail -n 1)
        LEVEL=$(echo "$LAST_BATTERY" | ${pkgs.lib.getExe pkgs.ripgrep} -o "\d+%" | ${pkgs.lib.getExe pkgs.ripgrep} -o "\d+")
        ALL_DISCHARGING=$(${pkgs.lib.getExe pkgs.acpi} -b | ${pkgs.lib.getExe pkgs.ripgrep} -c "Discharging")
        TOTAL=$(${pkgs.lib.getExe pkgs.acpi} -b | ${pkgs.lib.getExe pkgs.coreutils}/bin/wc -l)
        if [[ "$ALL_DISCHARGING" == "$TOTAL" ]] && (( 10 >= LEVEL )); then
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
