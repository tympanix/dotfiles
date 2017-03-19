FROM debian:jessie
WORKDIR /root
RUN apt-get update && apt-get install sudo
COPY . dotfiles
