TMPDIR=$(mktemp -d)
pushd $TMPDIR

wget https://zoom.us/client/latest/zoom_x86_64.rpm
sudo dnf install -y zoom_x86_64.rpm

popd
rm -r $TMPDIR
