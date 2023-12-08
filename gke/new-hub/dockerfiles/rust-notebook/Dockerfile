FROM quay.io/jupyter/minimal-notebook

USER root

RUN sudo apt update -y && sudo apt upgrade -y

RUN apt install autoconf automake bzip2 build-essential dpkg-dev file g++ gcc imagemagick libbz2-dev libc6-dev libcurl4-openssl-dev libdb-dev libevent-dev libffi-dev libgdbm-dev libglib2.0-dev libgmp-dev libjpeg-dev libkrb5-dev liblzma-dev libmagickcore-dev libmagickwand-dev libmaxminddb-dev libncurses5-dev libncursesw5-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libtool libwebp-dev libxml2-dev libxslt-dev libyaml-dev make net-tools patch unzip xz-utils zlib1g-dev -y

RUN pip install ipykernel --upgrade

RUN rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

ENV PATH=/home/${NB_USER}/.cargo/bin:/home/${NB_USER}/bin:/home/${NB_USER}/.local/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

WORKDIR ${HOME}

RUN curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain nightly -y

RUN rustup component add rust-src

RUN cargo install --locked evcxr_jupyter

RUN evcxr_jupyter --install

USER ${NB_UID}
