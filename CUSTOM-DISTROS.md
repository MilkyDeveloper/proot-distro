# Custom Distros

Most distros come in `raw`, `img`, or `iso` files.
Unfortunately, we need a directory that contains the linux file system, also called a Root Filesystem (RootFS).

### Converting `raw`, `img`, or `iso` files to a RootFS

1. `pkg install p7zip`
2. 7z e [RAW/IMG/ISO FILE]
3. 7z e 1.img -oRootFS -y

Done! Your RootFS is now in the `RootFS` directory!
