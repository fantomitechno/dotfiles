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
        BATTERY=$(${pkgs.lib.getExe pkgs.acpi} -b | head -n 1)
        LEVEL=$(echo "$BATTERY" | ${pkgs.lib.getExe pkgs.ripgrep} -o "\d+%" | ${pkgs.lib.getExe pkgs.ripgrep} -o "\d+")
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
