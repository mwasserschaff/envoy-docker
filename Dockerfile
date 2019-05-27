FROM envoyproxy/envoy-build-centos:latest AS builder

RUN git clone https://github.com/envoyproxy/envoy.git
RUN cd envoy && env ENVOY_SRCDIR=$(pwd) ./ci/do_ci.sh  bazel.release.server_only

FROM centos:7.6.1810

COPY  --from=builder /build/envoy/source/exe/envoy /usr/local/bin/envoy

RUN yum update -y && yum clean all
