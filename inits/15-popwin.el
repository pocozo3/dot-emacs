;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; Popwin: 指定したバッファをポップアップウィンドウで表示
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package popwin
  :config
  ;; auto-async-byte-compile 登録
  (push '(" *auto-async-byte-compile*":position bottom :width 0.25)
        popwin:special-display-config)
  ;; direx 登録
  (push '(direx:direx-mode :position left :width 0.3 :dedicated t)
        popwin:special-display-config)
  ;; undo-tree 登録
  (push '(" *undo-tree*":position right :width 0.3)
        popwin:special-display-config)
  ;; Help 登録
  (push '(" *Help*":position right :width 0.3)
        popwin:special-display-config)
  ;; 有効化
  (popwin-mode t))
