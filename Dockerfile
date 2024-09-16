# TODO: hadolint Dockerfile
# warning: Pin versions in apt get install. Instead of `apt-get install <package>` use `apt-get install <package>=<version>`

# Use the latest stable Debian image 12.7
FROM debian:12.7

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/home/emacsuser/.config/emacs/bin:${PATH}"

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils emacs git curl sudo gcc ripgrep fd-find \
    libgccjit0 libgccjit-12-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash emacsuser && \
    echo "emacsuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the non-root user and set up Doom Emacs
USER emacsuser
WORKDIR /home/emacsuser

# Install Doom Emacs
RUN git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs && \
    ~/.config/emacs/bin/doom install --env -! && \
    mkdir -p ~/.config/emacs/doom/old-config && \
    mv ~/.config/emacs/doom/*.el ~/.config/emacs/doom/old-config/

# Copy Doom Emacs config files and update
COPY ./doom-snapshot/*.el /home/emacsuser/.config/doom/
RUN doom upgrade && doom sync
