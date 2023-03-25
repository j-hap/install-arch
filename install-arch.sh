#!/bin/bash

# -e : Exit immediately if a command exits with a non-zero status.
# -u : Treat unset variables as an error when substituting.
# -f : Disable file name generation (globbing).
# -o pipefail : the return value of a pipeline is the status of the last command
#               to exit with a non-zero status, or zero if no command exited
#               with a non-zero status
set -euf -o pipefail

./pre-chroot.sh
cp ./post-chroot.sh /mnt/.
echo "Changing root."
arch-chroot /mnt ./post-chroot.sh
rm /mnt/post-chroot.sh

echo "Done. Now reboot."
