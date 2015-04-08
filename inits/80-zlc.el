;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; zlc: ミニバッファの補完機能を zsh 風にする
;;; http://rubikitch.com/2014/10/25/zlc/
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package zlc
  :config
  ;; 有効化
  (zlc-mode t)
  ;; キーバインド
  (bind-keys :map minibuffer-local-map
    ;; zsh メニュー選択風キーバインド
    ("<down>" . zlc-select-next-vertical)
    ("<up>" . zlc-select-previous-vertical)
    ("<right>" . zlc-select-next)
    ("<left>" . zlc-select-previous)
    ("M-<tab>" . zlc-select-previous)
    ("M-TAB" . zlc-select-previous)
    ;; 選択中止
    ("C-c" . zlc-reset)))
