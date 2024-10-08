FROM alpine:latest

ARG UID=1000
ARG GID=1000

#These (esp the LANG variable) make sure tmux outputs UTF-8. Needed for special chars
ENV GDM_LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV ZDOTDIR=/home/app/.config/zsh/
ENV XDG_CACHE_HOME=/home/app/.local/cache
ENV ZETTEL_BASE=/home/app/Documents/zettelkasten
ENV ORG_TEMPLATES_DIR=/home/app/.config/emacs/templates

RUN apk add -U py3-pip npm zsh \
    && sed -i 's,root:x:0:0:root:/root:/bin/ash,root:x:0:0:root:/root:/bin/zsh,g' /etc/passwd \
    && chmod -R 777 /tmp

COPY requirements.txt /tmp
RUN apk update -U \
    && apk add -U tzdata py3-pip npm zsh\
        lua-dev luarocks stylua\
        lazygit openssh\
        tmux neovim neovim-doc emacs-nox\
        procps\
        ripgrep\
        alpine-sdk\
        tree-sitter tree-sitter-cli\
        wl-clipboard\
        sudo \
        unzip gzip fd mercurial wget\
    && ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime \
    && rm /etc/ssh/sshd_config \
    && addgroup -g ${GID} app \
    && adduser -D -u ${UID} -G app -s /bin/zsh app \
    && passwd -d app \
    && chmod 777 /tmp \
    && python3 -m venv /home/app/.venvs/app \
    && source /home/app/.venvs/app/bin/activate\
    && pip3 install --upgrade pip \
    && pip3 install -r /tmp/requirements.txt && rm /tmp/requirements.txt \
    && pip3 install pynvim pylint\
    && npm install -g neovim\
    && mkdir -p /etc/sudoers.d && echo 'app ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/app \
    && mkdir -p /home/app/.config/tmux/plugins \
    && mkdir -p /home/app/.local \
    && git clone https://github.com/tmux-plugins/tpm /home/app/.config/tmux/plugins/tpm \
    && git clone https://github.com/jasonmb626/my-lazyvim-starter.git /home/app/.config/nvim \
    && mkdir -p /home/app/Documents/zettelkasten \
    && git clone https://github.com/jasonmb626/dotfiles-dev.git /tmp/dotfiles-dev \
    && mv /tmp/dotfiles-dev/emacs /home/app/.config \
    && mkdir -p /home/app/.config/emacs/eln-cache && mkdir -p /home/app/.config/emacs/elpaca && mkdir /home/app/.config/emacs/bin \
    && touch /home/app/.config/emacs/recentf && touch /home/app/.config/emacs/projectile-bookmarks.eld && touch /home/app/.config/emacs/sessions \
    && mv /tmp/dotfiles-dev/tmux/tmux.conf /home/app/.config/tmux/tmux.conf \
    && mv /tmp/dotfiles-dev/zsh /home/app/.config/ && rm -fr /tmp/dotfiles-dev \
    && mv /home/app/.config/zsh/.zshrc /tmp/.zshrc \
    && cat <<EOF >/tmp/zshrc_preamble
    source /home/app/.venvs/app/bin/activate
    mkdir -p /home/app/.local/share/zsh
    mkdir -p /home/app/.local/share/tmux/plugins/
    if [[ "\$(ls -1 /home/app/.local/share/tmux/plugins/ | wc -l )" -eq 0 ]]; then
        /home/app/.config/tmux/plugins/tpm/scripts/install_plugins.sh
        tmux source ~/.config/tmux/tmux.conf
    fi
    sed -i 's^--vim.g.python3_host_prog = "/home/app/.venvs/app/bin/python"^vim.g.python3_host_prog = "/home/app/.venvs/app/bin/python"^' /home/app/.config/nvim/lua/config/options.lua
EOF

RUN cat /tmp/zshrc_preamble /tmp/.zshrc > /home/app/.config/zsh/.zshrc \
    && rm /tmp/zshrc_preamble /tmp/.zshrc \
    && dos2unix /home/app/.config/zsh/.zshrc \
    && touch /home/app/.config/emacs/bin/fix_melpa_entry.sh && chmod +x /home/app/.config/emacs/bin/fix_melpa_entry.sh \
    && chown -R app:app /home/app \
    && chmod 777 /tmp \
    && cat <<EOF >/home/app/.config/emacs/bin/fix_melpa_entry.sh
#!/bin/sh
sed -i -r 's^:package "lsp-mode" (.*)url "https://github.com/emacs-lsp/lsp-mode"^lsp-mode" :depth 1 \1 url "https://github.com/emacs-lsp/lsp-mode"^' ~/.config/emacs/elpaca/cache/melpa.eld
EOF
      
USER app:app
WORKDIR /home/app/Documents/zettelkasten
CMD ["tmux"]
