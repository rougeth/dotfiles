;; Disable tool bar, menu bar and scroll bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Add melpa repository to package-archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

;; Install and setup 'use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(load (expand-file-name "rgth.el" user-emacs-directory))
(load (expand-file-name "config/doom-org.el" user-emacs-directory))

(use-package counsel)

;; Evil mode
(use-package evil
  :init
  (setq evil-want-C-i-jump nil
	evil-want-keybinding nil)
  :config
  (evil-mode 1))

;; which-key
(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-min-display-lines 2
	which-key-max-display-columns 4
	which-key-idle-delay 0.3))

(use-package fzf)

;; Setup org mode
(use-package org
  :custom
  (org-startup-folded 'overview)
  :config
  (setq org-directory "/Users/marco/Library/Mobile Documents/com~apple~CloudDocs/Documents/Notas"
	org-ellipsis " ▼"
	org-hide-emphasis-markers t
	org-startup-indented t
	org-src-fontify-natively t
	org-log-done t
	org-todo-keywords
	'((sequence "TODO" "IN PROGRESS" "REVIEW" "|" "DONE")))
  (setq org-M-RET-may-split-line nil
	;; insert new headings after current subtree rather than inside it
	org-insert-heading-respect-content t))

(add-hook 'org-mode-hook #'rgth/set-org-level)

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package org-roam
  :config
  (setq org-roam-directory (file-truename "~/Library/Mobile Documents/com~apple~CloudDocs/Documents/Notas")
	org-roam-capture-templates '(("d" "default" plain "%?"
				    :target (file+head "${slug}.org"
						       "#+title: ${title}\n\n")
				    :unnarrowed t))))
(use-package simpleclip
  :init 'simpleclip-mode)

;; general
(use-package general
  :after org-roam
  :config
  (general-define-key
    :states '(normal motion visual)
    :keymaps 'override
    :prefix "SPC"

    "SPC" '(counsel-M-x :which-key "M-x")
    
    ;; File
    "f" '(nil :which-key "file")

    ;; Buffer
    "b" '(nil :which-key "buffer")
    "bb" '(counsel-switch-buffer :which-key "switch buffers")
    "bs" '((switch-to-buffer "*scratch*") :which-key "switch buffers")
    "be" '(eval-buffer :which-key "eval-buffer")

    ;; Notes
    "n" '(nil :which-key "notes")
    "nn" '(org-roam-node-find :which-key "new note")
    "nf" '(rgth/notes-find-note :which-key "find note")

    "h" '(nil :which-key "help")
    "hr" '((lambda () (interactive) (load (expand-file-name "init.el" user-emacs-directory))) :which-key "help")
    "hi" '((lambda () (interactive) (find-file-existing "~/.emacs.d/init.el")) :which-key "init.el"))
  ;; End of SPC leader

  (general-define-key
    :keymaps 'override
    "M-c" 'simpleclip-copy
    "M-v" 'simpleclip-paste)

  (general-define-key
    :keymaps 'org-mode-map
    "<return>" '+org/dwim-at-point
    "M-<return>" '+org/insert-item-below
    "M-S-<return>" '+org/insert-item-above
    "M-C-<return>" 'org-insert-subheading
    )

  (general-define-key
    :states '(normal)
    :keymaps 'org-mode-map
    "<" 'org-do-promote
    ">" 'org-do-demote
    "*" 'org-toggle-heading))

(use-package dracula-theme)
(load-theme 'dracula t)
