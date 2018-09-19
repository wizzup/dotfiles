# ~/.config/nixpkgs/overlays/boost.nix
self: super:

{
  boost = super.boost.override {
    python = self.python3;
  };
}
