#!/bin/bash

. "${S3D_SOURCES_DIR}/common.sh"

readonly project_name=cgal
readonly build_dir="${S3D_BUILDS_DIR}/${project_name}"
readonly install_dir="${S3D_INSTALL_DIR}/${project_name}"

# If running in Windows CI
if [ ! -z ${CI_PROJECT_DIR+x} ] && [ ${OS} = "Windows_NT" ]; then
    readonly source_dir="${PWD}/"
else
    readonly source_dir="${S3D_SOURCES_DIR}/${project_name}"
fi

# Create build directory
mkdir -p "${build_dir}"

# configure
cd "${build_dir}"
# configure and generate
case $OS in
    linux)
	cmake \
	    -G "${GENERATOR}" \
	    -DCMAKE_INSTALL_PREFIX="${install_dir}" \
	    -DCGAL_HEADER_ONLY=ON \
	    -DWITH_Eigen3=ON \
	    -DCMAKE_BUILD_TYPE=Release \
	    "${source_dir}"
	;;
    Windows_NT)
	readonly mpfr_install_dir="${S3D_INSTALL_DIR}/mpfr"
	cmake \
	    -G "${GENERATOR}" \
	    -DCMAKE_INSTALL_PREFIX="${install_dir}" \
	    -DCGAL_HEADER_ONLY=ON \
	    -DWITH_Eigen3=ON \
	    -DCMAKE_BUILD_TYPE=Release \
	    `# BOOST ` \
	    -DBOOST_ROOT="${S3D_INSTALL_DIR}/boost" \
	    `# GMP ` \
	    -DGMP_INCLUDE_DIR="${mpfr_install_dir}/mpir/dll/x64/Release" \
	    -DGMP_LIBRARIES="${mpfr_install_dir}/mpir/dll/x64/Release/mpir.lib" \
	    -DMPFR_INCLUDE_DIR="${mpfr_install_dir}/mpfr" \
	    -DMPFR_LIBRARIES="${mpfr_install_dir}/mpfr/dll/x64/Release/mpfr.lib" \
	    "${source_dir}"
	;;
esac

build
install
