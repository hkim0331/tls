From ubuntu:22.10

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    && apt-get update \
    && apt-get install -y sudo apt-utils git sqlite3 libedit2 racket \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# TODO: enable next line before pushing this image up
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

USER $USERNAME
WORKDIR /home/$USERNAME
RUN raco pkg install --auto racket-langserver

CMD ["racket"]
