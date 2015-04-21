;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; 自動保存と自動バックアップ
;;; auto-save-buffers-enhanced: 定期自動保存
;;;; http://rubikitch.com/2014/11/23/auto-save-buffers-enhanced/
;;; backup-each-save: 保存時に自動バックアップ
;;;; http://rubikitch.com/2014/11/02/backup-each-save/
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; 標準の自動バックアップと自動保存機能を停止
(setq make-backup-files nil)
(setq auto-save-default nil)

;;; ロックファイルの生成を抑止
(setq create-lockfiles nil)

;;; auto-save-buffers-enhanced
;;;; ロードと設定
(use-package auto-save-buffers-enhanced
  :config
  ;; オートセーブするまでの待ち時間 (秒)
  (setq auto-save-buffers-enhanced-interval 1.5)
  ;; 特定のファイルのみ有効にする
  (setq auto-save-buffers-enhanced-include-regexps '(".+")) ;全ファイル
  ;; not-save-fileと.ignoreは除外する
  (setq auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$"))
  ;; Wroteのメッセージを抑制
  (setq auto-save-buffers-enhanced-quiet-save-p t)
  ;; *scratch* も ~/.emacs.d/backups/scratch に自動保存
  (setq auto-save-buffers-enhanced-save-scratch-buffer-to-file-p t)
  (setq auto-save-buffers-enhanced-file-related-with-scratch-buffer
        (locate-user-emacs-file "backups/scratch"))
  (auto-save-buffers-enhanced t)
  ;; "C-x a s" で auto-save-buffers-enhanced の有効・無効をトグル
  (bind-key "C-x a s" 'auto-save-buffers-enhanced-toggle-activity))

;;; backup-each-save
;;;; ロードと設定
(use-package backup-each-save
  :init
  (add-hook 'after-save-hook 'backup-each-save)
  :config
  ;; バックアップ先指定
  (setq backup-each-save-mirror-location "~/.emacs.d/backups")
  ;; バックアップファイルにつけるサフィックス
  (setq backup-each-save-time-format "%y%m%d_%H%M%S")
  ;; バックアップするファイルサイズの上限
  (setq backup-each-save-size-limit 5000000)
  ;; .recentf ファイルの除く、すべてのファイルをバックアップ
  (defun backup-each-save-no-recentf (filename)
    (cond
      ((string= (file-name-nondirectory filename) "recentf") nil)
      (t t)))
  (setq backup-each-save-filter-function 'backup-each-save-no-recentf))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; ミニバッファ履歴を保持する
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ミニバッファ履歴保存ファイル指定
(setq savehist-file "~/.emacs.d/history")

;;; 履歴数を大きくする
(setq history-length 10000)

;;; 同じ内容を履歴に記録しないようにする
(setq history-delete-duplicates t)

;;; 有効化
(savehist-mode t)

;; Helm でもコマンド履歴を表示するように
(require 'cl-lib)
(when (not (cl-find 'extended-command-history savehist-minibuffer-history-variables))
    (add-to-list 'savehist-minibuffer-history-variables 'extended-command-history))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; saveplace: カーソルの位置情報を保持する
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package saveplace
  :config
  (setq save-place-file (concat user-emacs-directory "places"))
  (setq-default save-place t))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; recentf/recentf-ext: 最近使ったファイル
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package recentf
  :config
  ;; セーブファイルを指定
  (setq recentf-save-file "~/.emacs.d/recentf")
  ;; 最大登録ファイル数を 10000 にする
  (setq recentf-max-saved-items 10000))

;;; recentf の対象をファイルからディレクトリまで拡張する
(use-package recentf-ext)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; プレフィックスキーの登録
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; "C-q" をオリジナルのプレフィックスキーにする
(defvar poco-key-map (make-sparse-keymap)
  "My original keymap binded to C-q for original key binding.")
(defalias 'poco-prefix-key poco-key-map)
(bind-key "C-q" 'poco-prefix-key)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; 終了コマンドのエイリアス
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; "C-x C-c" で終了しないように設定するため、
;;;; "exit" を新たに終了コマンドとして定義する
(defalias 'exit 'save-buffers-kill-emacs)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; サーバとして起動する
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package server
  :config
  (unless (server-running-p)
    (server-start)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; その他の設定
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ガベージコレクションの回数を調整
;;;; (8MiB にする。デフォルトは 400KiB)
(setq gc-cons-threshold (* 8 1024 1024))

;;; 常に新しい設定ファイルを読み込む
;;;; (バイトコンパイルされたものを含む)
(setq load-prefer-newer t)

;;; 変更のあったファイルの自動再読み込み
(global-auto-revert-mode t)

;;; save-buffer 時、buffer 末尾に空行が常にあるようにする
(setq require-final-newline t)

;;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;;; シンボリックリンクを開くときの質問省略
(setq vc-follow-symlinks t)

;;; C-u C-SPC C-SPC ...でどんどん過去のマークを遡る
(setq set-mark-command-repeat-pop t)

;;; Emacs からの質問を y/n に
(fset 'yes-or-no-p 'y-or-n-p)

;;; コメントアウトの形式変更
(setq comment-style 'multi-line)

;;; ログの記録行数を増やす
(setq message-log-max 10000)

;;; インデントスタイル
;;;; インデント (Tab) の初期値を 4 スペースに
(setq-default tab-width 4 indent-tabs-mode nil)

;;; customize 情報の出力先を指定
(setq custom-file "~/.emacs.d/emacs.my.custom.el")
(if (file-exists-p (expand-file-name "~/emacs.my.custom.el"))
    (load (expand-file-name custom-file) t nil nil))
