FROM ubuntu:20.04

### Provision System
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends \
    ack \
    build-essential \
    curl \
    dkms \
    git \
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
    python-pexpect \
    python3-pip \
    ripgrep \
    tk-dev \
    unzip \
    vim \
    wget \
    xz-utils \
    zlib1g-dev \
    zsh \
  && LC_ALL="en_US.UTF-8" locale-gen en_US.UTF-8

### Install AWS CLI version 2
WORKDIR /tmp
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
  && unzip awscli-exe-linux-x86_64.zip \
  && ./aws/install \
  && rm -rf aws awscli-exe-linux-x86_64.zip

### iterm shell integration
RUN wget -P /tmp https://iterm2.com/misc/install_shell_integration.sh \
  && chmod 0755 /tmp/install_shell_integration.sh \
  && /tmp/install_shell_integration.sh \
  && rm /tmp/install_shell_integration.sh

### Make directories
RUN mkdir -p \
  ~/.config/coc \
  ~/.config/yamllint \
  ~/development \
  ~/.vim/_temp \
  ~/.vim/bundle

### copy profile repo
COPY . /root/development/profile
WORKDIR /root/development/profile
RUN git submodule sync \
  && git submodule update --init --recursive --depth 1

### install oh-my-zsh
RUN wget -P /tmp https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh \
 && chmod 0755 /tmp/install.sh \
 && /tmp/install.sh \
 && rm /tmp/install.sh \
 && mv ~/.zshrc ~/.zshrc.org

### Powerlevel10k
ENV PROFILE_PATH=/root/development/profile
WORKDIR $PROFILE_PATH/omz/custom/themes/powerlevel10k/gitstatus
RUN ./install

### create symlinks
RUN ln -s $PROFILE_PATH/omz/_zshrc ~/.zshrc \
  && ln -s $PROFILE_PATH/_ansible.cfg ~/.ansible.cfg \
  && ln -s $PROFILE_PATH/_flake8 ~/.config/flake8 \
  && ln -s $PROFILE_PATH/_gitconfig ~/.gitconfig \
  && ln -s $PROFILE_PATH/_gitignore_global ~/.gitignore_global \
  && ln -s $PROFILE_PATH/_shellcheckrc ~/.shellcheckrc \
  && ln -s $PROFILE_PATH/_vim/coc-settings.json ~/.vim/coc-settings.json \
  && ln -s $PROFILE_PATH/_vimrc ~/.vimrc \
  && ln -s $PROFILE_PATH/yamllint_config ~/.config/yamllint/config \
  && ln -s $PROFILE_PATH/hadolint.yaml ~/.config/hadolint.yaml

### Install pyenv/pip packages
ENV PYENV_ROOT=/root/.pyenv
RUN git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT \
  && git clone https://github.com/pyenv/pyenv-virtualenv.git \
    $PYENV_ROOT/plugins/pyenv-virtualenv
RUN PATH="$PYENV_ROOT/bin:$PATH" \
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
# RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv

### Node / NVM
RUN wget -P /tmp https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh \
  && chmod 0755 /tmp/install.sh \
  && /tmp/install.sh \
  && rm /tmp/install.sh
RUN bash -c ". ~/.nvm/nvm.sh && nvm install node" # latest

### install vim-plug
RUN wget -qP /root/.vim/autoload \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# using '|| :' cuz 'colorscheme space-vim-dark' is not yet installed
RUN vim -E -s -c "source $HOME/.vimrc" -c PlugInstall -c qall || :

### Cleanup
RUN apt-get remove --purge -y \
    build-essential \
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
    python-pexpect \
    python3-pip \
    tk-dev \
    xz-utils \
    zlib1g-dev \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["zsh"]
