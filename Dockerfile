FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

# set version label
LABEL maintainer="rgon"

# title
ENV TITLE="KEME Contabilidad"
ENV KEME_VERSION="4.0.1.0"

# Install dependencies
RUN apt-get update && apt-get install -y expect libxkbcommon-x11-0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0

# Optional installs
RUN apt-get update && apt-get install -y texlive-latex-base

# Install keme
RUN mkdir -p /bin/keme && \
    curl -L https://master.dl.sourceforge.net/project/keme/KEME-Contabilidad/${KEME_VERSION}/keme_${KEME_VERSION}_Ubuntu22.04.deb --output /tmp/keme.run && \
    chmod +x /tmp/keme.deb

# Run QT Installer Framework in CLI mode
#RUN unbuffer expect -c 'spawn /tmp/keme.run in; expect "Accept|Reject|Show"; send "Accept\r"; expect "Yes|No"; send "Yes\r"; interact'
RUN apt-get -y install /tmp/keme.deb

# add start command
# COPY ./root /

# ports and volumes
EXPOSE 3000

VOLUME /config
