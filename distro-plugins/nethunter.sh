##
## Plug-in for installing Kali Nethunter Rootless.
##

DISTRO_NAME="Kali Nethunter"
DISTRO_COMMENT="Minimal version, most of utilities should be installed manually."

# Rootfs is in subdirectory.
DISTRO_TARBALL_STRIP_OPT=1

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
			rootfs="https://github.com/termux/proot-distro/releases/download/v1.2-kali-rootfs/kalifs-arm64-2020.12.10-minimal.tar.xz"
			;;
		armv7l|armv8l)
			rootfs="https://github.com/termux/proot-distro/releases/download/v1.2-kali-rootfs/kalifs-armhf-2020.12.10-minimal.tar.xz"
			;;
		i686)
			rootfs="https://github.com/termux/proot-distro/releases/download/v1.2-kali-rootfs/kalifs-i386-2020.12.10-minimal.tar.xz"
			;;
		x86_64)
			rootfs="https://github.com/termux/proot-distro/releases/download/v1.2-kali-rootfs/kalifs-amd64-2020.12.10-minimal.tar.xz"
			;;
	esac

	echo "${rootfs}"
}

# Define here additional steps which should be executed
# for configuration.
distro_setup() {
	# Fix ~/.bash_profile.
	cat <<- EOF > ./root/.bash_profile
	. /root/.bashrc
	. /root/.profile
	EOF

	# Allow use apt with outdated keyring.
	sed -i 's@deb http@deb [trusted=yes] http@g' \
		./etc/apt/sources.list
}
