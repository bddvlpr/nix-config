{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      netcoredbg
      nil
      nodePackages.svelte-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      omnisharp-roslyn
      rust-analyzer
    ];

    settings = {
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        file-picker.hidden = false;
      };
    };

    languages = {
      language = [
        {
          name = "svelte";
          auto-format = true;
        }
        {
          name = "typescript";
          formatter = {
            command = "${pkgs.nodePackages.prettier}/bin/prettier";
            args = ["--stdin-filepath" "file.ts"];
          };
          auto-format = true;
        }
      ];
    };
  };
}
