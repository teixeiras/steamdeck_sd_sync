#!/bin/bash
INSTALL_PATH="~/.local/share/sdsync"
mkdir INSTALL_PATH
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
cp *.py $INSTALL_PATH
cp -a vdf-3.4 $INSTALL_PATH
# Install the service script
cp $DIR/sdsync.service ~/.local/share/systemd/user/

systemctl enable --now --user sdsync.service
trap cleanup EXIT
