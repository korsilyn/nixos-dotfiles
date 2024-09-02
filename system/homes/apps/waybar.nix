{...}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 56;
        margin-left = 15;
        margin-right = 15;
        modules-left = ["sway/workspaces"];
        modules-center = ["clock"];
        modules-right = ["idle_inhibitor" "cpu" "memory" "disk" "pulseaudio" "network" "bluetooth" "backlight" "battery" "sway/language"];
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons: {
            activated: " ";
            deactivated: " ";
          };
        };
        "cpu" = {
          interval = 1;
          format = "  {usage}%";
        };
        "memory" = {
          interval = 1;
          format = "  {percentage}%";
        };
        "disk" = {
          format = "󰋊  {percentage_used}%";
        };
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "  ";
          format-icons = {
            default = ["" " " " "];
          };
          on-click = "helvum";
        };
        "network" = { 
      	  format-ethernet = "  {ifname}";
          format-wifi = "  {essid}";
          format-linked = "  {ifname} (No IP)";
	        format-disconnected = "Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        };
        "bluetooth" = {
          format-connected-battery = " {status} {device_battery_percentage}";
          tooltip-format-connected = "{device_alias} {device_address}";
        };
        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = ["  " " "];
        };
        "battery" = {
          states = {
            warning = 20;
            critical = 10;
          };
          format = "{icon} {capacity}%";
          format-icons = [" " " " " " " " " "];
        };
        "sway/language" = {
          format = "  {short}";
          on-click: "swaymsg input type:keyboard xkb_switch_layout next";
        };
      };
    };
  };
}
