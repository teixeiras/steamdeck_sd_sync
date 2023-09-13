#!/bin/bash
INSTALL_PATH="/home/deck/.local/share/sdsync"
rm -rf $INSTALL_PATH
mkdir $INSTALL_PATH

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORK_DIR=`mktemp -d -p "$DIR"`

function cleanup {      
  rm -rf "$WORK_DIR"
  echo "Deleted temp working directory $WORK_DIR"
}


cd $WORK_DIR
wget https://github.com/teixeiras/steamdeck_sd_sync/archive/refs/heads/main.zip
unzip main.zip


cd steamdeck_sd_sync-main/
# Install the script files
ls
cp sdsync $INSTALL_PATH
chmod u+x $INSTALL_PATH/sdsync
cp -a vdf-3.4 $INSTALL_PATH

mkdir -p /home/deck/.local/share/systemd/user/

# Install the service script
cp sdsync.service ~/.local/share/systemd/user/
systemctl --user daemon-reload

systemctl enable --now --user sdsync.service
trap cleanup EXIT
