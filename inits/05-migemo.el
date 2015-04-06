;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; migemo: ローマ字インクリメンタルサーチエンジン
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package migemo
  :config
  ;; コマンド
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  ;; 辞書ファイルの場所を指定
  (setq migemo-dictionary "/usr/share/migemo/utf-8/migemo-dict")
  ;; 設定
  (defvar migemo-user-dictionary nil)
  (defvar migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  ;; 有効化
  (load-library "migemo")
  (migemo-init))
