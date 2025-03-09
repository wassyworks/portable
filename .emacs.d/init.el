;; MELPAリポジトリを登録
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; 設定
(global-display-line-numbers-mode t)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; ガベージコレクションのしきい値を設定
(setq gc-cons-threshold (* 32 1024 1024))

;; フォント(windows)
(when (eq system-type 'windows-nt)
  (add-to-list 'default-frame-alist '(font . "Moralerspace Neon-12"))
  ;; (add-to-list 'default-frame-alist '(font . "Meiryo UI-12"))
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

;; 現在入力しているキーに続く候補をミニバッファに表示するwhich-key-modeを有効化
(which-key-mode t)

;; ミニバッファの履歴を保存する
(savehist-mode 1)

;; 前方検索
(global-set-key (kbd "M-i") 'isearch-forward)
;; ヘルプキーを変更し、代わりにbackspaceをC-hに割当
(global-set-key (kbd "M-?") 'help-command)
(global-set-key (kbd "C-h") 'delete-backward-char)

;; vim風味のモーダル編集機能を提供するパッケージ
(use-package meow
  :ensure t
  :load-path "~/.emacs.d/meow-config/"
  :config 
  (require 'meow-keybindings)
  (meow-keybindings-setup)
  (setq meow-use-clipboard t)
  (meow-global-mode 1)
  )

;; 補完UIパッケージ
(use-package vertico
  :ensure t
  :custom
  (vertico-count 8)
  (vertico-cycle t)
  :init
  (vertico-mode)
  )


;; verticoの補完UIに対して順序不問の文字列一致検索を提供するパッケージ
(use-package orderless
  :ensure t
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; 候補表示パッケージ
(use-package consult
  :ensure t
  :bind
  (("C-x b" . consult-buffer) ;; バッファ表示
   ("M-s g" . consult-ripgrep)
   ("M-s G" . consult-git-grep)
   ("C-s" . consult-line)
   )
  )

(use-package magit
  :ensure t
  )

;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; カスタムできるダッシュボード
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-startup-banner 'logo) ;; dashboardのロゴを使用
  (dashboard-setup-startup-hook) ;; 起動時にdashboardの画面を表示
  )

(load-theme 'modus-vivendi)
;; (use-package kuronami-theme
;;   :ensure t
;;   :config
;;   (load-theme 'kuronami t)
;;   )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
