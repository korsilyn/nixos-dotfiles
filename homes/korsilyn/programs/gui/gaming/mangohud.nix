{
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig) modules;

  env = modules.usrEnv;
  prg = env.programs;
in {
  config = mkIf prg.gaming.mangohud.enable {
    programs.mangohud = {
      enable = true;
      settings = {
        background_alpha = "0.2";
        baackground_color = "020202";
        fps_limit = "160";
        fps_limit_method = "late";
        vsync = 1;
        gl_vsync = 0;
        font_size = 20;
        horizontal = true;
        hud_no_margin = true;
        legacy_layout = 0;
        cpu_stats = true;
        cpu_temp = true;
        cpu_power = true;
        gpu_stats = true;
        gpu_temp = true;
        gpu_mem_temp = true;
        gpu_power = true;
        vram = true;
        procmem = true;
        fps = true;
        io_read = true;
        io_write = true;
        frame_timing = true;
        histogram = true;
        time = true;
        toggle_hud = "Shift_R+F12";
        toggle_fps_limit = "Shift_R+F1";
      };
    };
  };
}
