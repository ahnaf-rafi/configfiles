;;; init.el --- -*- lexical-binding: t; -*-

;;; Code:

;; Name and email.
(setq user-full-name "Ahnaf Rafi")
(setq user-mail-address "ahnaf.al.rafi@gmail.com")

;; Set file for custom.el to use --- I use this for temporary customizations.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; Load the custom file.
(load custom-file 'noerror 'nomessage)

;; Add user lisp directory to load path.
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Clipboard/kill-ring --- do not keep duplicates.
(setq kill-do-not-save-duplicates t)

;; Disable the alarm bell
(setq ring-bell-function 'ignore)

;; For mouse events
(setq use-dialog-box nil)
(setq use-file-dialog nil)

;; Disable backups and lockfiles
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; Enable auto-saves
(setq auto-save-default t)

;; Auto-save transforms
(setq auto-save-file-name-transforms
      (list (list "\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'"
                  ; Prefix tramp auto-saves to prevent conflicts
                  (concat auto-save-list-file-prefix "tramp-\\2") t)
            (list ".*" auto-save-list-file-prefix t)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not present.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(setq use-package-always-defer t)

(require 'use-package)

(use-package gcmh
  :init
  (setq gcmh-idle-delay 5)
  (setq gcmh-high-cons-threshold (* 100 1024 1024))
  (setq gcmh-verbose init-file-debug)
  (gcmh-mode 1))

(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize))

(add-to-list 'default-frame-alist '(font . "JuliaMono-14.0"))
(set-face-attribute 'default nil :font "JuliaMono-14.0")

(use-package nerd-icons)

;; Dealing with Xressources - i.e. don't bother, ignore.
(setq inhibit-x-resources t)

;; Cursor, tooltip and dialog box
(when (fboundp 'blink-cursor-mode)
  (blink-cursor-mode -1))
(setq visible-cursor nil)
(setq use-dialog-box nil)
(setq x-gtk-use-system-tooltips nil)
(when (fboundp 'tooltip-mode)
  (tooltip-mode -1))

(setq display-line-numbers-type 'visual)
(dolist (hook '(prog-mode-hook text-mode-hook))
  (add-hook hook #'display-line-numbers-mode)
  (add-hook hook #'display-fill-column-indicator-mode))

(defvar aar/use-dark-theme nil
  "Use dark theme if `t' otherwise, use light theme")

(setq modus-themes-org-blocks 'gray-background)

(if aar/use-dark-theme
    (load-theme 'modus-vivendi t)
  (load-theme 'modus-operandi t))

(use-package hl-todo
  :init
  (dolist (hook '(prog-mode-hook tex-mode-hook markdown-mode-hook))
    (add-hook hook #'hl-todo-mode))

  ;; Stolen from doom-emacs: modules/ui/hl-todo/config.el
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
        '(;; For reminders to change or add something at a later date.
          ("TODO" warning bold)
          ;; For code (or code paths) that are broken, unimplemented, or slow,
          ;; and may become bigger problems later.
          ("FIXME" error bold)
          ;; For code that needs to be revisited later, either to upstream it,
          ;; improve it, or address non-critical issues.
          ("REVIEW" font-lock-keyword-face bold)
          ;; For code smells where questionable practices are used
          ;; intentionally, and/or is likely to break in a future update.
          ("HACK" font-lock-constant-face bold)
          ;; For sections of code that just gotta go, and will be gone soon.
          ;; Specifically, this means the code is deprecated, not necessarily
          ;; the feature it enables.
          ("DEPRECATED" font-lock-doc-face bold)
          ;; Extra keywords commonly found in the wild, whose meaning may vary
          ;; from project to project.
          ("NOTE" success bold)
          ("BUG" error bold)
          ("XXX" font-lock-constant-face bold))))

(use-package which-key
  :demand t
  :init
  (setq which-key-idle-delay 0.3)
  (setq which-key-allow-evil-operators t)
  (which-key-setup-minibuffer)
  (which-key-mode))

(use-package evil
  :demand t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-u-delete t)
  (setq evil-want-C-i-jump nil)
  (setq evil-want-visual-char-semi-exclusive t)
  (setq evil-ex-search-vim-style-regexp t)
  (setq evil-ex-visual-char-range t)
  (setq evil-respect-visual-line-mode t)
  (setq evil-mode-line-format 'nil)
  (setq evil-symbol-word-search t)
  (setq evil-ex-interactive-search-highlight 'selected-window)
  (setq evil-kbd-macro-suppress-motion-error t)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  (setq evil-flash-timer nil)
  (setq evil-complete-all-buffers nil)
  (evil-mode 1)
  (evil-set-initial-state 'messages-buffer-mode 'normal))

(use-package evil-collection
  :demand t
  :init
  (setq evil-collection-outline-bind-tab-p nil)
  (setq evil-collection-want-unimpaired-p nil)

  ;; I like to tweak bindings after loading pdf-tools
  (require 'evil-collection)
  (delete '(pdf pdf-view) evil-collection-mode-list)
  (evil-collection-init))

(use-package evil-escape
  :demand t
  :init
  (evil-escape-mode))

(use-package general
  :demand t
  :init
  (general-evil-setup)

  (general-create-definer aar/leader
    :keymaps 'override
    :states '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-create-definer aar/localleader
    :keymaps 'override
    :states '(normal insert visual emacs)
    :prefix "SPC m"
    :global-prefix "C-SPC m")

  (aar/localleader
   "" '(nil :which-key "<localleader>"))

  ;; Some basic <leader> keybindings
  (aar/leader
    ":" #'pp-eval-expression
    ";" #'execute-extended-command
    "&" #'async-shell-command
    "u" #'universal-argument))

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'option))

;; Keybinding definitions
;; Better escape
(global-set-key (kbd "<escape>") #'keyboard-escape-quit)

;; Text scale and zoom
(global-set-key (kbd "C-+") #'text-scale-increase)
(global-set-key (kbd "C-_") #'text-scale-decrease)
(global-set-key (kbd "C-)") #'text-scale-adjust)

;; Universal arguments with evil
(global-set-key (kbd "C-M-u") 'universal-argument)

;; Visual indent/dedent
;;;###autoload
(defun aar/evil-visual-dedent ()
  "Equivalent to vnoremap < <gv."
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

;;;###autoload
(defun aar/evil-visual-indent ()
  "Equivalent to vnoremap > >gv."
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(evil-define-key 'visual 'global
  (kbd "<") #'aar/evil-visual-dedent
  (kbd ">") #'aar/evil-visual-indent)

;; Jumping to function and method definitions
;;;###autoload
(defun aar/next-beginning-of-method (count)
  "Jump to the beginning of the COUNT-th method/function after point."
  (interactive "p")
  (beginning-of-defun (- count)))

;;;###autoload
(defun aar/previous-beginning-of-method (count)
  "Jump to the beginning of the COUNT-th method/function before point."
  (interactive "p")
  (beginning-of-defun count))

(defalias #'aar/next-end-of-method #'end-of-defun
  "Jump to the end of the COUNT-th method/function after point.")

;;;###autoload
(defun aar/previous-end-of-method (count)
  "Jump to the end of the COUNT-th method/function before point."
  (interactive "p")
  (end-of-defun (- count)))

(evil-define-key '(normal visual motion) 'global
  (kbd "] m") #'aar/next-beginning-of-method
  (kbd "[ m") #'aar/previous-beginning-of-method
  (kbd "] M") #'aar/next-end-of-method
  (kbd "[ M") #'aar/previous-end-of-method)

(use-package dashboard
  :init
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))

(size-indication-mode t)
(line-number-mode t)
(column-number-mode t)

(use-package doom-modeline
  :init
  (setq doom-modeline-buffer-file-name-style 'file-name)
  (doom-modeline-mode 1)

  )

(use-package procress
  :vc (:url "https://github.com/haji-ali/procress")
  :commands procress-auctex-mode
  :init
  (add-hook 'LaTeX-mode-hook #'procress-auctex-mode)
  :config
  (procress-load-default-svg-images))

(use-package hide-mode-line
  :hook (completion-list-mode . hide-mode-line-mode))

;; Scrolling
(setq-default scroll-margin 0)
(setq-default scroll-step 1)
(setq-default scroll-preserve-screen-position nil)
(setq-default scroll-conservatively 10000)
(setq-default auto-window-vscroll nil)

(defun aar/revert-buffer-no-confirm ()
  (interactive)
  (revert-buffer t t t))

(aar/leader
  "b"   '(nil :which-key "buffer")
  "b b" #'switch-to-buffer
  "b i" #'ibuffer
  "b r" #'aar/revert-buffer-no-confirm
  "b d" #'kill-current-buffer
  "b k" #'kill-buffer
  "b p" #'previous-buffer
  "b n" #'next-buffer
  "b [" #'previous-buffer
  "b ]" #'next-buffer)

(use-package ibuffer
  :hook (ibuffer-mode . (lambda () (visual-line-mode -1))))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

;; (add-hook 'after-init-hook #'global-auto-revert-mode)

(add-hook 'after-init-hook #'global-visual-line-mode)

;; Favor vertical splits over horizontal ones. Screens are usually wide.
(setq split-width-threshold 160)
(setq split-height-threshold nil)

(aar/leader
  "w" 'evil-window-map)

(general-define-key
 :keymaps 'evil-window-map
 "C-h" #'evil-window-left
 "C-j" #'evil-window-down
 "C-k" #'evil-window-up
 "C-l" #'evil-window-right
 "C-q" #'evil-quit
 "d"   #'evil-quit
 "x"   #'kill-buffer-and-window
 "f"   #'ffap-other-window
 "C-f" #'ffap-other-window)

;; Maximize new frames
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Frame title: tell me if I am in daemon mode
(setq frame-title-format (if (daemonp)
                             '("AAR Emacs Daemon - %b")
                           '("AAR Emacs - %b")))

;; Functions
;;;###autoload
(defun aar/delete-frame-or-kill-emacs ()
  "Delete current frame if it is non-unique in session. Otherwise, kill Emacs."
  (interactive)
  (if (cdr (frame-list))
      (delete-frame)
    (save-buffers-kill-emacs)))

(aar/leader
  "F"   '(nil :which-key "frame")
  "F F" #'toggle-frame-fullscreen
  "F o" #'make-frame
  "F q" #'aar/delete-frame-or-kill-emacs)

;; Don't require confirmation every time when quitting.
(setq confirm-kill-emacs nil)

(aar/leader
  "q"   '(nil :which-key "quit")
  "q K" #'save-buffers-kill-emacs)

(use-package vertico
  :init
  (setq vertico-cycle t)

  (vertico-mode)
  :general
  (:keymaps 'vertico-map
   "M-n"       #'vertico-next
   "M-p"       #'vertico-previous))

(setq savehist-save-minibuffer-history t)
(add-hook 'after-init-hook #'savehist-mode)

(use-package consult
  :init
  (setq consult-preview-key 'nil)

  :general
  ([remap apropos]            #'consult-apropos
   [remap bookmark-jump]      #'consult-bookmark
   [remap evil-show-marks]    #'consult-mark
   [remap imenu]              #'consult-imenu
   [remap load-theme]         #'consult-theme
   [remap locate]             #'consult-locate
   [remap recentf-open-files] #'consult-recent-file
   [remap yank-pop]           #'consult-yank-pop))

(use-package marginalia
  :init
  (setq marginalia-annotators '(marginalia-annotators-heavy
				                        marginalia-annotators-light))
  (marginalia-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides '((file (styles . (partial-completion))))))

(setq tab-always-indent 'complete)

(use-package corfu
  :custom
  (corfu-cycle t)                  ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                   ;; Enable auto completion
  (corfu-separator ?\s)            ;; Orderless field separator
  (corfu-quit-no-match 'separator) ;; Never quit, even if there is no match
  (corfu-preselect 'prompt)        ;; Preselect the prompt
  :init
  (setq completion-cycle-threshold 3)
  (global-corfu-mode)
  :general
  (:keymaps 'corfu-map
	 "TAB"         #'corfu-next
	 "<backtab>>"  #'corfu-previous
	 "M-n"         #'corfu-next
	 "M-p"         #'corfu-previous
   "RET"         nil))

;; TODO: Configure properly
(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-file)
)

(use-package nerd-icons-completion
  :init
  (nerd-icons-completion-mode))

(setq insert-directory-program "ls"
      dired-use-ls-dired nil)
(setq dired-listing-switches "-agho --group-directories-first")
(add-hook 'dired-mode-hook #'display-line-numbers-mode)
(add-hook 'dired-mode-hook #'display-fill-column-indicator-mode)

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package dired-single
  :vc (:url "https://github.com/emacsattic/dired-single")
  :init
  (with-eval-after-load 'dired
    (require 'dired-x)
    (define-key dired-mode-map [remap dired-find-file] #'dired-single-buffer)
    (define-key dired-mode-map [remap dired-mouse-find-file-other-window]
		#'dired-single-buffer-mouse)
    (define-key dired-mode-map [remap dired-up-directory]
    #'dired-single-up-directory)
    (evil-define-key '(normal visual motion) dired-mode-map
      (kbd "h") #'dired-single-up-directory
      (kbd "l") #'dired-single-buffer)))

(require 'recentf)
(setq recentf-max-saved-items 50)
(setq recentf-max-menu-items 15)
(setq recentf-auto-cleanup (if (daemonp) 300))
(add-to-list 'recentf-exclude "^/\\(?:ssh\\|su\\|sudo\\)?:")
(recentf-mode 1)
(add-hook 'find-file-hook #'recentf-save-list)

;; Insert file names from minibuffer
;;;###autoload
(defun aar/insert-file-name (filename &optional args)
  "Insert name of file FILENAME into buffer after point.
Prefixed with \\[universal-argument], expand the file name to its fully
canocalized path.  See `expand-file-name'.

Prefixed with \\[negative-argument], use relative path to file name from current
directory, `default-directory'.  See `file-relative-name'.

The default with no prefix is to insert the file name exactly as it appears in
the minibuffer prompt."
  ;; Based on insert-file in Emacs -- ashawley 20080926
  (interactive "*fInsert file name: \nP")
  (cond ((eq '- args)
         (insert (file-relative-name filename)))
        ((not (null args))
         (insert (expand-file-name filename)))
        (t
         (insert filename))))

;; Find file in config
;;;###autoload
(defun aar/find-file-in-config ()
  "Find files in configuration directory using project.el"
  (interactive)
  (if (not (featurep 'project))
      (require 'project))
  (let* ((pr (project--find-in-directory (file-truename "~/configfiles")))
         (dirs (list (project-root pr))))
    (project-find-file-in (thing-at-point 'filename) dirs pr)))

;; Copy file path
;;;###autoload
(defun aar/yank-buffer-file-path ()
  "Copy the current buffer's path to the kill ring."
  (interactive)
  (if-let (filename (or buffer-file-name
                        (bound-and-true-p list-buffers-directory)))
      (message (kill-new (abbreviate-file-name filename)))
    (error "Couldn't find file path in current buffer")))

;; Copy path to directory containing file
;;;###autoload
(defun aar/yank-buffer-dir-path ()
  "Copy the current buffer's directory path to the kill ring."
  (interactive)
  (if-let (dir-name (or default-directory
                        (bound-and-true-p list-buffers-directory)))
      (message (kill-new (abbreviate-file-name dir-name)))
    (error "Couldn't find directory path in current buffer")))

;; Copy file name
;; TODO: adjust for final child node of a directory path.
;;;###autoload
(defun aar/yank-buffer-file-name ()
  "Copy the current buffer's non-directory name to the kill ring."
  (interactive)
  (if-let (filename (or buffer-file-name
                        (bound-and-true-p list-buffers-directory)))
      (message (kill-new (file-name-nondirectory
                          (abbreviate-file-name filename))))
    (error "Couldn't find file name in current buffer")))

(defvar aar/external-open-filetypes '("\\.csv\\'" "\\.xlsx?\\'" "\\.docx?\\'"))

(defvar aar/external-open-command (cond ((eq system-type 'darwin) "open")
                                        ((eq system-type 'gnu/linux) "xdg-open")))

;; Open certain files in external processes.
;;;###autoload
(defun aar/external-open (filename)
  "Open the file FILENAME in external application using `xdg-open'."
  (interactive "fFilename: ")
  (let ((process-connection-type nil))
    (call-process aar/external-open-command nil 0 nil (expand-file-name filename))))

;;;###autoload
(defun aar/find-file-auto (orig-fun &rest args)
  "Advice for `find-file': if file has extension in `aar/external-open-filetypes',
then open in external application using `aar/external-open'. Otherwise, go with
default behavior."
  (let ((filename (car args)))
    (if (cl-find-if
         (lambda (regexp) (string-match regexp filename))
         aar/external-open-filetypes)
        (aar/external-open filename)
      (apply orig-fun args))))

(advice-add 'find-file :around #'aar/find-file-auto)

(aar/leader
  "."     #'find-file
  "f"     '(nil :which-key "files")
  "f f"   #'find-file
  "f n"   #'rename-file
  "f s"   #'save-buffer
  "f d"   #'dired
  "f j"   #'dired-jump
  "f i"   #'aar/insert-file-name
  "f r"   #'recentf-open-files
  "f p"   #'aar/find-file-in-config
  "f y y" #'aar/yank-buffer-file-path
  "f y d" #'aar/yank-buffer-dir-path
  "f y n" #'aar/yank-buffer-file-name)

(general-def
  :keymaps 'wdired-mode-map
  [remap save-buffer] #'wdired-finish-edit)

(aar/leader
  "h" help-map)

;; helpful
(use-package helpful
  :hook ((helpful-mode . display-line-numbers-mode))
  :general
  ([remap describe-key]      #'helpful-key
   [remap describe-command]  #'helpful-command
   [remap describe-function] #'helpful-callable
   [remap describe-variable] #'helpful-variable
   [remap describe-symbol]   #'helpful-symbol
   [remap apropos-command]   #'consult-apropos))

(use-package elisp-demos
  :init
  (advice-add 'describe-function-1
              :after #'elisp-demos-advice-describe-function-1)
  (advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update))

;;;###autoload
(defun aar/help-mode-h ()
  (setq-local show-trailing-whitespace nil)
  ;; (visual-line-mode)
  (display-line-numbers-mode))

(dolist (hook '(Info-mode-hook help-mode-hook))
  (add-hook hook #'aar/help-mode-h))

(if (>= emacs-major-version 28)
    (evil-set-undo-system 'undo-redo)

  (use-package undo-fu
    :init
    (global-undo-fu-session-mode 1)
    (evil-set-undo-system 'undo-fu))
  (use-package undo-fu-session
    :init
    (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'"
                                               "/git-rebase-todo\\'"))))

;; Indentation widths
(setq-default standard-indent 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default evil-shift-width standard-indent)

;; New lines at EOF
(setq-default require-final-newline nil)
(setq-default mode-require-final-newline t)
(setq-default log-edit-require-final-newline nil)

;; Long lines
(setq-default fill-column 80)
(setq-default word-wrap t)
(setq-default truncate-lines t)

;; electric-indent
(setq-default electric-indent-inhibit t)

;; adaptive-wrap
(use-package adaptive-wrap
  :init
  (setq-default adaptive-wrap-extra-indent 0))

;; Whitespaces
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook #'delete-trailing-whitespace)

;; paren
(setq show-paren-delay 0)
(setq show-paren-highlight-openparen t)
(setq show-paren-when-point-inside-paren t)
(setq show-paren-when-point-in-periphery t)
(add-hook 'after-init-hook #'show-paren-mode)

;; elec-pair
(add-hook 'after-init-hook #'electric-pair-mode)

;; evil-surround
(use-package evil-surround
  :init
  (global-evil-surround-mode 1))

(use-package yasnippet
  :init
  (setq yas-indent-line 'auto)
  (with-eval-after-load 'yasnippet
    (add-to-list 'yas-snippet-dirs (expand-file-name "snippets/"
                                                     user-emacs-directory))
    (defvaralias '% 'yas-selected-text))
  (yas-global-mode 1))

(use-package evil-snipe
  :init
  (setq evil-snipe-smart-case t)
  (setq evil-snipe-scope 'line)
  (setq evil-snipe-repeat-scope 'visible)
  (setq evil-snipe-char-fold t)

  (evil-snipe-mode 1)
	(evil-snipe-override-mode 1))

(use-package evil-traces
  :demand t
  :init
  (evil-traces-mode)
  (evil-traces-use-diff-faces))

(use-package anzu
  :init
  (global-anzu-mode 1)
  :general
  ([remap query-replace]        #'anzu-query-replace
   [remap query-replace-regexp] #'anzu-query-replace-regexp))

(use-package evil-anzu
  :init
  (with-eval-after-load 'evil
    (require 'evil-anzu)))

;;;###autoload
(defun aar/goto-long-line (len &optional msgp)
  "Go to the first line that is greater than LEN characters long.
Use a prefix arg to provide LEN.
Plain `C-u' (no number) uses `fill-column' as LEN."
  (interactive "P\np")
  (setq len (if (consp len) fill-column (prefix-numeric-value len)))
  (let ((start-line                 (line-number-at-pos))
        (len-found                  0)
        (found                      nil)
        (inhibit-field-text-motion  t))
    (while (and (not found)  (not (eobp)))
      (forward-line 1)
      (setq found  (< len (setq len-found  (- (line-end-position) (point))))))
    (if found
        (when msgp (message "Line %d: %d chars" (line-number-at-pos) len-found))
      (goto-line start-line)
      (message "Not found"))))

(aar/leader
  "s"   '(nil :which-key "search")
  "s c" #'evil-ex-nohighlight
  "s p"	#'consult-ripgrep
  "s l"	#'consult-line
  "s L" #'aar/goto-long-line)

(use-package project :demand t)

;; Adapted from Manuel Uberti's config.
;; Declare directories with ".project" as a project
(cl-defmethod project-root ((project (head local)))
  (cdr project))

;;;###autoload
(defun aar/project-try-local (dir)
  "Determine if DIR is a non-Git project.
DIR must include a .project file to be considered a project."
  (let ((root (locate-dominating-file dir ".project")))
    (and root (cons 'local root))))

(with-eval-after-load 'project
  (add-to-list 'project-find-functions 'aar/project-try-local))

(aar/leader
  "SPC" #'project-find-file
  "p"   project-prefix-map)

(use-package vc
  :init
  (setq vc-follow-symlinks t)
  (setq vc-ignore-dir-regexp (format "\\(%s\\)\\|\\(%s\\)"
                                     vc-ignore-dir-regexp
                                     tramp-file-name-regexp))

  (aar/leader
    "v" #'vc-prefix-map)

  (general-def
    :keymaps 'vc-prefix-map
    "c" #'vc-create-repo))

(use-package magit)

(use-package git-gutter
  :init
  (global-git-gutter-mode 1))

(aar/leader
  "g"   '(nil :which-key "git")
  "g g" #'magit-status
  "g c" #'magit-clone
  "g i" #'magit-init
  "g ]" #'git-gutter:next-hunk
  "g [" #'git-gutter:previous-hunk)

(general-def
  :states '(normal visual motion)
  :keymaps 'global
  "] g" #'git-gutter:next-hunk
  "[ g" #'git-gutter:previous-hunk)

(aar/leader
  "c"   '(nil :which-key "code")
  "c i" #'imenu)

(use-package flymake
  :general
  (:states '(normal visual motion)
   "] d" #'flymake-goto-next-error
   "[ d" #'flymake-goto-prev-error))

(use-package eglot
  :init
  (setq eglot-connect-timeout 300)
  (add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1)))
  (general-def
   :keymaps 'eglot-mode-map
   :states '(normal visual motion)
   "g R" #'eglot-rename))

(use-package consult-eglot)

(use-package treesit-auto
  :demand t
  :config
  (setq treesit-auto-install 'prompt)
  (add-to-list 'treesit-language-source-alist
               '(typst "https://github.com/uben0/tree-sitter-typst"))
  (global-treesit-auto-mode))

(use-package eldoc
  :init
  (setq max-mini-window-height 1)
  (setq eldoc-echo-area-use-multiline-p nil))

(use-package xref)

(use-package imenu)

(aar/leader
  "a" '(nil :which-key "apps"))

(use-package ispell
  :init
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra"
                            "--run-together"))
  (setq ispell-dictionary "english")
  (setq ispell-personal-dictionary
        (expand-file-name "ispell_personal" user-emacs-directory))
  (setq ispell-local-dictionary-alist `((nil "[[:alpha:]]" "[^[:alpha:]]"
                                             "['\x2019]" nil ("-B") nil utf-8))))

(use-package flyspell
  :init
  (setq flyspell-issue-welcome-flag nil
        ;; Significantly speeds up flyspell, which would otherwise print
        ;; messages for every word when checking the entire buffer
        flyspell-issue-message-flag nil)

  (add-hook 'text-mode-hook #'flyspell-mode))

(use-package flyspell-lazy
  :after flyspell
  :config
  (setq flyspell-lazy-idle-seconds 1
        flyspell-lazy-window-idle-seconds 3)
  (flyspell-lazy-mode +1))

(use-package flyspell-correct
  :commands flyspell-correct-previous
  :general
  (:keymaps 'flyspell-mode-map
	    [remap ispell-word] #'flyspell-correct-wrapper))

(use-package vterm
  :init
  (setq vterm-always-compile-module t)
  (setq vterm-buffer-name-string "vterm: %s")
  (setq vterm-copy-exclude-prompt t)
  (setq vterm-kill-buffer-on-exit t)
  (setq vterm-max-scrollback 5000))

;; vterm helper functions
;;;###autoload
(defun aar/vterm-cd-if-remote ()
  "When `default-directory` is remote, use the corresponding
method to prepare vterm at the corresponding remote directory."
  (when (and (featurep 'tramp)
             (tramp-tramp-file-p default-directory))
    (message "default-directory is %s" default-directory)
    (with-parsed-tramp-file-name default-directory path
                                 (let ((method (cadr (assoc `tramp-login-program
                                                            (assoc path-method tramp-methods)))))
                                   (vterm-send-string
                                    (concat method " "
                                            (when path-user (concat path-user "@")) path-host))
                                   (vterm-send-return)
                                   (vterm-send-string
                                    (concat "cd " path-localname))
                                   (vterm-send-return)))))

;;;###autoload
(defun aar/vterm-here-other-window (&optional arg)
  (interactive "P")
  (unless (fboundp 'module-load)
    (user-error "Your build of Emacs lacks dynamic modules support and cannot load vterm"))
  ;; This hack forces vterm to redraw, fixing strange artefacting in the tty.
  (save-window-excursion
    (pop-to-buffer "*scratch*"))
  (require 'vterm)
  (vterm-other-window arg)
  (aar/vterm-cd-if-remote))

;;;###autoload
(defun aar/vterm-here (&optional arg)
  (interactive)
  (unless (fboundp 'module-load)
    (user-error "Your build of Emacs lacks dynamic modules support and cannot load vterm"))
  ;; This hack forces vterm to redraw, fixing strange artefacting in the tty.
  (save-window-excursion
    (pop-to-buffer "*scratch*"))
  (require 'vterm)
  (vterm arg)
  (aar/vterm-cd-if-remote))

;; vterm hook function
;;;###autoload
(defun aar/vterm-h ()
  (setq-local show-trailing-whitespace nil))

(add-hook 'vterm-mode-hook #'aar/vterm-h)

;; vterm keybindings
(aar/leader
  "a t" #'aar/vterm-here-other-window
  "a T" #'aar/vterm-here)

(use-package pdf-tools
  :hook
  (pdf-tools-enabled . aar/pdf-h)
  :init
  (if (eq system-type 'darwin)
      (progn
        (setq pdf-view-use-scaling t)
        (setq pdf-view-use-imagemagick nil)))

  ;; (pdf-loader-install)
  :config
  (evil-collection-pdf-setup)

  (evil-collection-define-key '(normal visual motion) 'pdf-view-mode-map
    (kbd "H")   #'image-bob
    (kbd "J")   #'pdf-view-next-page-command
    (kbd "K")   #'pdf-view-previous-page-command
    (kbd "a")   #'pdf-view-fit-height-to-window
    (kbd "s")   #'pdf-view-fit-width-to-window
    (kbd "L")   #'image-eob
    (kbd "o")   #'pdf-outline
    (kbd "TAB") #'pdf-outline)

  ;; Changes to the usual doom-modeline
  (doom-modeline-def-modeline 'pdf
    '(modals bar window-number matches pdf-pages buffer-info)
    '(misc-info major-mode process vcs)))

;;;###autoload
(defun aar/pdf-h ()
  (display-line-numbers-mode 0)
  (turn-off-evil-snipe-mode)
  (setq-local evil-normal-state-cursor (list nil))
  (setq-local mac-mouse-wheel-smooth-scroll nil))

(use-package nov
  :mode ("\\.epub\\'" . nov-mode))

(use-package olivetti
  :init
  (setq olivetti-body-width 150))

(defun aar/olivetti-mode-on-h ()
  (display-fill-column-indicator-mode -1)
  (auto-fill-mode -1))

(defun aar/olivetti-mode-off-h ()
  (display-fill-column-indicator-mode 1)
  (auto-fill-mode 1))

(add-hook 'olivetti-mode-on-hook #'aar/olivetti-mode-on-h)
(add-hook 'olivetti-mode-off-hook #'aar/olivetti-mode-off-h)

(use-package julia-mode)

(use-package julia-ts-mode
  :mode "\\.jl$")

;; An environmental variable I use in scripts
(setenv "PALLOC" (getenv "HOME"))

(use-package julia-repl
  :init
  (setq julia-repl-switches "--threads=auto --project=@.")
  :config
  (julia-repl-set-terminal-backend 'vterm)

  :general
  (aar/localleader
    :keymaps 'julia-mode-map
    "r" #'julia-repl
    "a" #'julia-repl-send-region-or-line
    "l" #'julia-repl-send-line))

(use-package eglot-jl
  :init
  (eglot-jl-init))

;;;###autoload
(defun aar/julia-mode-h ()
  (adaptive-wrap-prefix-mode)
  (setq-local adaptive-wrap-extra-indent 2)
  (setq-local evil-shift-width julia-indent-offset)
  (julia-repl-mode)
  (eglot-ensure))

(add-hook 'julia-mode-hook #'aar/julia-mode-h)

(setq python-shell-interpreter "ipython"
       python-shell-interpreter-args "-i --simple-prompt --InteractiveShell.display_page=True")

(use-package ess
  :mode ("\\.R\\'" . ess-r-mode)
  :init
  (setq ess-use-ido nil)  ;; use completing-read instead
  (setq ess-eval-visibly 'nowait)
  (setq ess-offset-continued 'straight)
  (setq ess-use-flymake t)
  (setq ess-nuke-trailing-whitespace-p t)
  (setq ess-style 'RStudio)
  (evil-set-initial-state 'ess-r-help-mode 'normal)

  :general
  (:states '(insert visual normal)
	   :keymaps 'ess-r-mode-map
	   "C-c C-c" #'ess-eval-region-or-line-visibly-and-step)
  (:states 'insert
	   :keymaps 'ess-r-mode-map
	   "M--" #'ess-insert-assign)
  (:states 'insert
	   :keymaps 'inferior-ess-r-mode-map
	   "M--" #'ess-insert-assign)
  (aar/localleader
    :keymaps 'ess-r-mode-map
    "r" #'aar/open-r-repl))

;;;###autoload
(defun aar/open-r-repl (&optional message)
  "Open an ESS R REPL"
  (interactive "P")
  (ess-request-a-process message)
  (current-buffer))

;;;###autoload
(defun aar/ess-r-mode-h ()
  (require 'ess-view-data)
  (adaptive-wrap-prefix-mode)
  (eglot-ensure))

(add-hook 'ess-mode-r-hook #'aar/ess-r-mode-h)

;; Inferior ess repl hooks
;;;###autoload
(defun aar/ess-inferior-mode-h ()
  ;; Potentially useful, not yet implemented. Found here:
  ;; https://tinyurl.com/3ne2b3fh
  ;; (setq comint-prompt-read-only t)
  ;; (setq comint-scroll-to-bottom-on-input t)
  ;; (setq comint-scroll-to-bottom-on-output t)
  ;; (setq comint-move-point-for-output t)
  (setq-local show-trailing-whitespace nil)
  (setq-local scroll-scroll-down-aggressively 1))

(add-hook 'inferior-ess-mode-hook #'aar/ess-inferior-mode-h)

(use-package ess-view-data)

(use-package lua-mode)

;;;###autoload
(defun aar/lua-mode-h ()
  (eglot-ensure))

(add-hook 'lua-mode-hook #'aar/lua-mode-h)

(use-package nix-ts-mode
  :mode "\\.nix\\'")

(use-package matlab-mode)

(use-package typst-ts-mode
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode")
  :custom
  ;; don't add "--open" if you'd like `watch` to be an error detector
  (typst-ts-mode-watch-options "--open")

  ;; experimental settings (I'm the main dev, so I enable these)
  (typst-ts-mode-enable-raw-blocks-highlight t)
  (typst-ts-mode-highlight-raw-blocks-at-startup t))

(use-package websocket)

(use-package typst-preview
  :vc (:url "https://github.com/havarddj/typst-preview.el" :branch "main" :rev :rewest)
  :init
  (require 'typst-preview)
  ;; default is "default"
  (setq typst-preview-browser "xwidget"))

(with-eval-after-load 'eglot
  (with-eval-after-load 'typst-ts-mode
    (add-to-list 'eglot-server-programs
                 `((typst-ts-mode) .
                   ,(eglot-alternatives `(,typst-ts-lsp-download-path
                                          "tinymist"
                                          "typst-lsp"))))))

(setq tex-fontify-script nil)

(use-package tex
  :ensure auctex
  :general
  (:states 'insert :keymaps 'LaTeX-mode-map
	   "C-'" "\\")
  :init
  (setq TeX-save-query nil)
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-start-server t)
  (setq TeX-electric-sub-and-superscript t)
  (setq TeX-electric-math (cons "\\(" "\\)"))
  ;; (setq LaTeX-fill-break-at-separators nil)
  (setq LaTeX-indent-environment-list nil)
  (setq LaTeX-item-indent 0)
  (setq TeX-brace-indent-level 0)
  (setq LaTeX-left-right-indent-level 0)
  (setq LaTeX-electric-left-right-brace t)
  (setq LaTeX-section-hook '(LaTeX-section-heading
                             LaTeX-section-title
                             LaTeX-section-toc
                             LaTeX-section-section
                             LaTeX-section-label))
  (setq preview-auto-cache-preamble t)

  (setq font-latex-fontify-script nil)
  (setq font-latex-fontify-sectioning 'color)
  (with-eval-after-load 'font-latex
    (set-face-foreground 'font-latex-script-char-face nil))

  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(latex-mode . ("texlab"))))

  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer)

  (with-eval-after-load 'tex
    (require 'pdf-sync)
    (require 'auctex-latexmk)
    (auctex-latexmk-setup)

    (setq font-latex-match-reference-keywords
          '(;; BibLaTeX.
            ("printbibliography" "[{")
            ("addbibresource" "[{")
            ;; Standard commands.
            ("cite" "[{")
            ("citep" "[{")
            ("citet" "[{")
            ("Cite" "[{")
            ("parencite" "[{")
            ("Parencite" "[{")
            ("footcite" "[{")
            ("footcitetext" "[{")
            ;; Style-specific commands.
            ("textcite" "[{")
            ("Textcite" "[{")
            ("smartcite" "[{")
            ("Smartcite" "[{")
            ("cite*" "[{")
            ("parencite*" "[{")
            ("supercite" "[{")
            ;; Qualified citation lists.
            ("cites" "[{")
            ("Cites" "[{")
            ("parencites" "[{")
            ("Parencites" "[{")
            ("footcites" "[{")
            ("footcitetexts" "[{")
            ("smartcites" "[{")
            ("Smartcites" "[{")
            ("textcites" "[{")
            ("Textcites" "[{")
            ("supercites" "[{")
            ;; Style-independent commands.
            ("autocite" "[{")
            ("Autocite" "[{")
            ("autocite*" "[{")
            ("Autocite*" "[{")
            ("autocites" "[{")
            ("Autocites" "[{")
            ;; Text commands.
            ("citeauthor" "[{")
            ("Citeauthor" "[{")
            ("citetitle" "[{")
            ("citetitle*" "[{")
            ("citeyear" "[{")
            ("citedate" "[{")
            ("citeurl" "[{")
            ;; Special commands.
            ("fullcite" "[{")
            ;; Hyperref.
            ("autoref" "[{")
            ("href" "[{")
            ("url" "[{")
            ;; Cleveref.
            ("cref" "{")
            ("Cref" "{")
            ("cpageref" "{")
            ("Cpageref" "{")
            ("cpagerefrange" "{")
            ("Cpagerefrange" "{")
            ("crefrange" "{")
            ("Crefrange" "{")
            ("labelcref" "{")))

    (setq font-latex-match-textual-keywords
          '(;; BibLaTeX brackets.
            ("parentext" "{")
            ("brackettext" "{")
            ("hybridblockquote" "[{")
            ;; Auxiliary commands.
            ("textelp" "{")
            ("textelp*" "{")
            ("textins" "{")
            ("textins*" "{")
            ;; Subcaption.
            ("subcaption" "[{")))

    (setq font-latex-match-variable-keywords
          '(;; Amsmath.
            ("numberwithin" "{")
            ;; Enumitem.
            ("setlist" "[{")
            ("setlist*" "[{")
            ("newlist" "{")
            ("renewlist" "{")
            ("setlistdepth" "{")
            ("restartlist" "{")
            ("crefname" "{")))

    (setq TeX-view-program-selection '((output-pdf "PDF Tools")))

    (dolist (envpair '(("verbatim" current-indentation)
                       ("verbatim*" current-indentation)
                       ("filecontents" current-indentation)
                       ("filecontents*" current-indentation)
                       ("frame" current-indentation)
                       ("theorem" current-indentation)
                       ("thm" current-indentation)
                       ("corollary" current-indentation)
                       ("cor" current-indentation)
                       ("lemma" current-indentation)
                       ("lem" current-indentation)
                       ("definition" current-indentation)
                       ("def" current-indentation)
                       ("assumption" current-indentation)
                       ("asm" current-indentation)
                       ("remark" current-indentation)
                       ("rem" current-indentation)
                       ("example" current-indentation)
                       ("eg" current-indentation)
                       ("proof" current-indentation)
                       ("problem" current-indentation)
                       ("solution" current-indentation)
                       ("itemize" aar/LaTeX-indent-item)
                       ("enumerate" aar/LaTeX-indent-item)
                       ("description" aar/LaTeX-indent-item)))
      (add-to-list 'LaTeX-indent-environment-list envpair)))
  )

;; Automatically compile on save
;;;###autoload
(defun aar/latex-default-compile-on-master ()
  "Run `TeX-command-default' on `TeX-master' for current buffer."
  (interactive)
  (TeX-command TeX-command-default #'TeX-master-file))

;;;###autoload
(defun aar/save-and-latex-default-compile-on-master ()
  "Save current buffer and run `aar/latex-default-compile-on-master'."
  (interactive)
  (save-buffer)
  (aar/latex-default-compile-on-master))

;;;###autoload
(defun aar/latex-compile-after-save-on ()
  (interactive)
  (add-hook 'after-save-hook #'aar/latex-default-compile-on-master 0 t))

;;;###autoload
(defun aar/latex-compile-after-save-off ()
  (interactive)
  (remove-hook 'after-save-hook #'aar/latex-default-compile-on-master t))

;;;###autoload
(defun aar/LaTeX-indent-item ()
  "Provide proper indentation for LaTeX \"itemize\",\"enumerate\", and
\"description\" environments.

  \"\\item\" is indented `LaTeX-indent-level' spaces relative to
  the the beginning of the environment.

  Continuation lines are indented either twice
  `LaTeX-indent-level', or `LaTeX-indent-level-item-continuation'
  if the latter is bound."
  (save-match-data
    (let* ((offset LaTeX-indent-level)
           (contin (or (and (boundp 'LaTeX-indent-level-item-continuation)
                            LaTeX-indent-level-item-continuation)
                       (* 2 LaTeX-indent-level)))
           (re-beg "\\\\begin{")
           (re-end "\\\\end{")
           (re-env "\\(itemize\\|\\enumerate\\|description\\)")
           (indent (save-excursion
                     (when (looking-at (concat re-beg re-env "}"))
                       (end-of-line))
                     (LaTeX-find-matching-begin)
                     (current-column))))
      (cond ((looking-at (concat re-beg re-env "}"))
             (or (save-excursion
                   (beginning-of-line)
                   (ignore-errors
                     (LaTeX-find-matching-begin)
                     (+ (current-column)
                        (if (looking-at (concat re-beg re-env "}"))
                            contin
                          offset))))
                 indent))
            ((looking-at (concat re-end re-env "}"))
             indent)
            ((looking-at "\\\\item")
             (+ offset indent))
            (t
             (+ contin indent))))))

(defcustom LaTeX-indent-level-item-continuation 4
  "*Indentation of continuation lines for items in itemize-like
environments."
  :group 'LaTeX-indentation
  :type 'integer)

(aar/localleader
  :keymaps 'LaTeX-mode-map
  "a"  #'aar/save-and-latex-default-compile-on-master
  "v"  #'TeX-view
  "c"  #'TeX-clean
  "ll" #'aar/latex-compile-after-save-on
  "lL" #'aar/latex-compile-after-save-off)

(use-package auctex-latexmk)

(use-package evil-tex
  :general
  (:states 'visual :keymaps 'evil-tex-mode-map
	   "] ]" #'evil-tex-go-forward-section
	   "[ [" #'evil-tex-go-back-section)
  :init
  (setq evil-tex-toggle-override-m nil)
  (setq evil-tex-toggle-override-t t))

(use-package reftex
  :init
  (setq reftex-cite-format
        '((?a . "\\autocite[]{%l}")
          (?b . "\\blockcquote[]{%l}{}")
          (?c . "\\cite[]{%l}")
          (?f . "\\footcite[]{%l}")
          (?n . "\\nocite{%l}")
          (?p . "\\parencite[]{%l}")
          (?s . "\\smartcite[]{%l}")
          (?t . "\\textcite[]{%l}")))
  (setq reftex-toc-split-windows-fraction 0.3)
  ;; This is needed when `reftex-cite-format' is set. See
  ;; https://superuser.com/a/1386206
  (setq LaTeX-reftex-cite-format-auto-activate nil)
  (setq reftex-plug-into-AUCTeX t)
  (setq reftex-toc-split-windows-fraction 0.3)
  (add-hook 'reftex-mode-hook #'evil-normalize-keymaps)

  (aar/localleader
    :keymaps 'LaTeX-mode-map
    ";" #'reftex-toc))

;;;###autoload
(defun aar/latex-mode-h ()
  (setq-local fill-nobreak-predicate nil)
  (setq-local TeX-command-default "LatexMk")
  (visual-line-mode 1)
  (auto-fill-mode 1)
  (adaptive-wrap-prefix-mode 1)
  (evil-tex-mode 1)
  (reftex-mode 1)
  (eglot-ensure)
  (font-latex-add-keywords '(("bm" "{")) 'bold-command)
  (setq-local ispell-parser 'tex))

(add-hook 'TeX-mode-hook #'aar/latex-mode-h)

;; TeX-latex-mode
(defun aar/remove-LaTeX-flymake ()
  (remove-hook 'flymake-diagnostic-functions 'LaTeX-flymake t))

(advice-add 'TeX-latex-mode :after #'aar/remove-LaTeX-flymake)

(use-package bibtex
  :init
  (setq bibtex-dialect 'biblatex)
  (setq bibtex-align-at-equal-sign t)
  (setq bibtex-text-indentation 20)

  (add-to-list 'auto-mode-alist '("\\.bibtex\\'" . bibtex-mode))

  ;; bibtex-autokey stuff
  (setq bibtex-autokey-year-length 4)
  (setq bibtex-autokey-names 1)
  (setq bibtex-autokey-titlewords 3)
  (setq bibtex-autokey-titlewords-stretch 0)
  (setq bibtex-autokey-titleword-length nil)
  (setq bibtex-autokey-titleword-ignore '("A"       "a"
                                          "An"      "an"
                                          "The"     "the"
                                          "Above"   "above"
                                          "About"   "about"
                                          "Across"  "across"
                                          "Against" "against"
                                          "Along"   "along"
                                          "Among"   "among"
                                          "Around"  "around"
                                          "At"      "at"
                                          "Before"  "before"
                                          "Behind"  "behind"
                                          "Below"   "below"
                                          "Beneath" "beneath"
                                          "Beside"  "beside"
                                          "Between" "between"
                                          "Beyond"  "beyond"
                                          "By"      "by"
                                          "Down"    "down"
                                          "During"  "during"
                                          "Except"  "except"
                                          "For"     "for"
                                          "From"    "from"
                                          "In"      "in"
                                          "Inside"  "inside"
                                          "Into"    "into"
                                          "Is"      "is"
                                          "It"      "it"
                                          "Its"      "its"
                                          "Like"    "like"
                                          "Near"    "near"
                                          "Of"      "of"
                                          "Off"     "off"
                                          "On"      "on"
                                          "Onto"    "onto"
                                          "Since"   "since"
                                          "To"      "to"
                                          "Toward"  "toward"
                                          "Through" "through"
                                          "Under"   "under"
                                          "Until"   "until"
                                          "Up"      "up"
                                          "Upon"    "upon"
                                          "With"    "with"
                                          "Within"  "within"
                                          "Without" "without"
                                          "And"     "and"
                                          "But"     "but"
                                          "For"     "for"
                                          "Nor"     "nor"
                                          "Or"      "or"
                                          "So"      "so"
                                          "Yet"     "yet"))
  (setq bibtex-autokey-titleword-case-convert-function #'s-upper-camel-case)
  (setq bibtex-autokey-titleword-separator ""))

;;;###autoload
(defun aar/bibtex-generate-autokey ()
  "Generate a citation key for a BibTeX entry using the author, year and title.
This uses the same components as `bibtex-generate-autokey' but combines them in
a different order. `bibtex-generate-autokey' combines components according to
(name, year, title). Here, the combination is (year, name, title). See the
documentation for `bibtex-generate-autokey' for more details."
  (interactive)
  (let* ((names (bibtex-autokey-get-names))
         (year (bibtex-autokey-get-year))
         (title (bibtex-autokey-get-title))
         (autokey (concat year names title)))
    autokey))

;;;###autoload
(defun aar/insert-bibtex-autokey ()
  "Insert autogenerated citation key for BibTeX entry at point."
  (interactive)
  (insert (aar/bibtex-generate-autokey)))

;;;###autoload
(defun aar/bibtex-mode-h ()
  (require 's)
  ;; (visual-line-mode)
  (display-line-numbers-mode))

(aar/localleader
  :keymaps 'bibtex-mode-map
  "k" #'aar/insert-bibtex-autokey)

(add-hook 'bibtex-mode-hook #'aar/bibtex-mode-h)

(use-package ebib
  :init
  (setq ebib-default-directory "~/Dropbox/research/")
  (setq ebib-bibtex-dialect 'biblatex)
  (setq ebib-file-associations '())
  (setq ebib-save-indent-as-bibtex t)
  ;; Open pdf files in zathura
  ;; (with-eval-after-load 'ebib
  ;;   (add-to-list 'ebib-file-associations '("pdf" . "zathura")))

  ;; Open pdf files in Skim
  ;; (with-eval-after-load 'ebib
  ;;   (add-to-list 'ebib-file-associations
  ;;                '("pdf" . (lambda (fpath)
  ;;                            (call-process "open"  nil 0 nil "-a" "/Applications/Skim.app" fpath)))))

  (setq ebib-bib-search-dirs '("~/Dropbox/research/"
                               "~/Dropbox/research/ongoing/"))
  (setq ebib-preload-bib-files '("bibliography.bib"))
  (setq ebib-file-search-dirs '("~/Dropbox/research/readings/"))
  (setq ebib-truncate-file-names nil)

  ;; Some layout tweaks
  (setq ebib-layout 'custom)
  (setq ebib-width 0.5)

  ;; Reading list
  (setq ebib-reading-list-file "~/Dropbox/org/readinglist.org")

  :general
  (:keymaps 'ebib-index-mode-map
	    [remap save-buffer] #'ebib-save-current-database)
  (aar/leader
    "a b" #'ebib)
  (aar/localleader
    :keymaps 'ebib-index-mode-map
    "." #'ebib-jump-to-entry
    "m" #'ebib-merge-bibtex-file))

;;;###autoload
(defun aar/ebib-entry-mode-h ()
  (setq-local show-trailing-whitespace nil))

;;;###autoload
(defun aar/ebib-index-mode-h ()
  (visual-line-mode -1))

(add-hook 'ebib-entry-mode-hook #'aar/ebib-entry-mode-h)
(add-hook 'ebib-index-mode-hook #'aar/ebib-index-mode-h)

(use-package markdown-mode
  :init
  (setq markdown-enable-math t))

(use-package polymode)

(use-package poly-markdown)

(use-package poly-R)

(add-to-list 'auto-mode-alist '("\\.[rR]md\\'" . poly-markdown+R-mode))

(use-package org
  :init
  (setq org-directory "~/Dropbox/org/")
  (setq org-default-notes-file (concat org-directory "notes.org"))
  (setq org-capture-templates
          '(("t" "Todo" entry
             (file+headline (concat org-directory "todo.org") "Inbox")
             "* TODO %?\n%i\n%a" :prepend t)
            ("n" "Personal notes" entry
             (file+headline org-default-notes-file "Inbox")
             "* %u %?\n%i\n%a" :prepend t)))
  (setq org-indent-mode nil)
  (setq org-startup-indented nil)
  (setq org-adapt-indentation nil)
  (setq org-hide-leading-stars nil)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-latex-prefer-user-labels t)
  (setq org-src-preserve-indentation t)
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-return-follows-link t)
  (setq org-use-sub-superscripts '{})
  (setq org-highlight-latex-and-related '(native latex script entities))
  (setq org-confirm-babel-evaluate #'aar/org-confirm-babel-evaluate)
  (setq org-file-apps '((auto-mode . emacs)
                        (directory . emacs)
                        ("\\.mm\\'" . default)
                        ("\\.x?html?\\'" . default)
                        ("\\.pdf\\'" . emacs)))

  (with-eval-after-load 'org
    (plist-put org-format-latex-options :scale 1.75)
    (plist-put org-format-latex-options :background 'default)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (shell . t)
       (R . t)
       (python . t))))

  (with-eval-after-load 'ox-latex
    ;; Configuration
    (setq org-latex-listings t)
    (setq org-latex-hyperref-template nil)
    (setq org-latex-pdf-process
          `(,(concat "latexmk "
                     "-pdflatex='pdflatex -interaction nonstopmode' "
                     "-pdf "
                     "-bibtex "
                     "-f %f")))

    (add-to-list 'org-latex-classes
                 `("aar-article"
                   ,(concat "\\documentclass[letterpaper,11pt]{article}\n"
                            "[NO-DEFAULT-PACKAGES]\n"
                            "[EXTRA]")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
    (add-to-list 'org-latex-classes
                 '("book-noparts"
                   "\\documentclass[11pt]{book}"
                   ("\\chapter{%s}" . "\\chapter*{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
    (add-to-list 'org-latex-classes
                 '("report"
                   "\\documentclass[11pt]{report}"
                   ("\\chapter{%s}" . "\\chapter*{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

    (setq org-latex-default-class "aar-article")))

;;;###autoload
(defun aar/org-mode-h ()
  (auto-fill-mode)
  (adaptive-wrap-prefix-mode))

(add-hook 'org-mode-hook #'aar/org-mode-h)
(add-hook 'org-capture-mode-hook #'evil-insert-state)

;;;###autoload
(evil-define-motion evil-org-top ()
  "Find the nearest one-star heading."
  :type exclusive
  :jump t
  (while (org-up-heading-safe)))

(evil-define-key '(normal visual motion) org-mode-map
  (kbd "[ h") #'org-backward-heading-same-level
  (kbd "] h") #'org-forward-heading-same-level
  (kbd "[ l") #'org-previous-link
  (kbd "] l") #'org-next-link
  (kbd "[ c") #'org-babel-previous-src-block
  (kbd "] c") #'org-babel-next-src-block
  (kbd "g h") #'org-up-element
  (kbd "g l") #'org-down-element
  (kbd "g k") #'org-backward-element
  (kbd "g j") #'org-forward-element
  (kbd "g H") #'evil-org-top)

(aar/localleader
  :keymaps 'org-mode-map
  "."   #'consult-org-heading
  "p"   #'org-preview-latex-fragment
  "l t" #'org-toggle-link-display
  "l i" #'org-toggle-inline-images
  "e"   #'org-export-dispatch
  "a"   #'org-latex-export-to-pdf
  "t"   #'org-toggle-checkbox)

;;;###autoload
(defun aar/find-file-in-org-directory ()
  (interactive)
  (let ((default-directory org-directory))
    (call-interactively #'find-file)))

;;;###autoload
(defun aar/jump-to-todo-file ()
  (interactive)
  (find-file (expand-file-name "todo.org" org-directory)))

;;;###autoload
(defun aar/jump-to-bookmarks-file ()
  (interactive)
  (find-file (expand-file-name "bookmarks.org" org-directory)))

;;;###autoload
(defun aar/jump-to-readinglist-file ()
  (interactive)
  (find-file (expand-file-name "readinglist.org" org-directory)))

(aar/leader
  "o"   '(nil :which-key "org")
  "o o" #'aar/find-file-in-org-directory
  "o t" #'aar/jump-to-todo-file
  "o b" #'aar/jump-to-bookmarks-file
  "o r" #'aar/jump-to-readinglist-file)

(provide 'init)
;;; init.el ends here
