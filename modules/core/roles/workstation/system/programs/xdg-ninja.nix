{lib, ...}: let
  glEnv = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME}/.local/bin";
    XDG_RUNTIME_DIR = "/run/user/$UID";
    PATH = ["$XDG_BIN_HOME"];
  };

  sysEnv = with glEnv; {
    # general programs
    ERRFILE = "${XDG_CACHE_HOME}/X11/xsession-errors";
    GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
    LESSHISTFILE = "${XDG_DATA_HOME}/less/history";
    XCOMPOSECACHE = "${XDG_CACHE_HOME}/X11/xcompose";
    INPUTRC = "${XDG_CONFIG_HOME}/readline/inputrc";
    WINEPREFIX = "${XDG_DATA_HOME}/wine";
    DOTNET_CLI_HOME = "${XDG_DATA_HOME}/dotnet";
    SQLITE_HISTORY = "${XDG_CACHE_HOME}/sqlite_history";

    # programming languages/package managers/tools
    ANDROID_HOME = "${XDG_DATA_HOME}/android";
    ANDROID_USER_HOME = "${XDG_DATA_HOME}/android";
    DOCKER_CONFIG = "${XDG_CONFIG_HOME}/docker";
    GRADLE_USER_HOME = "${XDG_DATA_HOME}/gradle";
    GOPATH = "${XDG_DATA_HOME}/go";
    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java";
    CARGO_HOME = "${XDG_DATA_HOME}/cargo";
    NODE_REPL_HISTORY = "${XDG_DATA_HOME}/node_repl_history";
    NPM_CONFIG_CACHE = "${XDG_CACHE_HOME}/npm";
    NPM_CONFIG_TMP = "${XDG_RUNTIME_DIR}/npm";
    NPM_CONFIG_USERCONFIG = "${XDG_CONFIG_HOME}/npm/config";
  };

in {
  environment = {
    variables = glEnv;
    sessionVariables = sysEnv;
  };
}
