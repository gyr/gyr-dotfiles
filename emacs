;; .emacs file for configuring emacs
;; Author: Gustavo Yokoyama Ribeiro
;; Update: 23 Dec 2005
;; (C) Copyright 2010 Gustavo Yokoyama Ribeiro
;; Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
;; http://creativecommons.org/licenses/by-sa/3.0/ for more info.

;; Supress the GNU startup message
(setq inhibit-startup-message t)

;; Make the buffer re-highlight when we recenter
(global-set-key "\C-\\" 'hilit-highlight-buffer)
(global-set-key "\C-l" 'recenter)

;; Get backspace key to work properly on many machines.
(setq term-setup-hook
      '(lambda()
         (setq keyboard-translate-table "\C-@\C-a\C-b\C-c\C-d\C-e\C-f\C-g\C-?")
         (global-set-key "\M-h" 'help-for-help)))

;; No tabs-- use spaces when indenting (doesn't affect Makefiles, 
;; does affect text files and code, doesn't affect existing tabs).
;; The use of setq-default means this only affects modes that don't
;; overwrite this setting.
(setq-default indent-tabs-mode nil)
;; Tab width
(setq tab-width 4)

;; get C and C++ editting to work on the proper files
(setq auto-mode-alist
        (append '(("\\.c$" . c-mode)
                  ("\\.h$" . c++-mode)
                  ("\\.C$" . c++-mode)
                  ("\\.c[+][+]$" . c++-mode))
                auto-mode-alist))

;; give us perl editting features on .pl files (instead of prolog)
;;(load-file "/usr/gnu/lib/emacs/19.22/lisp/perl-mode.el")
(setq auto-mode-alist
      (append '(("\\.pl$" . perl-mode))
              auto-mode-alist))

;; Show latin characters
(standard-display-european 1)

(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)

;; Colors Options
;; ==============

; Show selections
(transient-mark-mode 1)
(set-face-foreground 'region "black")
(set-face-background 'region "PaleTurquoise1")


; Main Set Up
(set-foreground-color "PaleTurquoise1")
(set-background-color "black")
(set-cursor-color "Tomato")

; Status bar
(set-face-foreground 'modeline "Black")
;(set-face-font 'modeline "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Status bar
(set-face-background 'modeline "PaleTurquoise1")
;(set-face-font 'modeline "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Builtin
(set-face-foreground 'font-lock-builtin-face "Thistle")
;(set-face-font 'font-lock-builtin-face "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Comments
(set-face-foreground 'font-lock-comment-face "DeepSkyBlue")
;(set-face-font 'font-lock-comment-face "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Constants
(set-face-foreground 'font-lock-constant-face "LighSkyBlue")
;(set-face-font 'font-lock-constant-face "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Functions
(set-face-foreground 'font-lock-function-name-face "OrangeRed")
;(set-face-font 'font-lock-function-name-face "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Keywords
(set-face-foreground 'font-lock-keyword-face "Turquoise")
;(set-face-font 'font-lock-keyword-face "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Strings
(set-face-foreground 'font-lock-string-face "PaleGreen")
;(set-face-font 'font-lock-string-face "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Types
(set-face-foreground 'font-lock-type-face "Cyan")
;(set-face-font 'font-lock-type-face "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Variables
(set-face-foreground 'font-lock-variable-name-face "Yellow")
;(set-face-font 'font-lock-variable-name-face "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Warnings
(set-face-foreground 'font-lock-warning-face "hotpink2")
;(set-face-font 'font-lock-variable-name-face "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

; Hiperlinks
(set-face-foreground 'highlight "red")
;(set-face-font 'highlight "-*-lucidatypewriter-*-r-*-*-*-100-*-*-*-*-iso8859-1")

;(set-face-font 'default "-*-lucidatypewriter-medium-r-normal-*-*-100-*-*-*-*-iso8859-1")

(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

(highlight-changes-mode 1)
(setq display-time-24hr-format t)

(setq column-number-mode t)
(setq line-number-mode t)

; Turn OFF auto-save
(setq auto-save-default nil)

;; Show filename on title bar
(setq frame-title-format "%b - Emacs")

; Use unix line-feeds when saving (muck with the file-coding-alist to
; change them on loading).  This doesn't actually do much since
; something in windows Emacs overrides this for every buffer.
'(default-buffer-file-coding-system (quote undecided-unix))

; Heavy handed approach to eliminating DOS EOLN's (13 10): force all
; files written to have unix EOLNs (10).
'(coding-system-for-write (quote undecided-unix))

(setq next-line-add-newlines nil)

(fset 'yes-or-no-p (symbol-function 'y-or-n-p))

(setq require-final-newline 'ask)

(setq font-lock-maximum-size 900000)

;; Shortcuts
(global-set-key "\C-c=" 'ediff)
(global-set-key "\C-ca" 'rda)
(global-set-key "\C-cb" 'bury-buffer)
(global-set-key "\C-cc" 'compile)
(global-set-key "\C-cd" 'gdb)
(global-set-key "\C-ci" 'insert-buffer)
(global-set-key "\C-cl" 'load-file)
(global-set-key "\C-cL" 'load-library)
(global-set-key "\C-cm" 'man)
(global-set-key "\C-cn" 'gnus)
(global-set-key "\C-co" 'outline-minor-mode)
(global-set-key "\C-cr" 'rmail)
(global-set-key "\C-cs" 'grep)
(global-set-key "\C-cv" 'set-variable)
(global-set-key "\C-cx" 'imenu)
(global-set-key "\C-c\M-%" 'query-replace-regexp)

(global-set-key "\C-x\C-b" 'buffer-menu)

; Bind dired-jump before dired-x.el is loaded.

(define-key global-map "\C-x\C-j" 'dired-jump)

(global-set-key "" 'query-replace-regexp)             ; M-C-r
; RETURN: New 
(global-set-key "
" 'newline-and-indent)          ; RETURN
; F2: save
(global-set-key [f2] 'save-buffer)
; F3: load
(global-set-key [f3] 'find-file)
; F4: save all
(global-set-key [f4] 'save-some-buffers)
; F5: dired
(global-set-key [f5] 'dired)
; F6: go to line
(global-set-key [f6] 'goto-line)
(global-set-key "\C-cg" 'goto-line)
; F9: kill current bullfer
(global-set-key [f9] 'kill-buffer)
; HOME
(global-set-key [home] 'beginning-of-line) 
; END
(global-set-key [end] 'end-of-line) 
; CONTROL HOME
(global-set-key [\C-home] 'beginning-of-buffer)
; Control END
(global-set-key [\C-end] 'end-of-buffer)
;  Control Backspace (UNDO)
(global-set-key [\C-backspace] 'undo)


; Define funcao para comparar pares de parenteses (ou inserir o caracter)
(global-set-key "\C-]" 'match-paren)
(defun match-paren (arg)
  "Vai para o parentese relacionado ou insere o caracter %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq load-path (append (list (expand-file-name "~/"))
			load-path))

; MINOR CUSTOMIZATIONS

;(load ".cplusplus")


(setq c-recognize-knr-p nil)


(enable-flow-control-on "vt100" "vt200" "vt220")


(setq scroll-step 1)


(add-hook 'dired-load-hook
          (function (lambda ()
                      (load "dired-x")
                      ;; Set dired-x global variables here.
                      (setq dired-guess-shell-gnutar "tar")
                      (setq dired-x-hands-off-my-keys nil)
                      (setq dired-guess-shell-alist-user
                            (list
                             (list "\\.Z$" "gzip -d")
                             (list "\\.tgz$" (if dired-guess-shell-gnutar (concat dired-guess-shell-gnutar " zxvf") (concat "gunzip -qc * | tar xvf -")) (concat "gunzip" (if dired-guess-shell-gzip-quiet " -q" "")))))
                      ;; Make sure our binding preference is invoked.
                      (dired-x-bind-find-file)
                      )))

; MODE HOOKS

;; Customizations for both c-mode and c++-mode
(defun my-c-mode-common-hook ()
  ;; set up for my perferred indentation style, but  only do it once
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-case-open '+)
  ;; other customizations
  (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode nil
        c-hanging-braces-alist '((inline-open) (inline-close)
                                 (brace-list-open) (brace-list-close)
                                 (block-close . c-snug-do-while)
                                 (substatement-open before after))
        c-cleanup-list '(empty-defun-braces
                         defun-close-semi
                         scope-operator))
  (c-toggle-auto-hungry-state 1))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(add-hook 'c++-mode-hook
          (function (lambda ()
                      (local-set-key "\C-c\C-h" 'c++-copyright-notice)
                      (local-set-key "\C-c\C-i" 'c++-include))))

(cond (window-system
;       (setq hilit-mode-enable-list  '(not text-mode)
;             hilit-background-mode   'light
;             hilit-inhibit-hooks     nil
;             hilit-inhibit-rebinding nil)
;       (require 'hilit19)))
       (global-font-lock-mode t)
       (setq-default font-lock-maximum-decoration t)))

;(setq font-lock-face-attributes
;      '((font-lock-comment-face "Sienna") 
;      (font-lock-string-face "VioletRed") 
;      (font-lock-keyword-face "BlueViolet")
;      (font-lock-function-name-face "Blue") 
;      (font-lock-variable-name-face "Gold")
;      (font-lock-type-face "DarkOliveGreen") 
;      (font-lock-reference-face "Firebrick")))
      
(setq font-lock-face-attributes
      '((font-lock-comment-face "Goldenrod") 
      (font-lock-string-face "LightBlue")
      (font-lock-keyword-face "WhiteSmoke")
      (font-lock-function-name-face "Yellow") 
      (font-lock-variable-name-face "Yellow")
      (font-lock-type-face "Cyan")
      (font-lock-reference-face "Green")))
      

(add-hook 'change-log-mode-hook
          (function (lambda ()
                      (local-set-key "\C-c\C-c" 'change-log-exit))))
          
(defun change-log-exit ()
  (interactive)
  (save-buffer)
  (bury-buffer)
  (if (or (not (= (window-height) (1- (frame-height))))
          (not (= (window-width) (frame-width))))
      (delete-window)))

(add-hook 'gdb-mode-hook
          (function
           (lambda ()
             (local-set-key "\t" 'comint-dynamic-complete)
             (local-set-key "\e?" 'comint-dynamic-list-completions))))

(add-hook 'mail-mode-hook
          (function (lambda () (local-set-key "\C-c\C-i" 'ispell-message))))

(add-hook 'mail-citation-hook 'sc-cite-original)

(add-hook 'rmail-mode-hook
          (function (lambda ()
                      (make-local-variable 'make-backup-files)
                      (setq make-backup-files nil))))

(add-hook 'rda-mode-hook
          (function (lambda ()
                      (setq fill-column 79
                            fill-prefix ";\t\t\t\t\t")
                      (auto-fill-mode 1))))

(add-hook 'text-mode-hook
          (function (lambda ()
                      (turn-on-auto-fill)
                      (iso-accents-mode 1))))

;; KEYBOARD CUSTOMIZATION

(defun my-changelog ()
  (interactive)
  (add-change-log-entry-other-window
   nil
   "/home/gustavo/.logbook"))

; ENABLING SOME ADVANCED COMMANDS
;(put 'eval-expression 'disabled nil)
;(put 'narrow-to-region 'disabled nil)
;(put 'narrow-to-page 'disabled nil)

(defun try-to-load-library (lib &optional afterwork)
  (if (load lib 'noerror 'nomessage)
      (eval afterwork)
    (beep)
    (message "Can't find the %s library." lib)))

(try-to-load-library "iso-acc" '(iso-accents-customize "portuguese"))
(try-to-load-library "iso-transl" '(iso-transl-set-language "portuguese"))
(try-to-load-library "paren")
(auto-compression-mode 1)

(setq vc-consult-headers t)

(setq vc-header-alist
      (append '((SCCS "%W%") (RCS "$Id$") (CVS "$Id$"))))

(setq vc-static-header-alist
      '(("\\.cxx$" .
	 "\nstatic char vcid[] = \"\@\(\#\)\$Id\$\";\n")
	("\\.hxx$" .
	 "\n// \$Id\$\n")
	("\\.h$" .
	 "\n/* \$Id\$ */\n")))

;(setq vc-static-header-alist
;      (append '(("\\.cxx$" .
;		   "\nstatic char vcid[] = \"\%s\";\n"))
;		vc-static-header-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; coisas gerais

(setq-default font-lock-auto-fontify t)
(setq-default font-lock-use-fonts nil)
(setq-default font-lock-use-colors t)

; modifica cores do font-lock-mode
;(setq font-lock-mode-maximum-decoration t)
;(require 'font-lock)
;(make-face 'highlight)


;; Options Menu Settings
;; =====================
(cond
 ((and (string-match "XEmacs" emacs-version)
       (boundp 'emacs-major-version)
       (or (and
            (= emacs-major-version 19)
            (>= emacs-minor-version 14))
           (= emacs-major-version 20))
       (fboundp 'load-options-file))
  (load-options-file "/home/wlk023/.xemacs-options")))
;; ============================
;; End of Options Menu Settings

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "ASCII")
 '(global-font-lock-mode t nil (font-lock))
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t))
