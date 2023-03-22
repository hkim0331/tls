From ubuntu:jammy

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    && apt-get update \
    && apt-get install -y sudo apt-utils racket libedit2 \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# error
# Resolving "racket-langserver" via https://download.racket-lang.org/releases/8.2/catalog/
# ssl-make-client-context: requested protocol not supported;
# SSL not available; check `ssl-load-fail-reason'

# RUN raco pkg install racket-langserver

USER $USERNAME

CMD ["racket"]
