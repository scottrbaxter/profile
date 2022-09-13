FROM ubuntu:20.04
LABEL description="profile"

ARG USER=ubuntu
ARG PROFILE_BRANCH=master
ARG PROFILE_PATH=/home/$USER/development/profile
ARG LC_ALL="en_US.UTF-8"
ARG UUID=${UUID:-1000}
ARG GUID=${GUID:-1000}

# Set the SHELL to bash with pipefail option
SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

# Prevent dialog during apt install
ARG DEBIAN_FRONTEND=noninteractive

### Base system packages
RUN apt-get update; \
  apt-get -qy install --no-install-recommends \
    build-essential \
    cargo \
    curl \
    dirmngr \
    fd-find \
    fzf \
    file \
    git \
    gpg \
    htop \
    libbz2-dev \
    libffi-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    llvm \
    locales \
    make \
    python3-pip \
    ripgrep \
    shellcheck \
    sudo \
    tk-dev \
    unzip \
    wget \
    xz-utils \
    zlib1g-dev \
    zsh; \
  apt-get autoremove -y; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/*; \
  locale-gen $LC_ALL; \
  sed -i 's/^%sudo\tALL=(ALL:ALL) /%sudo\tALL=(ALL) NOPASSWD:/' /etc/sudoers; \
  grep -w $GUID /etc/group || groupadd --gid $GUID $USER; \
  useradd \
    --uid $UUID \
    --gid $GUID \
    --groups sudo \
    --shell /usr/bin/zsh \
    --home-dir /home/$USER \
    --create-home \
    $USER

### Install AWS CLI version 2
WORKDIR /tmp
RUN wget -q https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip; \
  unzip awscli-exe-linux-x86_64.zip; \
  ./aws/install; \
  rm -rf aws awscli-exe-linux-x86_64.zip

### install hadolint
RUN wget -qO /usr/local/bin/hadolint \
  https://github.com/hadolint/hadolint/releases/download/v2.1.0/hadolint-Linux-x86_64; \
  chmod 0755 /usr/local/bin/hadolint

USER $USER

### iterm shell integration
RUN wget -q -P /tmp https://iterm2.com/misc/install_shell_integration.sh; \
  chmod 0755 /tmp/install_shell_integration.sh; \
  /tmp/install_shell_integration.sh; \
  rm /tmp/install_shell_integration.sh

### asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2; \
  . $HOME/.asdf/asdf.sh; \
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git; \
  asdf install nodejs 16.17.0; \
  asdf global nodejs 16.17.0; \
  asdf reshim nodejs; \
  npm install -g aws-cdk neovim tree-sitter-cli; \
  asdf plugin-add python; \
  asdf install python 3.10.4; \
  asdf global python 3.10.4; \
  asdf reshim python; \
  pip install --no-cache-dir --upgrade pip \
    ansible \
    ansible-lint \
    autopep8 \
    codespell \
    ipython \
    isort \
    flake8 \
    pynvim \
    yamllint \
    yapf

### Make directories
RUN mkdir -p \
  ~/.config/coc \
  ~/.config/nvim \
  ~/.config/yamllint \
  ~/.vim/_temp \
  ~/.vim/bundle \
  ~/development

### clone repo
RUN git clone https://github.com/scottrbaxter/profile.git $PROFILE_PATH; \
  cd $PROFILE_PATH || return; \
  git branch | grep ${PROFILE_BRANCH} || \
    git checkout -b ${PROFILE_BRANCH} origin/${PROFILE_BRANCH}; \
  git submodule sync && git submodule update --init --recursive --depth 1

### install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
  && mv ~/.zshrc ~/.zshrc.bak

### Powerlevel10k
WORKDIR $PROFILE_PATH/omz/custom/themes/powerlevel10k/gitstatus
RUN ./install

### LunarVim
ARG LV_BRANCH=rolling
ENV PATH="$PATH:/home/$USER/.local/bin"
WORKDIR /
RUN curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install-neovim-from-release | bash -x
RUN curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install.sh | bash -s -- --no-install-dependencies
WORKDIR /home/$USER/.config/lvim
RUN mv config.lua config.lua.org
WORKDIR /home/$USER/.config/lvim
RUN mkdir colors; \
  ln -s $PROFILE_PATH/vim/config.lua ~/.config/lvim/config.lua; \
  ln -s $PROFILE_PATH/vim/space-vim-custom.vim ~/.config/lvim/colors/space-vim-custom.vim

  # lvim --headless +'autocmd User PackerComplete sleep 100m | qall' +PackerSync


### create symlinks
RUN \
  ln -s $PROFILE_PATH/omz/_zshrc ~/.zshrc; \
  ln -s $PROFILE_PATH/_ansible.cfg ~/.ansible.cfg; \
  ln -s $PROFILE_PATH/_flake8 ~/.config/flake8; \
  ln -s $PROFILE_PATH/_gitconfig ~/.gitconfig; \
  ln -s $PROFILE_PATH/_gitignore_global ~/.gitignore_global; \
  ln -s $PROFILE_PATH/_shellcheckrc ~/.shellcheckrc; \
  ln -s $PROFILE_PATH/yamllint_config ~/.config/yamllint/config; \
  ln -s $PROFILE_PATH/hadolint.yaml ~/.config/hadolint.yaml

WORKDIR $PROFILE_PATH
CMD ["zsh"]
