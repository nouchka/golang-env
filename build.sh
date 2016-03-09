#!/bin/bash

DM_DIR="/go/$DIRECTORY/"

export GOPATH="$DM_DIR"

TARGET_GID=$(stat -c "%g" $0)

if [ ! -d "$DM_DIR/src/github.com/$GITHUB" ]; then
	echo "Go get project from git"
	mkdir $DM_DIR
	cd $DM_DIR
	##https://gist.github.com/shurcooL/6927554
	go get "github.com/$GITHUB"
fi

cd $DM_DIR/src/github.com/$GITHUB

if [ -f "/go/docker-machine/src/github.com/$GITHUB/$BIN_FILE" ]; then
	rm -rf /go/docker-machine/src/github.com/$GITHUB/$BIN_FILE
fi
make build
chown -R $TARGET_GID:$TARGET_GID $DM_DIR
