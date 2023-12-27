FROM rocker/r-base
RUN apt update

# Dependencies for devtools
# There might be unneccessary deps here.
RUN apt install -y \
  build-essential \
  libcurl4-gnutls-dev \
  libxml2-dev \
  libssl-dev \
  libfontconfig1-dev \
  libharfbuzz-dev \
  libfribidi-dev \
  libfreetype6-dev \
  libpng-dev \
  libtiff5-dev \
  libjpeg-dev

RUN bash -c 'R -e "install.packages(\"devtools\")"'

COPY ./srcR /opt/srcR
WORKDIR /opt/srcR
RUN bash -c 'R -e "library(\"devtools\"); devtools::install_deps(\".\")"'

# Dependencies to for `check`
RUN apt install -y \
  texlive-latex-recommended \
  texlive-fonts-recommended \
  texlive-fonts-extra