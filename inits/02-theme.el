;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; color-theme-solarized: Solarized テーマ
;;; https://github.com/sellout/emacs-color-theme-solarized
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; カラーテーマライブラリのロード
(use-package color-theme)

;;; ロードと設定
(use-package color-theme-solarized
  :config
  ;; Solarized テーマをロード
  (load-theme 'solarized t)
  ;; Dark スキーマを使用
  (set-frame-parameter nil 'background-mode 'dark)
  (enable-theme 'solarized)
)
