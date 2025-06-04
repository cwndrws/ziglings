{
  description = "dev shell environment for ziglings";
  inputs = {};
  outputs = { self, ... }: {
    devShell.x86_64-linux = pkgs.mkShell {
      buildInputs = [ pkgs.zig ];
      # Use the user's default shell
      shellHook = ''
        # Get the user's default shell from /etc/passwd
        user_shell="$(awk -F: -v user="$(whoami)" '$1 == user {print $NF}' /etc/passwd)"

        # Check if the shell is interactive
        if [[ $- == *i* ]]; then
          echo "Starting user's default shell: $user_shell"
          exec "$user_shell"
        else
          echo "Non-interactive shell detected. Using default nix-shell."
        fi
      '';
    };
  };
}

