##
## Plug-in for installing Ubuntu Focal.
##

DISTRO_NAME="Ubuntu 20.04"

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

# Returns download URL and SHA-256 of file in this format:
# SHA-256|FILE-NAME
get_download_url() {
	local rootfs

	case "$DISTRO_ARCH" in
		aarch64)
			rootfs="https://github.com/termux/proot-distro/releases/download/v1.2-ubuntu-focal-rootfs/ubuntu-focal-core-cloudimg-arm64-root-2020.12.10.tar.gz"
			;;
		armv7l|armv8l)
			rootfs="https://github.com/termux/proot-distro/releases/download/v1.2-ubuntu-focal-rootfs/ubuntu-focal-core-cloudimg-armhf-root-2020.12.10.tar.gz"
			;;
		i686)
			# Ubuntu Focal does not provide tarballs for x86 32bit.
			return
			;;
		x86_64)
			rootfs="https://github.com/termux/proot-distro/releases/download/v1.2-ubuntu-focal-rootfs/ubuntu-focal-core-cloudimg-amd64-root-2020.12.10.tar.gz"
			;;
	esac

	echo "${rootfs}"
}

# Define here additional steps which should be executed
# for configuration.
distro_setup() {
	# Hint: $PWD is the distribution rootfs directory.
	#echo "hello world" > ./etc/motd

	# Run command within proot'ed environment with
	# run_proot_cmd function.
	# Uncomment this to do system upgrade during installation.
	#run_proot_cmd apt update
	#run_proot_cmd apt upgrade -yq
	:
}
