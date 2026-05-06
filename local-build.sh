#!/bin/bash
# local-build.sh
# A script to locally build packages from vl-strata by injecting them into void-packages

set -e

# Configuration
VL_STRATA_DIR="$(pwd)"
VOID_PACKAGES_DIR="${VL_STRATA_DIR}/../void-packages-build"
VOID_PACKAGES_URL="https://github.com/void-linux/void-packages.git"

# Make sure we are in the right directory
if [ ! -d "srcpkgs" ]; then
    echo "Error: Please run this script from the root of the vl-strata repository."
    exit 1
fi

echo "=> Preparing void-packages build directory..."
if [ ! -d "${VOID_PACKAGES_DIR}" ]; then
    echo "=> Cloning void-packages..."
    git clone --depth 1 "${VOID_PACKAGES_URL}" "${VOID_PACKAGES_DIR}"
else
    echo "=> void-packages already exists, pulling latest changes..."
    cd "${VOID_PACKAGES_DIR}"
    git pull origin master
    cd "${VL_STRATA_DIR}"
fi

echo "=> Injecting vl-strata templates into void-packages..."
cp -rv srcpkgs/* "${VOID_PACKAGES_DIR}/srcpkgs/"

# Optional: If you ever add a shlibs_append file, inject it here:
if [ -f "shlibs_append" ]; then
    echo "=> Appending custom shlibs..."
    cat shlibs_append >> "${VOID_PACKAGES_DIR}/common/shlibs"
fi

echo "=> Bootstrapping xbps-src if needed..."
cd "${VOID_PACKAGES_DIR}"
if [ ! -f "masterdir/bin/xbps-install" ] && [ ! -d "masterdir-x86_64" ]; then
    ./xbps-src binary-bootstrap
fi

echo "========================================="
echo "Injection complete!"
echo "You can now build packages by running:"
echo "  cd ../void-packages-build"
echo "  ./xbps-src pkg <package-name>"
echo "========================================="

# If a package name is passed as an argument, build it automatically
if [ -n "$1" ]; then
    echo "=> Building package: $1"
    ./xbps-src pkg "$1"
fi
