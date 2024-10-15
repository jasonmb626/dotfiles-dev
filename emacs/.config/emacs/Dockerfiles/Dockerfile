FROM opensuse/tumbleweed:latest

ARG UID=1000
ARG GID=1000

#These (esp the LANG variable) make sure tmux outputs UTF-8. Needed for special chars
ENV GDM_LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV XDG_CACHE_HOME=/home/app/.local/cache
ENV ZETTEL_BASE=/home/app/Documents/zettelkasten
ENV ORG_TEMPLATES_DIR=/home/app/.config/emacs/templates

RUN zypper -n refresh \
    && zypper -n install \
              openssh\
              tmux \
              emacs-nox\
              stow \
              ripgrep\
              sudo \
              fd \
              mercurial \
              git \
              awk \
              pciutils \
              bc \
              vim \
              firewalld \
              unzip
RUN echo -e 'PasswordAuthentication yes\nPermitEmptyPasswords yes' >> /etc/ssh/sshd_config \
    && ssh-keygen -A \
    && rm -f /etc/localtime 2>dev/null \
    && ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime \
    && groupadd -g ${GID} app \
    && useradd -u ${UID} -g 1000 app \
    && echo "app:" | chpasswd -e \
    && mkdir -p /etc/sudoers.d && echo 'app ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/app \
    && chmod 777 /tmp \
    && mkdir -p /home/app/.local/share/themes && mkdir -p /home/app/.bin \
    && curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /home/app/.bin \
    && git clone https://github.com/dracula/oh-my-posh.git /tmp/oh-my-posh-dracula \
    && cp /tmp/oh-my-posh-dracula/dracula.omp.json /home/app/.local/share/themes \
    && git clone https://github.com/jasonmb626/dotfiles-dev.git /home/app/.dotfiles \
    && mkdir -p /home/app/Documents/zettelkasten \
    && echo -e "export GDM_LANG=en_US.UTF-8\nexport LANG=en_US.UTF-8\nexport XDG_CACHE_HOME=/home/app/.local/cache\nexport ZETTEL_BASE=/home/app/Documents/zettelkasten\nexport ORG_TEMPLATES_DIR=/home/app/.config/emacs/templates" >> /home/app/.profile \
    && chown -R app:app /home/app \
    && chmod 777 /tmp

USER app:app
WORKDIR /home/app/.dotfiles
RUN rm -f /home/app/.bashrc && stow bash \
    && stow tmux \
    && git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm \
    && stow emacs \
    && mkdir -p /home/app/.config/emacs/eln-cache && mkdir -p /home/app/.config/emacs/elpaca && mkdir -p /home/app/.config/emacs/bin \
    && touch /home/app/.config/emacs/recentf && touch /home/app/.config/emacs/projectile-bookmarks.eld && touch /home/app/.config/emacs/sessions
WORKDIR /home/app/Documents/zettelkasten
CMD ["bash"]

#If cloning rainbow-mode hangs exit and try cloning it manually via https instead of git:
#git clone --single-branch --branch externals/rainbow-mode https://git.savannah.gnu.org/git/emacs/elpa.git /home/app/.config/emacs/elpaca/repos/rainbow-mode
#If lsp-mode hangs/fails try cloning it manually with depth 1:
#git clone --depth 1 https://github.com/emacs-lsp/lsp-mode.git /home/app/.config/emacs/elpaca/repos/lsp-mode/

#Consider limiting IP ssh access
#https://serverfault.com/questions/680780/block-all-but-a-few-ips-with-firewalld
#firewall-cmd --zone=internal --add-service=ssh
#firewall-cmd --zone=internal --add-source=192.168.56.105/32
#firewall-cmd --zone=internal --add-source=192.168.56.120/32
#firewall-cmd --zone=public --remove-service=ssh
