
;; init.el --- Emacs configuration

;; Install PACKAGES
;; --------------------------------------

(require 'package)


(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
       '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    magit
    ein
    elpy
    flycheck
    skype
    neotree
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(setq mac-command-modifier 'control)
(tool-bar-mode -1)
(neotree-show)
;; Display Visited File's Path in the Frame Title
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))
(set-frame-font "Andale Mono 15" nil t)
(whitespace-mode)
;; CTRL-TAB switch between windows
(defun ctrltab ()
  "List buffers and give it focus"
  (interactive)
  (if (string= "*Buffer List*" (buffer-name))
      ;; Go to next line. Go to first line if end is reached.
      (progn
        (revert-buffer)
        (if (>= (line-number-at-pos)
                (count-lines (point-min) (point-max)))
            (goto-char (point-min))
          (forward-line)))
    (list-buffers)
    (switch-to-buffer "*Buffer List*")
    (forward-line)))
(global-set-key [C-tab] 'ctrltab)
;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; Wind Move setup
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; PYTHON CONFIGURATION
;; --------------------------------------
(elpy-enable))
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")
(setq elpy-rpc-backend "jedi")

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; SKYPE CONFIGURATION
;; --------------------------------------
(require 'skype)
(setq skype--my-user-handle "flyermc")
;; init.el ends here
