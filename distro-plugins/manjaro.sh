# Plug-in for installing Manjaro.

DISTRO_NAME="Manjaro"

# You can override a CPU architecture to let distribution
# be executed by QEMU (user-mode).
#
# You can specify the following values here:
#
#  * aarch64: AArch64 (ARM64, 64bit ARM)
#  * armv7l:  ARM (32bit)
#  * i686:    x86 (32bit)
#  * x86_64:  x86 (64bit)
#
# Default value is set by proot-distro script and is equal
# to the CPU architecture of your device (uname -m).
#DISTRO_ARCH=$(uname -m)

# x86_64 rootfs is inside subdirectory.
#if [ "$DISTRO_ARCH" = "x86_64" ]; then
#	DISTRO_TARBALL_STRIP_OPT=1
#fi

# Returns download URL and SHA-256 of file in this format:
# SHA-256|FILE-NAME
get_download_url() {
	local rootfs

	case "$DISTRO_ARCH" in
		aarch64)
			rootfs="https://github.com/MilkyDeveloper/proot-distro/releases/download/v1.7.0/ArchLinuxARM-aarch64-latest.tar.gz"
			;;
		armv7l|armv8l)
			# Manjaro ARM doesn't support Armhf
			return
			;;
		x86_64)
			# TODO: Find/generate an x64 rootfs for Manjaro
			return
			;;
	esac

	echo "${rootfs}"
}

# Define here additional steps which should be executed
# for configuration.
distro_setup() {
	# Initialize en_US locale.
	echo "en_US.UTF-8 UTF-8" > ./etc/locale.gen
	run_proot_cmd locale-gen
	sed -i 's/LANG=C.UTF-8/LANG=en_US.UTF-8/' ./etc/profile.d/termux-proot.sh

	# Uninstall packages which are not necessary.
	case "$(uname -m)" in
		aarch64)
			run_proot_cmd pacman -Rnsc --noconfirm linux-aarch64
			;;
		armv7l|armv8l)
			run_proot_cmd pacman -Rnsc --noconfirm linux-armv7
			;;
	esac

	# Generate Pacman keys
	run_proot_cmd pacman-key --init
}
