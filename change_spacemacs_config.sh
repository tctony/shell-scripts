#!/bin/sh

CONFIG_DIR=$HOME/Emacs

EMACS_DIR=$HOME/.emacs.d
SPACEMACS_DIR=$HOME/.spacemacs.d

if [ "$1" = "test" ]; then
    echo "switched to test config"
    ln -sfhv $CONFIG_DIR/test_spacemacs               $EMACS_DIR
    ln -sfhv $CONFIG_DIR/test_spacemacs.config        $SPACEMACS_DIR
else
    echo "switched to normal config"
    ln -sfhv $CONFIG_DIR/spacemacs                    $EMACS_DIR
    ln -sfhv $CONFIG_DIR/spacemacs.config             $SPACEMACS_DIR
fi
