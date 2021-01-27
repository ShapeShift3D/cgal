#!/bin/bash

. "${S3D_SOURCES_DIR}/common.sh"

readonly workdir="mpfr"

cd "${S3D_INSTALL_DIR}"
case "$OS" in
    "Windows_NT")
      readonly url="http://www.holoborodko.com/pavel/wp-content/plugins/download-monitor/download.php?id=5"
      readonly archive="MPFR-MPIR-x86-x64-MSVC2010.zip"
      wget --no-check-certificate -O $archive $url
      ;;
    *)
      # TODO
      exit 1
      ;;
  esac

mkdir $workdir
unzip "$archive" -d $workdir
rm $archive
