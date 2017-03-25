FROM debian:jessie
WORKDIR /root
RUN apt-get update && apt-get -y install sudo
RUN apt-get -y install vim zsh curl tmux git-core
VOLUME /root/dotfiles
CMD cd dotfiles && ./setup.sh && /bin/zsh
