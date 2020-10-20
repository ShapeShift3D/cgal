#!/bin/bash

. "${S3D_SOURCES_DIR}/common.sh"

readonly source_dir="${S3D_SOURCES_DIR}/cgal"
readonly build_dir="${S3D_BUILDS_DIR}/cgal"
readonly install_dir="${S3D_INSTALL_DIR}/cgal"

# Create build directory
mkdir -p "${build_dir}"

# configure
cd "${build_dir}"
# configure and generate
cmake \
  -G "${GENERATOR}" \
  -DCMAKE_INSTALL_PREFIX="${install_dir}" \
  -DCGAL_HEADER_ONLY=ON \
  -DWITH_Eigen3=ON \
  -DCMAKE_BUILD_TYPE=Release \
  "${source_dir}"

build
install
