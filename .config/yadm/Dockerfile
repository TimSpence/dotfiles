FROM ubuntu:20.04

# Update && install common dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -yq \
        ncurses-dev man telnet unzip zsh git subversion curl make sudo locales \
        autoconf automake python golang-go \
        vim htop

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Add user
ARG user
RUN adduser --disabled-password --gecos '' ${user}         && \
    adduser ${user} sudo                                   && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    usermod --shell /bin/zsh ${user}
USER ${user}

# Install zinit
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

COPY --chown=${user} .zshrc /home/${user}/.zshrc

ARG TERM
ENV TERM ${TERM:-xterm-256color}

WORKDIR /home/${user}
RUN SHELL=/bin/zsh zsh -i -c -- 'zinit module build; @zinit-scheduler burst || true '

CMD zsh -i -l
