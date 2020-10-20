# BASE_IMAGE gets replaced by the makefile
FROM s3d-base-ubuntu as base

WORKDIR ${S3D_SOURCES_DIR}
COPY . cgal
RUN cgal/build_cgal.sh && rm cgal/build_cgal.sh

FROM s3d-base-ubuntu as final
COPY --from=base "${S3D_INSTALL_DIR}/cgal" "${S3D_INSTALL_DIR}/cgal"
