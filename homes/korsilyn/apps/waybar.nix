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
          format-icons = {
            activated = " ";
            deactivated = " ";
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
          format-connected-battery = " {status} {device_battery_percentage}%";
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
          on-click = "swaymsg input type:keyboard xkb_switch_layout next";
        };
      };
    };
    style = ''
      @define-color rosewater #f5e0dc;
      @define-color flamingo #f2cdcd;
      @define-color pink #f5c2e7;
      @define-color mauve #cba6f7;
      @define-color red #f38ba8;
      @define-color maroon #eba0ac;
      @define-color peach #fab387;
      @define-color yellow #f9e2af;
      @define-color green #a6e3a1;
      @define-color teal #94e2d5;
      @define-color sky #89dceb;
      @define-color sapphire #74c7ec;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color text #cdd6f4;
      @define-color subtext1 #bac2de;
      @define-color subtext0 #a6adc8;
      @define-color overlay2 #9399b2;
      @define-color overlay1 #7f849c;
      @define-color overlay0 #6c7086;
      @define-color surface2 #585b70;
      @define-color surface1 #45475a;
      @define-color surface0 #313244;
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;

      * {
        border-radius: 10px;
        font-family: Noto Sans Nerd Font;
        font-size: 14px;
        background-color: transparent;
      }

      .modules-right {
        background-color: @surface0;
        padding: 0rem 0.7rem 0rem 0.7rem;
        margin: 5px 0px 5px 0px;
      }

      .modules-center {
        background-color: @surface0;
        margin: 5px 0px 5px 0px;
      }

      .modules-left {
        background-color: @surface0;
        margin: 5px 0px 5px 0px;
      }

      tooltip {
        background-color: @surface0;
        color: @text;
      }

      #workspaces {
        margin: 1px 5px 1px 5px;
      }

      #workspaces button {
        color: @text;
        font-weight: bolder;
        margin: 2px 2px;
        min-width: 10px;
      }

      #workspaces button:hover {
        background-color: alpha(@overlay0, 0.5);
        color: @text;
        border-radius: 20px;
      }

      #workspaces button.focused {
        color: @text;
        background-color: @overlay0;
        border-radius: 20px;
      }

      #clock {
        font-weight: bolder;
        color: @text;
        padding: 0rem 1rem 0rem 1rem;
      }

      #idle_inhibitor {
        color: #d4be98;
        padding: 0 0.1em 0 0.1em;
      }

      #idle_inhibitor.activated {
        color: #d3869b;
      }

      #memory {
        color: #a9b665;
        padding: 0 0.3em 0 0.5em;
        border-radius: 10px 0 0 10px;
      }

      #pulseaudio {
        margin: 0;
        padding: 0 0.4em 0 0.4em;
        color: #d8a657;
      }

      #cpu {
        margin: 0;
        padding: 0 0.1em 0 0.1em;
        color: #a9b665;
      }

      #backlight {
        margin: 0;
        padding: 0 0.1em 0 0.1em;
        color: #a9b665;
      }

      #battery {
        margin: 0;
        padding: 0 0.1em 0 0.1em;
        color: #a9b665;
      }

      #bluetooth {
        margin: 0;
        padding: 0 0.1em 0 0.1em;
        color: #a9b665;
      }

      #network {
        margin: 0;
        padding: 0 0.4em 0 0.5em;
        color: #d8a657;
      }

      #language {
        margin: 0;
        padding: 0 0.1em;
        color: #d3869b;
      }

      #disk {
        margin: 0;
        padding: 0 0.1em 0 0.1em;
        color: #a9b665;
      }

      #window {
        color: #ebdbb2;
        margin-left: 0rem;
        margin-right: 1rem;
        text-shadow: 0 0 5px rgba(0, 0, 0, 0.818);
        transition: all 0.1s ease-in-out;
        border-radius: 0px;
        font-size: 15px;
      }
    '';
  };
}
