FROM debian

WORKDIR /root/rust

RUN apt-get update && apt-get install -y build-essential \
    && apt-get update && apt-get install -y curl \
    && apt-get update && apt-get install -y git \
    && apt-get update && apt-get install ripgrep -y \
    && apt-get update && apt-get install zsh -y \
    && apt-get update && apt-get install tmux -y \
    && apt-get update && apt-get install htop -y

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
