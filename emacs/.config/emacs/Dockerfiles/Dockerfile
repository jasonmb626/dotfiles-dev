FROM alpine:latest

ARG UID=1000
ARG GID=1000

#These (esp the LANG variable) make sure tmux outputs UTF-8. Needed for special chars
ENV GDM_LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV XDG_CACHE_HOME=/home/app/.local/cache
ENV ZETTEL_BASE=/home/app/Documents/zettelkasten
ENV ORG_TEMPLATES_DIR=/home/app/.config/emacs/templates

COPY requirements.txt /tmp
RUN apk update -U \
    && apk add -U tzdata py3-pip npm bash\
        lua-dev luarocks stylua\
        lazygit openssh\
        tmux neovim neovim-doc emacs-nox\
        stow \
        procps\
        ripgrep\
        alpine-sdk\
        tree-sitter tree-sitter-cli\
        wl-clipboard\
        sudo \
        unzip gzip fd mercurial wget\
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config \
    && ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime \
    && addgroup -g ${GID} app \
    && adduser -D -u ${UID} -G app -s /bin/zsh app \
    && passwd -d app \
    && mkdir -p /etc/sudoers.d && echo 'app ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/app \
    && chmod 777 /tmp \
    && python3 -m venv /home/app/.venvs/app \
    && source /home/app/.venvs/app/bin/activate\
    && pip3 install --upgrade pip \
    && pip3 install -r /tmp/requirements.txt && rm /tmp/requirements.txt \
    && pip3 install pynvim pylint\
    && npm install -g neovim\
    && mkdir -p /home/app/.local \
    && git clone https://github.com/jasonmb626/my-lazyvim-starter.git /home/app/.config/nvim \
    && git clone https://github.com/jasonmb626/dotfiles-dev.git /home/app/.dotfiles \
    && git clone --recursive https://github.com/andresgongora/synth-shell.git /tmp/synth-shell \
    && chmod +x /tmp/synth-shell/setup.sh \
    && echo -e "i\ns\ny\ny\ny\ny\ny" | /tmp/synth-shell/setup.sh \
    && mkdir -p /home/app/Documents/zettelkasten \
    && chown -R app:app /home/app \
    && chmod 777 /tmp
      
USER app:app
WORKDIR /home/app/.dotfiles
RUN stow bash \
    && stow tmux \
    && stow emacs \
    && mkdir -p /home/app/.config/emacs/eln-cache && mkdir -p /home/app/.config/emacs/elpaca && mkdir -p /home/app/.config/emacs/bin \
    && touch /home/app/.config/emacs/recentf && touch /home/app/.config/emacs/projectile-bookmarks.eld && touch /home/app/.config/emacs/sessions
WORKDIR /home/app/Documents/zettelkasten
CMD ["tmux"]
