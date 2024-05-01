#!/bin/bash
#
# Install the latest version of Go

echo "Installing Go"

[[ -x "$(command -v go)" ]] && GO_EXISTS=true || GO_EXISTS=false
GO_VERSION_LATEST="$(curl https://go.dev/dl/?mode=json 2>/dev/null | jq -r .[0].version)"

do_install() {
	GO_TAR_URL="https://dl.google.com/go/${GO_VERSION_LATEST}.linux-amd64.tar.gz"

	sudo rm -rf /usr/local/go

	curl -sSL "${GO_TAR_URL}" | sudo tar -xvzf - -C "/usr/local" --strip-components 1

	echo "Removing temporary dir"
	rm -frv $WORK_DIR

}

if ! $GO_EXISTS; then
	do_install
else
	GO_VERSION=$(go version | cut -d " " -f 3)
	echo " * Go is already installed ($GO_VERSION)"

	if [[ $GO_VERSION != $GO_VERSION_LATEST ]]; then
		echo "Updating Go to latest version"
		do_install
	else
		echo " * Latest version is already installed"
	fi
fi

echo "Install common go tools"
go install golang.org/x/tools/cmd/godoc@latest

echo "Installing gopls the go language server"
go install golang.org/x/tools/gopls@latest
go install github.com/bufbuild/buf-language-server/cmd/bufls@latest
go install github.com/go-delve/delve/cmd/dlv@latest

echo "Install the protobuf extensions"
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
