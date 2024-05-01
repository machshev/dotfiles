#!/usr/bin/env bash

echo "Installing Buf"

[[ -x "$(command -v buf)" ]] && BUF_EXISTS=true || BUF_EXISTS=false
BUF_RELEASE_URL="https://api.github.com/repos/bufbuild/buf/releases/latest"
BUF_VERSION_LATEST="$(curl -s $BUF_RELEASE_URL | jq -r .name)"

do_install() {
	BUF_TAR_URL=$(curl -s "$BUF_RELEASE_URL" | jq --raw-output '.assets[] | select(.name | endswith("-Linux-x86_64.tar.gz")) | .browser_download_url')

	curl -sSL "${BUF_TAR_URL}" | tar -xvzf - -C "${HOME}/.local" --strip-components 1
}

if ! $BUF_EXISTS; then
	do_install

else
	BUF_VERSION="v$(buf --version)"
	echo " * Buf is already installed ($BUF_VERSION) latest version is ($BUF_VERSION_LATEST)"

	if [[ $BUF_VERSION != $BUF_VERSION_LATEST ]]; then
		echo "Updating Buf to the latest version"
		do_install
	else
		echo "Latest version already installed"
	fi
fi
