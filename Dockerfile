# Use the latest stable Debian image 12.7
FROM debian:12.7

LABEL org.opencontainers.image.description DOOM-EMACS-IN-DOCKER

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/home/emacsuser/.config/emacs/bin:${PATH}"

# Install dependencies and Create a non-root user
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-utils=2.6.1 \
        ca-certificates=20230311 && \
    apt-get install -y --no-install-recommends \
        curl=7.88.1-10+deb12u7 \
        emacs=1:28.2+1-15+deb12u3 \
        fd-find=8.6.0-3 \
        gcc=4:12.2.0-3 \
        git=1:2.39.5-0+deb12u1 \
        ripgrep=13.0.0-4+b2 \
        sudo=1.9.13p3-1+deb12u1 \
        libgccjit-12-dev=12.2.0-14 \
        libgccjit0=12.2.0-14 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -ms /bin/bash emacsuser && \
    echo "emacsuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the non-root user and set up Doom Emacs
USER emacsuser
WORKDIR /home/emacsuser

# Install Doom Emacs
RUN git clone --depth 1 https://github.com/doomemacs/doomemacs.git ~/.config/emacs && \
    ~/.config/emacs/bin/doom install --env -! && \
    mkdir -p ~/.config/emacs/doom/old-config && \
    find ~/.config/emacs/doom/ -maxdepth 1 -name '*.el' -exec mv {} ~/.config/emacs/doom/old-config/ \;

# Copy Doom Emacs config files and update
COPY ./doom-snapshot/*.el /home/emacsuser/.config/doom/
RUN doom upgrade && doom sync
