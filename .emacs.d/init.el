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

;; (use-package fzf)

;; Setup org mode
(use-package org
  :custom
  (org-startup-folded 'overview)
  :config
  (setq org-directory "~/Documents/org"
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


;; general
(use-package general
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

    ;; Agenda
    "a" '(nil :which-key "Agenda")
    "aa" '(org-agenda :which-key "Agenda View")

    ;; Capture
    "c" '(nil :which-key "Capture")
    "cd" '((lambda() (interactive) (org-capture nil "d")) :which-key "Agenda View")))

(setq org-agenda-files '("~/Documents/org/"))
(setq org-agenda-custom-commands
      '(("s" "Standup"
	 ((agenda "" ((org-agenda-overriding-header "Completed yesterday")
		      (org-agenda-start-day "-1d")
		      (org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo 'done))
		      (org-agenda-span 'day)
		      (org-agenda-show-log t)
		      (org-agenda-prefix-format "%-12:c% s")
		      (org-agenda-time-grid nil)))
	 (agenda "" ((org-agenda-overriding-header "Working on today")
		      (org-agenda-span 'day)
		      (org-agenda-prefix-format "%-12:c% s")
		      (org-deadline-warning-days 1))))
	 ((org-agenda-block-separator " ")))))
(setq org-capture-templates
      '(("d" "Done" entry
	 (file+headline "inbox.org" "Inbox")
	 "* DONE %^{Task completed}\nCLOSED: [%<%Y-%m-%d %a %H:%M>]\n")))
