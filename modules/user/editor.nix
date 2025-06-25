{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = { pkgs, ... }: {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "go"
        "nix"
        "python"
      ];
      userSettings = {
        vim_mode = true;
        env = {
          TERM = "ghostty";
        };
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        language_models = {
          ollama = {
            api_url = "http://192.168.178.142:11434";
          };
          openapi = {
            api_url = "http://localhost:1234/v1";
          };
        };
        assistant = {
          enabled = true;
          default_model = {
            provider = "ollama";
            model = "llama3:latest";
          };
        };
      };
      userKeymaps = [
        {
          context = "Editor";
          bindings = {
            "ctrl-h" = "workspace::ActivatePaneLeft";
            "ctrl-l" = "workspace::ActivatePaneRight";
            "ctrl-k" = "workspace::ActivatePaneUp";
            "ctrl-j" = "workspace::ActivatePaneDown";
          };
        }
        {
          context = "Editor && vim_mode == normal && !VimWaiting && !menu";
          bindings = {
            "g d" = "editor::GoToDefinition";
            "g D" = "editor::GoToDefinitionSplit";
            "g i" = "editor::GoToImplementation";
            "g I" = "editor::GoToImplementationSplit";
            "g t" = "editor::GoToTypeDefinition";
            "g T" = "editor::GoToTypeDefinitionSplit";
            "g r" = "editor::FindAllReferences";

            "ctrl-s" = "workspace::Save";

            "space e" = "pane::RevealInProjectPanel";
          };
        }
        {
          context = "Terminal";
          bindings = {
            "ctrl-h" = "workspace::ActivatePaneLeft";
            "ctrl-l" = "workspace::ActivatePaneRight";
            "ctrl-k" = "workspace::ActivatePaneUp";
            "ctrl-j" = "workspace::ActivatePaneDown";
          };
        }
        {
          context = "ProjectPanel && not_editing";
          bindings = {
            "a" = "project_panel::NewFile";
            "A" = "project_panel::NewDirectory";
            "r" = "project_panel::Rename";
            "d" = "project_panel::Delete";
            "x" = "project_panel::Cut";
            "c" = "project_panel::Copy";
            "p" = "project_panel::Paste";

            "space e" = "pane::RevealInProjectPanel";

            "ctrl-h" = "workspace::ActivatePaneLeft";
            "ctrl-l" = "workspace::ActivatePaneRight";
            "ctrl-k" = "workspace::ActivatePaneUp";
            "ctrl-j" = "workspace::ActivatePaneDown";
          };
        }
      ];
    };
  };
}
