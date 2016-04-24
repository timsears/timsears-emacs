(require 'nix-mode)
(require 'magit)
(require 'haskell-mode)
(require 'ido)
(require 'smex)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(haskell-interactive-mode-eval-pretty nil)
 '(haskell-interactive-mode-include-file-name nil)
 '(haskell-notify-p t)
 '(haskell-process-args-ghci (quote nil))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-do-cabal-format-string ":!cd %s && unset GHC_PACKAGE_PATH && %s")
 '(haskell-process-log t)
 '(haskell-process-reload-with-fbytecode nil)
 '(haskell-process-show-debug-tips nil)
 '(haskell-process-suggest-haskell-docs-imports t)
 '(haskell-process-suggest-hoogle-imports nil)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote auto))
 '(haskell-process-use-presentation-mode t)
 '(haskell-stylish-on-save nil)
 '(haskell-tags-on-save t)
 '(hindent-style "chris-done")
 '(magit-status-buffer-switch-function (quote switch-to-buffer))
 '(safe-local-variable-values
   (quote
    ((haskell-indent-spaces . 4)
     (haskell-indent-spaces . 2)
     (haskell-process-type . cabal-repl)
     (shm-lambda-indent-style . leftmost-parent))))
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 143 :width normal))))
 '(erc-my-nick-face ((t (:foreground "#dca3a3" :weight bold)))))

;;my settings

(ido-mode t)
(smex-initialize)

(eval-after-load "haskell-cabal"
  '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

(define-key key-translation-map (kbd "<C-M-mouse-1>") (kbd "<mouse-3>"))

;; enable auto-completion via company (COMPlete ANYthing) mode instead of auto-completa mode
(require 'company)
;;(add-hook 'after-init-hook 'global-company-mode) ;; turns company on for all files
(add-hook 'haskell-mode-hook 'company-mode)
(add-hook 'haskell-interactive-mode-hook 'company-mode)
(add-to-list 'company-backends 'company-ghc)
(custom-set-variables '(company-ghc-show-info t))

;; helps emacs use a nix-shell to find the right ghc. I had to run emacs in a nix-shell once to initialize. After that the shell is not needed.
(setq haskell-process-wrapper-function
        (lambda (args) (apply 'nix-shell-command (nix-current-sandbox) args)))


;; If you want to trigger auto-complete using TAB in REPL buffers, you may
;; want to use auto-complete in your `completion-at-point-functions':
(defun set-auto-complete-as-completion-at-point-function ()
  (add-to-list 'completion-at-point-functions 'company-complete))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'haskell-interactive-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'haskell-mode-hook 'set-auto-complete-as-completion-at-point-function)


;; ghc-mod
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; indentation
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; match parens with colors
(require 'rainbow-delimiters)
(add-hook 'haskell-mode-hook 'rainbow-delimiters-mode)

;; navigate camelCase with M-f
(add-hook 'haskell-mode-hook 'subword-mode)

;; haskell-mode key bindings...commented out keys conflict with ghc-mod
(eval-after-load "haskell-mode"
  '(progn
     (define-key haskell-mode-map (kbd "<space>") 'haskell-mode-contextual-space)
     (define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
     (define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)
     (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
     ;;(define-key haskell-mode-map (kbd "C-<left>") 'haskell-move-left)
     ;;(define-key haskell-mode-map (kbd "C-<right>") 'haskell-move-right)
     (define-key haskell-mode-map (kbd "C-<left>") 'ghc-make-indent-shallower)
     (define-key haskell-mode-map (kbd "C-<right>") 'ghc-make-indent-deeper)
     (define-key haskell-mode-map [f5] 'haskell-compile)
     (define-key haskell-mode-map [f8] 'haskell-navigate-imports)
     ;;(define-key haskell-mode-map (kbd "M-,") 'haskell-who-calls)
     ;;(define-key haskell-mode-map (kbd "C-c C-a") 'haskell-insert-doc)
     (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
     ;;(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
     ;;(define-key haskell-mode-map (kbd "C-c C-d") nil)
     ;;(define-key haskell-mode-map (kbd "C-c C-d") 'haskell-w3m-open-haddock)
     (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
     ;;(define-key haskell-mode-map (kbd "C-c i") 'hindent/reformat-decl)
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
     ;;(define-key haskell-mode-map (kbd "C-c C-u") 'haskell-insert-undefined)
     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
     ;;(define-key haskell-mode-map (kbd "C-c M-.") nil)
     

))


