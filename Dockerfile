FROM ubuntu:20.04

### Provision System
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends \
    ack \
    build-essential \
    cmake \
    curl \
    dkms \
    git \
    golang \
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
    mono-complete \
    python-pexpect \
    python3-dev \
    python3-pip \
    rake \
    ripgrep \
    tk-dev \
    unzip \
    vim \
    vim-nox \
    wget \
    xz-utils \
    zlib1g-dev \
    zsh \
  && LC_ALL="en_US.UTF-8" locale-gen en_US.UTF-8

### iterm shell integration
RUN wget -P /tmp https://iterm2.com/misc/install_shell_integration.sh \
  && chmod 0755 /tmp/install_shell_integration.sh \
  && /tmp/install_shell_integration.sh \
  && rm /tmp/install_shell_integration.sh

### Make directories
RUN mkdir -p \
  ~/.config/yamllint \
  ~/development \
  ~/.vim/_temp \
  ~/.vim/bundle

### clone profile repo
WORKDIR /root/development/profile
# TODO: remember to remove this when merging to master
RUN git clone -b vundle https://github.com/scottrbaxter/profile.git \
  ~/development/profile
RUN git submodule sync \
  && git submodule update --init --recursive --depth 1

### install oh-my-zsh
RUN wget -P /tmp https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh \
 && chmod 0755 /tmp/install.sh \
 && /tmp/install.sh \
 && rm /tmp/install.sh \
 && mv ~/.zshrc ~/.zshrc.org

### create symlinks
ENV PROFILE_PATH="/root/development/profile"
RUN ln -s "$PROFILE_PATH/omz/dot_zshrc" ~/.zshrc \
  && ln -s "$PROFILE_PATH/dot_ansible.cfg" ~/.ansible.cfg \
  && ln -s "$PROFILE_PATH/dot_flake8" ~/.config/flake8 \
  && ln -s "$PROFILE_PATH/dot_gitconfig" ~/.gitconfig \
  && ln -s "$PROFILE_PATH/dot_gitignore_global" ~/.gitignore_global \
  && ln -s "$PROFILE_PATH/dot_janus/space-vim-dark" ~/.vim/bundle/space-vim-dark \
  && ln -s "$PROFILE_PATH/dot_shellcheckrc" ~/.shellcheckrc \
  && ln -s "$PROFILE_PATH/dot_vimrc" ~/.vimrc \
  && ln -s "$PROFILE_PATH/yamllint_config" ~/.config/yamllint/config

### ~/.ssh/config

### Install pyenv/pip packages
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv \
  && git clone https://github.com/pyenv/pyenv-virtualenv.git \
    ~/.pyenv/plugins/pyenv-virtualenv
RUN PYENV_ROOT="/root/.pyenv" \
  && PATH="$PYENV_ROOT/bin:$PATH" \
  && eval "$(pyenv init -)" \
  && pyenv install 3.9.1 \
  && pyenv global 3.9.1 \
  && pip install --no-cache-dir --upgrade pip \
    ansible \
    ansible-lint \
    autopep8 \
    ipython \
    isort \
    flake8 \
    yamllint \
    yapf
WORKDIR /root/.pyenv
RUN src/configure && \
  make -C src

### Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv

### Node / NVM
RUN wget -P /tmp https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh \
  && chmod 0755 /tmp/install.sh \
  && /tmp/install.sh \
  && rm /tmp/install.sh
RUN bash -c ". /root/.nvm/nvm.sh && nvm install node" # latest

### install vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git \
  /root/.vim/bundle/Vundle.vim
# RUN vim -E +PlugInstall +visual +qall
RUN vim -E -c "source $HOME/.vimrc" -c PluginInstall -c qall

### Install YouCompleteMe
WORKDIR /root/.vim/bundle/YouCompleteMe
# RUN python3 install.py \
RUN bash -c ". /root/.nvm/nvm.sh && python3 install.py \
  --clangd-completer \
  --clang-completer \
  --ts-completer \
  --go-completer"

### Install AWS CLI version 2
WORKDIR /tmp
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
  && unzip awscli-exe-linux-x86_64.zip \
  && ./aws/install \
  && rm -rf aws awscli-exe-linux-x86_64.zip

### Cleanup
RUN apt-get remove --purge -y \
    build-essential \
    cmake \
    dkms \
    libbz2-dev \
    libffi-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    llvm \
    make \
    mono-complete \
    python-pexpect \
    python3-dev \
    python3-pip \
    rake \
    tk-dev \
    vim-nox \
    xz-utils \
    zlib1g-dev \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

### Successfully load profile from /root/.zshrc
WORKDIR "/root"
CMD ["zsh"]
