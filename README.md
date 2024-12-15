# Nixos dotfiles

- Rebuild system without adding boot entry
  ```shell
  make nixos-test
  ```
- Rebuild system and add boot entry
  ```shell
  make nixos-switch
  ```

> [!IMPORTANT]
> If builds fail with error `/etc/nixos/hardware-configuration.nix and <dotfiles_directory>/hardware-configuration.nix are different`,
> this is intended behaviour. This will always happen on a fresh install (Can happen in other cases as discussed below).
>
> Why check for this?
> Nixos requires hardware-configuration.nix to be part of git (It checks the git status of this file on every build).
> Whenever your hardware-configuration.nix changes, you should take a look as to why that is the case.
>
> This check tries to prevent some problematic scenarios:
>
> 1. When you clone this repo and run nixos-rebuild on fresh install, (without this check) build would be successful.
>    But, when you try to boot into the new generation, grub will not be able to find the partition with partition id (because ids are different for each partition).
>    Because of this, grub will fail to boot.
> 2. In case hardware-configuration.nix changes for some reason (e.g. you added new hardware), this check makes sure we are aware of this.
>    This way, unexpected things don't happen when you boot into the new generation.
