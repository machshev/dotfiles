#!/usr/bin/env bash

echo "Installing Protobuf"

[[ -x "$(command -v protoc)" ]] && INSTALL_EXISTS=true || INSTALL_EXISTS=false
RELEASE_URL="https://api.github.com/repos/protocolbuffers/protobuf/releases/latest"
LATEST_VERSION="$(curl -s $RELEASE_URL | jq -r .name | cut -d ' ' -f 3)"

do_install() {
	WORK_DIR=$(mktemp -d)
	pushd $WORK_DIR

	# Install protoc from the github release page
	PROTOC_URL=$(curl -s $RELEASE_URL | jq --raw-output '.assets[] | select(.name | endswith("-linux-x86_64.zip")) | .browser_download_url')

	curl -LO "$PROTOC_URL"

	unzip protoc-*-linux-x86_64.zip -d $HOME/.local

	popd
}

if ! $INSTALL_EXISTS; then
	do_install

else
	INSTALLED_VERSION="v$(protoc --version | cut -d ' ' -f 2)"
	echo " * protobuf is already installed ($INSTALLED_VERSION) latest version is ($LATEST_VERSION)"

	if [[ $INSTALLED_VERSION != $LATEST_VERSION ]]; then
		echo "Updating protobuf to the latest version"
		do_install
	else
		echo "Latest version already installed"
	fi
fi
