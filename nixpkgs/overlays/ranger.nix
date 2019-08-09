self: super:
{
  ranger = super.ranger.override {
    imagePreviewSupport = true;
  };
}
