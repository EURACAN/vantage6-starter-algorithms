# The Dockerfile tells Docker how to construct the image with your algorithm.
# Once pushed to a repository, images can be downloaded and executed by the
# network hubs.

# Use R as the base image.
FROM r-base:4.1.0

#
# Pin APT to a Debian snapshot matching this image's era to avoid repo/key drift.
#
RUN rm -f /etc/apt/sources.list /etc/apt/sources.list.d/* \
  && printf '%s\n' \
    'deb http://snapshot.debian.org/archive/debian/20210721T000000Z testing main' \
    'deb http://snapshot.debian.org/archive/debian-security/20210721T000000Z testing-security main' \
    'deb http://snapshot.debian.org/archive/debian/20210721T000000Z testing-updates main' \
    > /etc/apt/sources.list \
  && printf '%s\n' \
    'Acquire::Check-Valid-Until "false";' \
    > /etc/apt/apt.conf.d/99snapshot \
  && apt-get -o Acquire::Check-Valid-Until=false update \
  && apt-get install -y --no-install-recommends \
    pkg-config \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libwebp-dev \
    libgit2-dev \
    libuv1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
  && rm -rf /var/lib/apt/lists/*

# Change directory to '/app’. This means the subsequent ‘RUN’ steps will
# execute in this directory.
WORKDIR /app

COPY docker/install_base_packages.R /app
RUN Rscript install_base_packages.R

