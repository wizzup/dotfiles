# dotfiles

My dotfiles

# install

Run `setup.sh` to create symlinks

This excluded following `NixOS` configuration files, which have to (sudo) symlinks manually.

    ./nixos/configuration.nix          -> /etc/nixos/configuration.nix
    ./nixos/hardware-configuration.nix -> /etc/nixos/hardware-configuration.nix
