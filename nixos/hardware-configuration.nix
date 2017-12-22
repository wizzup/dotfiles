# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ohci_pci" "ehci_pci" "pata_amd" "sata_nv" "usb_storage" "usbhid" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/eaf30e64-0a90-447f-b53d-1598fe46a8a9";
      fsType = "btrfs";
      options = [ "subvol=@nixos" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/eaf30e64-0a90-447f-b53d-1598fe46a8a9";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/tmp" =
    { device = "/dev/disk/by-uuid/eaf30e64-0a90-447f-b53d-1598fe46a8a9";
      fsType = "btrfs";
      options = [ "subvol=@tmp" ];
    };

  fileSystems."/data" =
    { device = "/dev/disk/by-uuid/eaf30e64-0a90-447f-b53d-1598fe46a8a9";
      fsType = "btrfs";
      options = [ "subvol=@data" ];
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 2;
  powerManagement.cpuFreqGovernor = "ondemand";
}