FROM ubuntu:20.04

### Base system packages
RUN apt-get update; \
  DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends \
    software-properties-common; \
    add-apt-repository --yes ppa:neovim-ppa/stable; \
  DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends \
    build-essential \
    curl \
    dirmngr \
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
    neovim \
    python3-pip \
    ripgrep \
    tk-dev \
    unzip \
    wget \
    xz-utils \
    zlib1g-dev \
    zsh \
  && apt-get autoremove -y; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/*; \
  LC_ALL="en_US.UTF-8" locale-gen en_US.UTF-8

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

### asdf
ENV PATH="${PATH}:/root/.asdf/shims:/root/.asdf/bin"
RUN git clone https://github.com/asdf-vm/asdf.git \
  ~/.asdf --branch v0.8.0
### Node
RUN asdf plugin-add nodejs \
  && asdf install nodejs 15.14.0 \
  && asdf global nodejs 15.14.0
### Python
RUN asdf plugin-add python \
  && asdf install python 3.9.1 \
  && asdf global python 3.9.1
RUN pip install --no-cache-dir --upgrade pip \
    ansible \
    ansible-lint \
    autopep8 \
    ipython \
    isort \
    flake8 \
    yamllint \
    yapf

### Make directories
RUN mkdir -p \
  ~/.config/coc \
  ~/.config/nvim \
  ~/.config/yamllint \
  ~/development \
  ~/.vim/_temp \
  ~/.vim/bundle

### clone repo
WORKDIR /root/development/profile
RUN git clone https://github.com/scottrbaxter/profile.git /root/development/profile; \
  git submodule sync && git submodule update --init --recursive --depth 1

### install oh-my-zsh
RUN wget -P /tmp https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh \
 && chmod 0755 /tmp/install.sh \
 && /tmp/install.sh \
 && rm /tmp/install.sh \
 && mv ~/.zshrc ~/.zshrc.org

### install hadolint
RUN wget -qO /usr/local/bin/hadolint \
  https://github.com/hadolint/hadolint/releases/download/v2.1.0/hadolint-Linux-x86_64 \
  && chmod 0755 /usr/local/bin/hadolint

### Powerlevel10k
ENV PROFILE_PATH=/root/development/profile
WORKDIR $PROFILE_PATH/omz/custom/themes/powerlevel10k/gitstatus
RUN ./install

### create symlinks
RUN ln -s $PROFILE_PATH/omz/_zshrc ~/.zshrc; \
  ln -s $PROFILE_PATH/_ansible.cfg ~/.ansible.cfg; \
  ln -s $PROFILE_PATH/_flake8 ~/.config/flake8; \
  ln -s $PROFILE_PATH/_gitconfig ~/.gitconfig; \
  ln -s $PROFILE_PATH/_gitignore_global ~/.gitignore_global; \
  ln -s $PROFILE_PATH/_shellcheckrc ~/.shellcheckrc; \
  ln -s $PROFILE_PATH/yamllint_config ~/.config/yamllint/config; \
  ln -s $PROFILE_PATH/hadolint.yaml ~/.config/hadolint.yaml; \
  ln -s $PROFILE_PATH/vim/_vimrc ~/.vimrc; \
  ln -s $PROFILE_PATH/vim/_vimrc ~/.config/nvim/init.vim; \
  ln -s $PROFILE_PATH/vim/_vim/coc-settings.json ~/.vim/coc-settings.json

### install vim-plug
RUN curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# using '|| :' cuz 'colorscheme space-vim-dark' is not yet installed
RUN nvim -E -s -c "source $HOME/.vimrc" -c PlugInstall -c qall || :

### Coc
RUN nvim +'CocInstall -sync coc-json coc-pyright coc-tsserver' +qall \
  && nvim +CocUpdateSync +qall

WORKDIR /root
CMD ["zsh"]
