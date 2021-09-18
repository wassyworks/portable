(eval-and-compile
  (when (or  load-file-name byte-compile-current-file)
    (setq user-emacs-directory
      (expand-file-name 
        (file-name-directory (or load-file-name byte-compile-current-file))))))

;; leaf install code
(eval-and-compile
  (customize-set-variable
    'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))
    (leaf leaf-keywords
      :ensure t
      :init
      (leaf hydra :ensure t)
      (leaf el-get :ensure t)
      (leaf blackout :ensure t)
      :config
      (leaf-keywords-init)))

;; 設定
(global-display-line-numbers-mode t)
;; linum-modeは重いので切る
(global-linum-mode -1)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; フォント(windows)
(when (eq system-type 'windows-nt)
  (add-to-list 'default-frame-alist '(font . "Meiryo UI-12")))
;; ファイルサイズをモードラインに表示
(size-indication-mode t)

;; 改行文字の文字列表現
(set 'eol-mnemonic-dos "(CRLF)")
(set 'eol-mnemonic-unix "(LF)")
(set 'eol-mnemonic-mac "(CR)")
(set 'eol-mnemonic-undecided "(?)")

;; 前方検索
(global-set-key (kbd "M-i") 'isearch-forward)
;; ヘルプキーを変更し、代わりにbackspaceをC-hに割当
(global-set-key (kbd "M-?") 'help-command)
(global-set-key (kbd "C-h") 'delete-backward-char)

(leaf autorevert
  :doc "revert buffers when files on disk changed"
  :custom ((auto-revert-interval . 1))
  :global-minor-mode global-auto-revert-mode)

(leaf paren
  :doc "highlight matching paren"
  :custom ((show-paren-delay . 0.1))
  :global-minor-mode show-paren-mode)

(leaf files
  :doc "file input and output commands for Emacs"
  :custom '((auto-save-defailt . nil)
	    (make-backup-files . nil)))

(leaf ivy
  :doc "Incremental vertical comletion"
  :ensure t
  :blackout t
  :leaf-defer nil
  :custom ((ivy-initial-imputs-alist . nil)
	   (ivy-use-selectable-prompt . t))
  :global-minor-mode t
  :config
  (leaf swiper
    :doc "Isearch with an overview"
    :ensure t
    :bind (("C-s" . swiper)))
  (leaf counsel
    :doc "Various completion functions using ivy"
    :ensure t
    :blackout t
    :bind (("C-S-s" . counsel-imenu)
	   ("C-x C-r" . counsel-recentf))
    :global-minor-mode t))
(leaf prescient
  :doc "Better sorting and filtering"
  :ensure t
  :after precient ivy
  :custom ((ivy-prescient-retain-classic-highlighting . t))
  :global-minor-mode t)

(leaf evil
  :doc "vim keybind"
  :ensure t
  :config (evil-mode t))

;; web-mode
(leaf web-mode
  :ensure t
  :mode "\\.js\\'" "\\.php\\'"
  :config
  (setq web-mode-engines-alist
	'(("php", "\\phtml\\'") ("blade", "\\.blade\\.")))
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-auto-close-style 2)
  (setq web-mode-tag-auto-close-style 2))
  
;; which-key
(leaf which-key
  :doc "show key description"
  :ensure t
  :config
  (setq which-key-popup-type 'minibuffer)
  (setq which-key-max-description-length 28)
  (setq which-key-max-display-columns 6)
  (which-key-mode)
  )

(leaf magit
  :doc "git tool"
  :ensure t
  )

(leaf dracula-theme
  :doc "dracula theme"
  :ensure t
  :require t
  :config
  (load-theme 'dracula t)
  )
(provide 'init)


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(auto-revert-interval 1)
;;  '(auto-save-defailt nil t)
;;  '(custom-safe-themes
;;    '("81c3de64d684e23455236abde277cda4b66509ef2c28f66e059aa925b8b12534" default))
;;  '(ivy-initial-imputs-alist nil t)
;;  '(ivy-use-selectable-prompt t)
;;  '(make-backup-files nil)
;;  '(package-archives
;;    '(("org" . "https://orgmode.org/elpa/")
;;      ("melpa" . "https://melpa.org/packages/")
;;      ("gnu" . "https://elpa.gnu.org/packages/")))
;;  '(package-selected-packages '(blackout el-get hydra leaf-keywords leaf))
;;  '(show-paren-delay 0.1))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(font-lock-comment-face ((t (:foreground "color-38"))))
;;  '(minibuffer-prompt ((t (:foreground "brightcyan")))))
