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

;; 確認無しでバッファをrevert
(defun ws-revert-buffer-without-confirmation ()
  "Revert buffer without confirmation"
  (interactive)
  (revert-buffer t t)
  (message "Reverted `%s'" (buffer-name))
  )
(global-set-key (kbd "C-c r") 'ws-revert-buffer-without-confirmation)

;; 文字コード
(prefer-coding-system 'utf-8-unix)

;; バッファのLispコードを評価
(global-set-key (kbd "C-c e") 'eval-buffer)

;; 折り返しの切り替え
(global-set-key (kbd "C-c t") 'toggle-truncate-lines)

;; 行番号表示
(global-display-line-numbers-mode t)
;; linum-modeは重いので切る
(global-linum-mode -1)

;; タブ入力の代わりにスペースを使う
(setq-default indent-tabs-mode t)
;; タブ幅を4に設定
(setq-default tab-width 4)

;; フォント/UI (windows)
(when (eq system-type 'windows-nt)
  (scroll-bar-mode -1)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (add-to-list 'default-frame-alist '(font . "Meiryo UI-12")))

;; MacOS
(when (eq system-type 'darwin)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (set-face-attribute 'default nil
                    :family "Menlo"
                    :height 160
                    :weight 'normal
                    :width 'normal)
  )

;; ファイルサイズをモードラインに表示
(size-indication-mode t)

;; 閉じ括弧の自動入力
(electric-pair-mode t)

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

;; ファイル履歴保存数を拡張
(setq recentf-max-saved-items 1000)
(setq recentf-max-menu-items 15)
(recentf-mode 1)

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
  :custom '((auto-save-defailt . nil) ; #file# のような自動保存ファイルを作らない
	    (make-backup-files . nil) ; file~ のような自動バックアップファイルを作らない
	    (create-lockfiles . nil))) ; .#file のようなロックファイルを作らない

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
  :global-minor-mode t)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  )

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

(leaf company
  :ensure t
  :config
  (global-company-mode) ; 全バッファで有効にする 
  (setq company-idle-delay 0.1) ; デフォルトは0.5
  (setq company-minimum-prefix-length 3) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
  (define-key company-mode-map (kbd "C-,") 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  )

;; javascript
(leaf js2-mode
  :ensure t
  :mode "\\.js\\'"

  )
;; web-mode
(leaf web-mode
  :ensure t
  :mode "\\.php\\'" "\\.ejs\\'"
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

;; かっこの色付け
(leaf rainbow-delimiters
  :doc "rainbow colored paranthesis"
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  )

(leaf magit
  :doc "git tool"
  :ensure t
  )
(leaf org
  :doc "latest org-mode"
  :ensure t
  :mode "\\.org\\'"
  :config
  (setq org-startup-indented t)
  (setq org-startup-folded 'content)
  )

(leaf evil-org
  :doc "evil-mode key bindings to Emacs org-mode"
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  )

(leaf dockerfile-mode
  :doc "dockerfile-mode"
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile*\\'" . dockerfile-mode))
  )

(leaf docker-compose-mode
  :doc "docker-compose-mode"
  :ensure t
  )

(leaf elpy
  :doc "python development"
  :ensure t
  )
(leaf rust-mode
  :doc "rust mode"
  :ensure t
  :require t
  :config (setq rust-format-on-save t)
  )
(leaf cmake-mode
  :doc "cmake mode"
  :ensure t
  :require t
  )

(leaf markdown-mode
  :doc "markdown"
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; TypeScript
(leaf typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  )

;; theme
(leaf dracula-theme
  :doc "dracula theme"
  :ensure t
  :require t
  :config
  (load-theme 'dracula t)
  )
(provide 'init)

(when (eq system-type 'windows-nt)
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(auto-revert-interval 1)
   '(auto-save-defailt nil t)
   '(custom-safe-themes
     '("81c3de64d684e23455236abde277cda4b66509ef2c28f66e059aa925b8b12534" default))
   '(ivy-initial-imputs-alist nil t)
   '(ivy-use-selectable-prompt t)
   '(make-backup-files nil)
   '(package-archives
     '(("org" . "https://orgmode.org/elpa/")
       ("melpa" . "https://melpa.org/packages/")
       ("gnu" . "https://elpa.gnu.org/packages/")))
   '(package-selected-packages '(blackout el-get hydra leaf-keywords leaf))
   '(show-paren-delay 0.1))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(font-lock-comment-face ((t (:foreground "color-38"))))
   '(minibuffer-prompt ((t (:foreground "brightcyan"))))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-interval 1)
 '(auto-save-defailt nil t)
 '(create-lockfiles nil)
 '(custom-safe-themes
   '("81c3de64d684e23455236abde277cda4b66509ef2c28f66e059aa925b8b12534" default))
 '(ivy-initial-imputs-alist nil t)
 '(ivy-use-selectable-prompt t)
 '(make-backup-files nil)
 '(package-archives
   '(("org" . "https://orgmode.org/elpa/")
	 ("melpa" . "https://melpa.org/packages/")
	 ("gnu" . "https://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(typescript-mode js2-mode which-key web-mode rust-mode rainbow-delimiters prescient markdown-mode magit leaf-keywords hydra evil elpy el-get dracula-theme dockerfile-mode docker-compose-mode counsel cmake-mode blackout))
 '(show-paren-delay 0.1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "color-38"))))
 '(minibuffer-prompt ((t (:foreground "brightcyan")))))
