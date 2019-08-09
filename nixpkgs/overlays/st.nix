# ~/.config/nixpkgs/overlays/st.nix

self: super:

{
  st = super.st.override {
    conf = builtins.readFile /data/works/dotfiles/nixpkgs/st/config.h;
  };
}
