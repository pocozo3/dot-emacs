;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-
;;
;; パッケージの管理・インストール・設定
;;; from https://github.com/catatsuy/dot.emacs.d/blob/master/init.el
;;; from http://rubikitch.com/package-initialize/


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; パッケージシステム
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; パッケージ初期化
(fset 'package-desc-vers 'package--ac-desc-version)
(package-initialize)

;;; パッケージリポジトリに MELPA を追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;; 必要パッケージのインストール
(require 'cl-lib)
(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    use-package
    init-loader
    auto-save-buffers-enhanced
    backup-each-save
    recentf-ext
    color-theme
    color-theme-solarized
    migemo
    ddskk
    smart-newline
    popwin
    async
    direx
    ))
(let ((not-installed (cl-loop for x in installing-package-list
                       when (not (package-installed-p x))
                         collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; use-package: .init.el を簡素化するためのマクロ
;;; http://rubikitch.com/2014/09/09/use-package/
;;; https://github.com/jwiegley/use-package
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロード
(require 'use-package)

;;; 設定
;;;; *Message* バッファにログを残す
(setq use-package-verbose t)
(setq use-package-minimum-reported-time 0.001)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; ロードパス
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ~/.emacs.d/site-lisp 以下を load-path に追加
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; *** flozen ***
;; auto-install: パッケージ化されていない elisp をインストール
;;; *** flozen ***
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
;(use-package auto-install
;  :config
;  ;; インストールディレクトリを設定する
;  ;;; 初期値は ~/.emacs.d/auto-install/
;  (setq auto-install-directory "~/.emacs.d/site-lisp/auto-install.d/")
;  (auto-install-compatibility-setup))


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; init-loader: 設定ファイルの分割読み込み
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; ロードと設定
(use-package init-loader
  :config
  ;; エラー時のみメッセージ表示
  (setq init-loader-show-log-after-init 'error-only)
  (init-loader-load "~/.emacs.d/inits"))
