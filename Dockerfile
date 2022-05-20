FROM ubuntu:20.04
LABEL description="profile"

ARG USER=ubuntu
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

### Node
ARG NVM_DIR="/home/$USER/.nvm"
ARG NODE_VERSION="v16.14.2"
RUN ( git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"; \
  cd "$NVM_DIR"; \
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)` \
  ) && \. "$NVM_DIR/nvm.sh"; \
  nvm install ${NODE_VERSION}; \
  nvm alias default ${NODE_VERSION}; \
  npm install -g aws-cdk neovim tree-sitter-cli

### Python
ENV PYENV_ROOT="/home/$USER/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH:/home/$USER/.local/bin"
RUN git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT; \
  git clone https://github.com/pyenv/pyenv-virtualenv.git ${PYENV_ROOT}/plugins/pyenv-virtualenv;
RUN  eval "$(pyenv init --path)"; \
  cd ~/.pyenv; \
  src/configure; \
  make -C src; \
  pyenv install 3.10.2; \
  pyenv global 3.10.2; \
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
  git checkout -b lunarvim origin/lunarvim; \
  git submodule sync && git submodule update --init --recursive --depth 1

### install oh-my-zsh
RUN wget -q -P /tmp https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh; \
  chmod 0755 /tmp/install.sh; \
  /tmp/install.sh; \
  rm /tmp/install.sh; \
  mv ~/.zshrc ~/.zshrc.org

### Powerlevel10k
WORKDIR $PROFILE_PATH/omz/custom/themes/powerlevel10k/gitstatus
RUN ./install

### LunarVim
ARG LV_BRANCH=rolling
WORKDIR /
RUN curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install-neovim-from-release | bash -x && \
  LV_BRANCH=${LV_BRANCH} curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install.sh | bash -s -- --no-install-dependencies
# RUN wget -q https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh; \
#   bash install.sh --no-install-dependencies \
#   && rm install.sh
WORKDIR /home/$USER/.config/lvim
RUN mv config.lua config.lua.org
WORKDIR /home/$USER/.config/lvim
RUN mkdir colors; \
  ln -s $PROFILE_PATH/vim/config.lua ~/.config/lvim/config.lua; \
  ln -s $PROFILE_PATH/vim/space-vim-custom.vim ~/.config/lvim/colors/space-vim-custom.vim; \
  lvim --headless +'autocmd User PackerComplete sleep 100m | qall' +PackerSync


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
