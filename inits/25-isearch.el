;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; ace-isearch: isearch と ace-jump-mode 間のシームレスな橋渡し
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package ace-isearch
  :config
  ;; 有効化
  (global-ace-isearch-mode t))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; isearch-dabbrev: isearch 中に動的略語展開 (dabbrev)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package isearch-dabbrev
  :init
  ;; キーバインド
  (bind-key "<tab>" 'isearch-dabbrev-expand isearch-mode-map))
