;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;;       in Emacs and init.el will be generated automatically!

(add-to-list 'load-path "~/.config/emacs/third-party-scripts/")

(require 'elpaca)  ;; The Elpaca Package Manager
(require 'buffer-move)   ;; Buffer-move for better window management

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(with-eval-after-load 'company
    (define-key company-active-map (kbd "<return>") nil)
      (define-key company-active-map (kbd "RET") nil)
        (define-key company-active-map (kbd "C-l") #'company-complete-selection))

(use-package diminish)

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package peep-dired
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
    (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
)

(use-package elfeed
  :config
  (setq elfeed-search-feed-face ":foreground #ffffff :weight bold"
        elfeed-feeds (quote
                       (("https://www.reddit.com/r/linux.rss" reddit linux)
                        ("https://www.reddit.com/r/commandline.rss" reddit commandline)
                        ("https://www.reddit.com/r/distrotube.rss" reddit distrotube)
                        ("https://www.reddit.com/r/emacs.rss" reddit emacs)
                        ("https://www.gamingonlinux.com/article_rss.php" gaming linux)
                        ("https://hackaday.com/blog/feed/" hackaday linux)
                        ("https://opensource.com/feed" opensource linux)
                        ("https://linux.softpedia.com/backend.xml" softpedia linux)
                        ("https://itsfoss.com/feed/" itsfoss linux)
                        ("https://www.zdnet.com/topic/linux/rss.xml" zdnet linux)
                        ("https://www.phoronix.com/rss.php" phoronix linux)
                        ("http://feeds.feedburner.com/d0od" omgubuntu linux)
                        ("https://www.computerworld.com/index.rss" computerworld linux)
                        ("https://www.networkworld.com/category/linux/index.rss" networkworld linux)
                        ("https://www.techrepublic.com/rssfeeds/topic/open-source/" techrepublic linux)
                        ("https://betanews.com/feed" betanews linux)
                        ("http://lxer.com/module/newswire/headlines.rss" lxer linux)
                        ("https://distrowatch.com/news/dwd.xml" distrowatch linux)))))
 

(use-package elfeed-goodies
  :init
  (elfeed-goodies/setup)
  :config
  (setq elfeed-goodies/entry-pane-size 0.5))

;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil
    :init      ;; tweak evil's configuration before loading it
    (setq evil-want-integration t  ;; This is optional since it's already set to t by default.
          evil-want-keybinding nil
          evil-vsplit-window-right t
          evil-split-window-below t
          evil-undo-system 'undo-redo)  ;; Adds vim-like C-r redo functionality
    (evil-mode))

(use-package evil-collection
  :after evil
  :config
  ;; Do not uncomment this unless you want to specify each and every mode
  ;; that evil-collection should works with.  The following line is here 
  ;; for documentation purposes in case you need it.  
  ;; (setq evil-collection-mode-list '(calendar dashboard dired ediff info magit ibuffer))
  (add-to-list 'evil-collection-mode-list 'help) ;; evilify help mode
  (evil-collection-init))

(use-package evil-tutor)

;; Using RETURN to follow links in Org/Evil 
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
  (setq org-return-follows-link  t)

;;Evil goggles will give visual indication of what we just did in evil mode. Especially briefly highlight what we just yanked.
(use-package evil-goggles
      :config
        (evil-goggles-mode)

           ;; optionally use diff-mode's faces; as a result, deleted text
          ;; will be highlighed with `diff-removed` face which is typically
          ;; some red color (as defined by the color theme)
          ;; other faces such as `diff-added` will be used for other actions
          (evil-goggles-use-diff-faces))

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))

(set-face-attribute 'default nil
  :font "JetBrains Mono"
  :height 110
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "FiraMono Nerd Font"
  :height 110
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "FiraMono Nerd Font Mono"
  :height 110
  :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package general
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer my/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (general-create-definer my/lleader-keys
    :states '(normal visual emacs)
    :keymaps 'org-mode-map
    :prefix "," ;; set leader
  )

  (my/lleader-keys
   "," 'org-ctrl-c-ctrl-c
   "RET" 'org-ctrl-c-ret
   "[" 'org-agenda-file-to-front
   "]" 'org-remove-file
   "a" 'org-agenda
   "C" 'org-capture
   )
  
  (my/lleader-keys
    "b" '(:ignore t :wk "babel")
    "b f" 'org-babel-tangle-file
    "b t" 'org-babel-tangle
  )

  (my/lleader-keys
    "d" '(:ignore t :wk "dates")
    "d d" 'org-deadline
    "d s" 'org-schedule
    "d t" 'org-time-stamp
    "d T" 'org-time-stamp-inactive
  )

  (my/lleader-keys
    "e" '(:ignore t :wk "export")
  )

  (my/lleader-keys
    "f" '(:ignore t :wk "feeds")
  )

  (my/lleader-keys
    "i" '(:ignore t :wk "insert")
    "i b" 'org-insert-structure-template
    "i d" 'org-insert-drawer
    "i e" 'org-set-effors
    "i f" 'org-footnote-new
    "i h" 'org-insert-heading
    "i i" 'org-insert-item
    "i l" 'org-insert-link
    "i n" 'org-insert-note
    "i p" 'org-set-property
    "i r" 'org-rich-yank
    "i s" 'org-insert-subheading
    "i t" 'org-set-tags-command
    "i H" 'org-insert-heading-after-current
    "i K" 'insert-keybinding-org
    "i L" 'org-cliplink
    "i D" '(:ignore t :wk "download")
  )

  (my/lleader-keys
    "m" '(:ignore t :wk "more")
  )

  (my/lleader-keys
    "s" '(:ignore t :wk "trees/subtrees")
    "s a" 'org-toggle-archive-tag
    "s b" 'org-tree-to-indirect-buffer
    "s d" 'org-cut-subtree
    "s h" 'org-promote-subtree
    "s j" 'org-move-subtree_down
    "s k" 'org-move-subtree_up
    "s l" 'org-demote-subtree
    "s n" 'org-narrow-to-subtree
    "s p" 'org-paste-subtree
    "s r" 'org-refile
    "s s" 'org-sparse-tree
    "s w" 'widen
    "s y" 'org-copy-subtree
    "s A" 'org-archive-subtree-default
    "s S" 'org-sort
  )

  (my/lleader-keys
    "t" '(:ignore t :wk "tables")
    "t a" 'org-table-align
    "t b" 'org-table-blank-field
    "t c" 'org-table-convert
    "t e" 'org-table-eval-formula
    "t f" 'org-table-fields-info
    "t h" 'org-table-previous-field
    "t j" 'org-table-next-row
    "t l" 'org-table-next-field
    "t n" 'org-table-create
    "t p" 'org-plot/gnuplot
    "t r" 'org-table-reclalculate
    "t s" 'org-table-sort-time
    "t w" 'org-table-wrap-region
    "t E" 'org-table-export
    "t H" 'org-table-move-column-left
    "t I" 'org-table-import
    "t J" 'org-table-move-row-down
    "t K" 'org-table-move-row-up
    "t L" 'org-table-move-columns-left
    "t N" 'org-table-create-with-table.el
    "t R" 'org-table-recalculate-buffer-t...
    "t d" '(:ignore t :wk "delete")
    "t i" '(:ignore t :wk "insert")
    "t t" '(:ignore t :wk "toggle")
  )

  (my/lleader-keys
    "x" '(:ignore t :wk "text")
    "x o" 'org-open-at-point
  )

  (my/lleader-keys
    "c" '(:ignore t :wk "clocks")
    "c c" 'org-clock-cancel
    "c d" 'org-clock-display
    "c e" 'org-evaluate-time-range
    "c g" 'org-clock-goto
    "c i" 'org-clock-in
    "c j" 'my/org-clock-jump-to-current-clock
    "c o" 'org-clock-out
    "c p" 'org-pomodoro
    "c r" 'org-resolve-clocks
    "c I" 'org-clock-in-last
    "c R" 'org-clock-report
  )

  (my/lleader-keys
    "T" '(:ignore t :wk "toggles")
    "T c" 'org-toggle-checkbox
    "T e" 'org-toggle-pretty-entities
    "T i" 'org-toggle-inline-images
    "T l" 'org-toggle-link-display
    "T n" 'org-num-mode
    "T t" 'org-show-todo-tree
    "T x" 'org-latex-preview
    "T T" 'org-todo
  )

  (my/leader-keys
    "SPC" 'counsel-M-x
    "RET" 'org-insert-heading
    "." 'find-file
    "=" 'perspective-map ;; Lists all the perspective keybindings
    "TAB TAB" 'comment-line
    "u" 'universal-argument)

  (my/leader-keys
    "b" '(:ignore t :wk "Bookmarks/Buffers")
    "b b" 'ido-switch-to-buffer
    "b c" 'clone-indirect-buffer
    "b C" 'clone-indirect-buffer-other-window
    "b d" 'bookmark-delete
    "b i" 'ibuffer
    "b k" 'kill-current-buffer
    "b K" 'kill-some-buffers
    "b l" 'list-bookmarks
    "b m" 'bookmark-set
    "b n" 'next-buffer
    "b p" 'previous-buffer
    "b r" 'revert-buffer
    "b R" 'rename-buffer
    "b s" 'basic-save-buffer
    "b S" 'save-some-buffers
    "b w" 'bookmark-save)

  (my/leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" 'dired
    "d j" 'dired-jump
    "d n" 'neotree-dir
    "d p" 'peep-dired)

  (my/leader-keys
    "e" '(:ignore t :wk "Eshell/Evaluate")    
    "e b" 'eval-buffer
    "e d" 'eval-defun
    "e e" '(eval-expression)
    "e l" 'eval-last-sexp
    "e r" 'eval-region)

  (my/leader-keys
    "f" '(:ignore t :wk "Files")    
    "f c" '((lambda () (interactive)
              (find-file "~/.config/emacs/config.org")) 
            :wk "Open emacs config.org")
    "f e" '((lambda () (interactive)
              (dired "~/.config/emacs/")) 
            :wk "Open user-emacs-directory in dired")
    "f d" '(:ignore t :wk "Dotfiles")
    "f D" 'find-grep-dired
    "f g" 'counsel-grep-or-swiper
    "f i" '((lambda () (interactive)
              (find-file "~/.config/emacs/init.el")) 
            :wk "Open emacs init.el")
    "f j" '((lambda () (interactive)
              (find-file (concat org-directory "/journal.org")) )
            :wk "Open emacs journal.org")
    "f J" 'counsel-file-jump
    "f l" 'counsel-locate
    "f r" 'counsel-recentf
    "f u" 'sudo-edit-find-file
    "f U" 'sudo-edit)

 (my/leader-keys
    "h" '(:ignore t :wk "Help")
    "h a" 'counsel-apropos
    "h b" 'describe-bindings
    "h c" 'describe-char
    "h d" '(:ignore t :wk "Emacs documentation")
    "h d a" 'about-emacs
    "h d d" 'view-emacs-debugging
    "h d f" 'view-emacs-FAQ
    "h d m" 'info-emacs-manual
    "h d n" 'view-emacs-news
    "h d o" 'describe-distribution
    "h d p" 'view-emacs-problems
    "h d t" 'view-emacs-todo
    "h d w" 'describe-no-warranty
    "h e" 'view-echo-area-messages
    "h f" 'describe-function
    "h F" 'describe-face
    "h g" 'describe-gnu-project
    "h i" 'info
    "h I" 'describe-input-method
    "h k" 'describe-key
    "h l" 'view-lossage
    "h L" 'describe-language-environment
    "h m" 'describe-mode
    "h r" '(:ignore t :wk "Reload")
    "h r r" '((lambda () (interactive)
                (load-file "~/.config/emacs/init.el")
                (ignore (elpaca-process-queues)))
              :wk "Reload emacs config")
    "h t" 'load-theme
    "h v" 'describe-variable
    "h w" 'where-is
    "h x" 'describe-command)

  (my/leader-keys
    "m" '(:ignore t :wk "Org")
    "m a" 'org-agenda
    "m e" 'org-export-dispatch
    "m i" 'org-toggle-item
    "m t" 'org-todo
    "m B" 'org-babel-tangle
    "m T" 'org-todo-list)

  (my/leader-keys
    "m b" '(:ignore t :wk "Tables")
    "m b -" 'org-table-insert-hline)

  (my/leader-keys
    "m d" '(:ignore t :wk "Date/deadline")
    "m d t" 'org-time-stamp
    "m d i" 'org-clock-in
    "m d o" 'org-clock-out)

  (my/leader-keys
    "o" '(:ignore t :wk "Open")
    "o d" 'dashboard-open
    "o e" 'elfeed
    "o f" 'make-frame
    "o F" 'select-frame-by-name)

  ;; projectile-command-map already has a ton of bindings 
  ;; set for us, so no need to specify each individually.
  (my/leader-keys
    "p" 'projectile-command-map)

  (my/leader-keys
    "s" '(:ignore t :wk "Search")
    "s d" 'dictionary-search
    "s m" 'man
    "s t" 'tldr
    "s w" 'woman)

  (my/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t e" 'eshell-toggle
    "t f" 'flycheck-mode
    "t l" 'display-line-numbers-mode
    "t n" 'neotree-toggle
    "t o" 'org-mode
    "t r" 'rainbow-mode
    "t t" 'visual-line-mode)

  (my/leader-keys
    "w" '(:ignore t :wk "Windows")
    ;; Window splits
    "w c" 'evil-window-delete
    "w n" 'evil-window-new
    "w s" 'evil-window-split
    "w v" 'evil-window-vsplit
    ;; Window motions
    "w h" 'evil-window-left
    "w j" 'evil-window-down
    "w k" 'evil-window-up
    "w l" 'evil-window-right
    "w w" 'evil-window-next
    ;; Move Windows
    "w H" 'buf-move-left
    "w J" 'buf-move-down
    "w K" 'buf-move-up
    "w L" 'buf-move-right)
)

(setq org-todo-keywords
      '((sequence "TODO(t!)" "NEXT(n!)" "IN PROGRESS(i!)" "BLOCKED(b@/!)" "PEND SET STATE(p!)" "TO DELEGATE(2!)" "DELEGATED(g@/!)" "FOLLOWUP(f!)" "FORWARDED(>@/!)" "ADJOURNED(a!)" "|" "CANCELED(c!)" "DONE(d!)")))

  (setq org-todo-keyword-faces
        '(("TODO" . org-warning)
          ("IN-PROGRESS" . "#E35DBF")
          ("CANCELED" . (:foreground "white" :background "#4d4d4d" :weight bold))
          ("DELEGATED" . "pink")
          ("NEXT" . "#008080")))

;;TODO check this out/change entries
  (use-package hl-todo
    :hook ((org-mode . hl-todo-mode)
           (prog-mode . hl-todo-mode))
    :config
    (setq hl-todo-highlight-punctuation ":"
          hl-todo-keyword-faces
          `(("TODO"       warning bold)
            ("FIXME"      error bold)
            ("HACK"       font-lock-constant-face bold)
            ("REVIEW"     font-lock-keyword-face bold)
            ("NOTE"       success bold)
            ("DEPRECATED" font-lock-doc-face bold))))

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (or (string-equal (buffer-file-name)
                      (concat (expand-file-name user-emacs-directory) "config.org"))
            (string-equal (buffer-file-name)
                      (expand-file-name "~/git/dotfiles-dev/emacs/config.org")))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda ()
                          (add-hook 'after-save-hook #'efs/org-babel-tangle-config)
                          (evil-define-key 'normal org-mode-map (kbd "t") 'org-todo)))

(with-eval-after-load 'org
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
      (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(use-package git-timemachine
  :after git-timemachine
  :hook (evil-normalize-keymaps . git-timemachine-hook)
  :config
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-j") 'git-timemachine-show-previous-revision)
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-k") 'git-timemachine-show-next-revision)
)

(use-package counsel
  :after ivy
  :diminish
  :config 
    (counsel-mode)
    (setq ivy-initial-inputs-alist nil)) ;; removes starting ^ regex in M-x

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-s" . swiper)
   ("C-c C-r" . ivy-resume)
   ("C-x b" . ido-switch-buffer)
   ("C-x B" . ivy-switch-buffer-other-window)
   :map ivy-minibuffer-map
   ("TAB" . ivy-alt-done)
   ("C-l" . ivy-alt-done)
   ("C-j" . ivy-next-line)
   ("C-k" . ivy-previous-line)
   :map ivy-switch-buffer-map
   ("C-k" . ivy-previous-line)
   ("C-l" . ivy-done)
   ("C-d" . ivy-switch-buffer-kill)
   :map ivy-reverse-i-search-map
   ("C-k" . ivy-previous-line)
   ("C-d" . ivy-reverse-i-search-kill))
  :diminish
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode)
  ;; by default counsel-M-x starts with ^, which means your fuzzy search must start with what you type
  (ivy-configure 'counsel-M-x
      :initial-input ""))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                                   'ivy-rich-switch-buffer-transformer))

(use-package haskell-mode)
(use-package lua-mode)
(use-package php-mode)

(defun my/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . my/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(global-set-key [escape] 'keyboard-escape-quit)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-bar-width 5    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name

(use-package neotree
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 55
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action) 
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(eval-after-load 'org-indent '(diminish 'org-indent-mode))

(with-eval-after-load 'org
    ;; This is needed as of Org 9.2
    (require 'org-tempo)

    (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
    (add-to-list 'org-structure-template-alist '("py" . "src python")))

(setq org-directory (or (getenv "ZETTEL_BASE") "~/org"))
(setq templates_dir (or (getenv "ORG_TEMPLATES_DIR") "~/org/templates"))

(setq org-track-ordered-property-with-tag t)
(setq org-use-property-inheritance t)
(setq org-log-into-drawer "LOGBOOK") ;when adding a note, put them in logbook drawer
(setq org-log-reschedule 'time) ;puts a note in logbook drawer when a task is rescheudled
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-M-RET-may-split-line nil)
(setq org-ellipsis " ▾")
(setq org-refile-targets '((org-agenda-files :maxlevel . 2))) ; any agenda file will show up in the list when choosing to refile

(setq org-clock-in-switch-to-state "IN PROGRESS")
(setq org-clock-out-switch-to-state "PEND SET STATE")
(defun my/org-clock-jump-to-current-clock ()
  (interactive)
  (org-clock-jump-to-current-clock))

(setq org-tag-alist '(("NEW" . ?N)
                      (:startgroup . nil)
                      ("INCIDENT" . ?i)
                      ("NUCLEUS-INC" . ?n)
                      ("TRAINING" . ?r)
                      ("SCRIPTING" . ?s)
                      ("CUST_MEETING" . ?c)
                      ("TCS_MEETING" . ?t)
                      ("CRQ" . ?C)
                      ("MISC" . ?m)
                      ("W-O-REQ" . ?w)))

;; Save Org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)
(advice-add 'org-capture :after (lambda ()
                                  (interactive)
                                  (org-save-all-org-buffers)
                                  ;; (Re)set org-agenda files. Spacemacs auto-updates the list list above in custom-set-variables
                                  (setq org-agenda-files ;Adds all .org files to agenda unless they are in the archive folder
                                        (seq-filter (lambda(x) 
                                                    (not (string-match "/archive/"(file-name-directory x)))
                                                    (not (string-match "/03-resources/"(file-name-directory x))))
                                                    (directory-files-recursively org-directory "\\.org$")
                                                    ))
                                  ))

(defun my/generate-new-store-file-name () "Ask for a title and generate a file name based on it"
       (interactive)
       (let* ((store_nbr (read-string "Store #: "))
              (my-path (concat
                        "2-areas/str"
                        store_nbr
                        ".org")))
         (setq my/org-capture-store_nbr store_nbr)
         (setq my/org-capture-store_nbr-file_path my-path)) ; Save variable to be used later in the template
       my/org-capture-store_nbr-file_path)
(defun my/ask-store-nbr-inc () "Ask for a title and generate a file name based on it"
       (interactive)
       (let ((store_nbr (read-string "Store #: "))
              (inc (read-string "Incident #: ")))
         (setq my/org-capture-store_nbr store_nbr)
         (setq my/org-capture-inc inc)) ; Save variable to be used later in the template
       (concat "str" my/org-capture-store_nbr))
(defun my/generate-new-script-file-name () "Ask for a title and generate a file name based on it"
       (let* ((script_name (read-string "Script Name: "))
              (my-path (concat
                        "1-projects/script_"
                        script_name
                        ".org")))
         (setq my/org-capture-script-name script_name)
         (setq my/org-capture-script-file-path my-path)) ; Save variable to be used later in the template
       my/org-capture-script-file-path)

(setq org-capture-templates
      `(
        ("S" "Store" entry
         (file (lambda() (interactive) (my/generate-new-store-file-name)))
         (file  ,(concat templates_dir "/store-template.txt")))
        ("I" "Incident" entry
         (file+function buffer-file-name (lambda () 
                                          (org-back-to-heading)
                                          (org-element-property :end (org-element-at-point))))
         (file  ,(concat templates_dir "/inc-template.txt")))
        ("t" "TODO entry" entry
         (file+headline "journal.org" "Capture")
         "* TODO %^{Description} :NEW:\n  Desired outcome: %?\n  :LOGBOOK:\n  - Added: %U\n  :END:"
         :empty-lines-before 1)
        ("i" "Incoming Phone call" entry
         (file+headline "journal.org" ,(format-time-string "%Y-%m-%d %A"))
         (file "templates/in-call-template.txt"))
        ("o" "Outgoing Phone call" entry
         (file+headline "journal.org" "Capture")
         (file  ,(concat templates_dir "/out-call-template.txt")))
        ("e" "Email" entry
         (file+headline "journal.org" "Capture")
         (file  ,(concat templates_dir "/email-template.txt")))
        ("s" "Script" entry
         (file (lambda() (interactive) (my/generate-new-script-file-name)))
         (file  ,(concat templates_dir "/script-template.txt")))
        ("m" "Meeting" entry
         (file+headline "journal.org" "Capture")
         (file  ,(concat templates_dir "/meeting-template.txt")))
        ("j" "Journal entry" entry
         (file+headline "journal.org" ,(format-time-string "%Y-%m-%d %A"))
         "* %U - %^{Activity}")
        ("d" "Daily plan" plain
         (file+headline "journal.org" ,(format-time-string "%Y-%m-%d %A"))
         (file  ,(concat templates_dir "/tpl-daily-plan.txt"))
         :immediate-finish t)
        ("w" "Daily plan" plain
         (file+headline "journal.org" ,(format-time-string "%Y-%m-%d %A"))
         (file  ,(concat templates_dir "/tpl-weekly-plan.txt"))
         :immediate-finish t)
        ("m" "Monthly plan" plain
         (file+headline "journal.org" ,(format-time-string "%Y-%m-%d %A"))
         (file  ,(concat templates_dir "/tpl-monthly-plan.txt"))
         :immediate-finish t)
        ))

(setq org-agenda-dim-blocked-tasks t)
(setq org-agenda-window-setup 'only-window)
(setq org-agenda-use-time-grid t)
(setq org-agenda-start-with-log-mode t)
(setq org-agenda-custom-commands
      (quote
       (
        ("A" . "Agendas")
        ("AT" "Daily overview"
         ((tags-todo "URGENT"
                     ((org-agenda-overriding-header "Urgent Tasks")))
          (tags-todo "NEW"
                     ((org-agenda-overriding-header "New, needs tagging")))
          (tags-todo "TODO=\"PEND STATE\""
                     ((org-agenda-overriding-header "Pending TODO state update")))
          (tags-todo "RADAR"
                     ((org-agenda-overriding-header "On my radar")))
          (tags-todo "PHONE+TODO=\"NEXT\""
                     ((org-agenda-overriding-header "Phone Calls")))
          (tags-todo "Depth=\"Deep\"/NEXT"
                     ((org-agenda-overriding-header "Next Actions requiring deep work")))
          (tags-todo "TODO=\"BLOCKED\""
                     ((org-agenda-overriding-header "Blocked")))
          (agenda ""
                  ((org-agenda-overriding-header "Today")
                   (org-agenda-span 1)
                   (org-agenda-sorting-strategy
                    (quote
                     (time-up priority-down)))))
          (tags-todo "TODO=\"TODO\"|TODO=\"NEXT\""
                     ((org-agenda-overriding-header "All Todos"))))
          nil nil)
        ("AW" "Weekly overview" agenda ""
         ((org-agenda-overriding-header "Weekly overview")))
        ("AM" "Monthly overview" agenda ""
         ((org-agenda-overriding-header "Monthly overview"))
         (org-agenda-span
          (quote month))
         (org-deadline-warning-days 0)
         (org-agenda-sorting-strategy
          (quote
           (time-up priority-down tag-up))))
        ("D" . "DAILY Review Helper")
        ("Dn" "New tasks" tags "NEW"
         ((org-agenda-overriding-header "NEW Tasks")))
        ("Dp" "Pending Set State" tags-todo "PEND SET STATE"
         ((org-agenda-overriding-header "Tasks Pending Set State")))
        ("Dd" "Check DELEGATED tasks" todo "DELEGATED"
         ((org-agenda-overriding-header "DELEGATED tasks")))
        ("Db" "Check BLOCKED tasks" todo "BLOCKED"
         ((org-agenda-overriding-header "BLOCKED tasks")))
        ("Df" "Check finished tasks" todo "DONE|CANCELLED|FORWARDED"
         ((org-agenda-overriding-header "Finished tasks")))
        ("DP" "Planing ToDos (unscheduled) only" todo "TODO|NEXT"
         ((org-agenda-overriding-header "Planning overview")
          (org-agenda-skip-function
           (quote
            (org-agenda-skip-entry-if
             (quote scheduled)
             (quote deadline)))))))
       ))
(setq org-agenda-include-diary t)
(setq org-agenda-files ;Adds all .org files to agenda unless they are in the archive folder
      (seq-filter (lambda(x) (not (string-match "/archive/"(file-name-directory x))))
                  (directory-files-recursively org-directory "\\.org$")
                  ))

(use-package perspective
  :custom
  ;; NOTE! I have also set 'SCP =' to open the perspective menu.
  ;; I'm only setting the additional binding because setting it
  ;; helps suppress an annoying warning message.
  (persp-mode-prefix-key (kbd "C-c M-p"))
  :init 
  (persp-mode)
  :config
  ;; Sets a file to write to when we save states
  (setq persp-state-default-file "~/.config/emacs/sessions"))

;; This will group buffers by persp-name in ibuffer.
(add-hook 'ibuffer-hook
          (lambda ()
            (persp-ibuffer-set-filter-groups)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))

;; Automatically save perspective states to file when Emacs exits.
(add-hook 'kill-emacs-hook #'persp-state-save)

(use-package projectile
  :config
  (projectile-mode 1))

(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)

(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(global-display-line-numbers-mode 1) ;; Display line numbers
(global-visual-line-mode t)  ;; Enable truncated lines
(menu-bar-mode -1)           ;; Disable the menu bar 
(tool-bar-mode -1)           ;; Disable the tool bar
(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.

(use-package eshell-toggle
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil)
  (eshell-toggle-init-function #'eshell-toggle-init-ansi-term))

  (use-package eshell-syntax-highlighting
    :after esh-mode
    :config
    (eshell-syntax-highlighting-global-mode +1))

  ;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
  ;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
  ;; eshell-aliases-file -- sets an aliases file for the eshell.

  (setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
        eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
        eshell-history-size 5000
        eshell-buffer-maximum-lines 5000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t
        eshell-destroy-buffer-when-process-dies t
        eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package sudo-edit)

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; Sets the default theme to load!!! 
  (load-theme 'doom-dark+ t)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package tldr)

(add-to-list 'default-frame-alist '(alpha-background . 100)) ; For all new frames henceforth

(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-allow-imprecise-window-fit nil
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit nil
	  which-key-separator " → " ))
