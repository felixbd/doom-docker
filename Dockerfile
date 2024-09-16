FROM debian:12.7  # latest

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y -no-install-recommends \
    apt-utils emacs git curl sudo gcc ripgrep fd-find \
    libgccjit0 libgccjit-12-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash emacsuser && echo "emacsuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER emacsuser
WORKDIR /home/emacsuser

# Install Doom Emacs
RUN git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs && \
    ~/.config/emacs/bin/doom install --env -!

# Add ~/.config/emacs/bin to PATH
ENV PATH="/home/emacsuser/.config/emacs/bin:${PATH}"


# update the doom config files
RUN mkdir -p /home/emacsuser/.config/doom/old-configs \
    cd /home/emacsuser/.config/doom/ \
    mv *.el ./old-configs/ \
    cd -

COPY ./doom-snapshot/*.el /home/emacsuser/.config/doom/

RUN doom upgrade && doom sync


# WORKDIR /app

# Add an entrypoint to start Emacs
# ENTRYPOINT ["emacs"]
