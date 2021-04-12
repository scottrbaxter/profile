# Custom developer profile for various utilities

### deploy current profile in virtualbox / ubuntu 16.04

Packages required:
- virtualbox
- vagrant
- ansible

Easiest way to install these on MacOS is with [homebrew](https://brew.sh/), then run:

`brew install virtualbox vagrant ansible`

Additionally, you will need to generate a private key:

`ssh-keygen -b 4096 -t rsa -q -N "" -f ~/.ssh/id_rsa-vagrant`

To test profile with Vagrant/VirtualBox, run:

```
cd dev
vagrant up && vagrant ssh
```

Example to build a local docker image:

```
docker build -t local/profile -f ./Dockerfile .
```

Run the docker container locally:

```
docker run -it --entrypoint zsh --rm --name profile --hostname profile local/profile
```
