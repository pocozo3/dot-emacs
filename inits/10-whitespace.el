;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; whitespace-mode: 全角スペース・改行・タブを可視化する
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package whitespace
  :config
  ;; 可視化する項目
  (setq whitespace-style '(face           ; faceで可視化
                           trailing       ; 行末
                           tabs           ; タブ
                           newline        ; 改行
                           spaces         ; スペース
                           empty          ; 先頭/末尾の空行
                           space-mark     ; マッピングした記号
                           tab-mark
                           newline-mark
                           ))
  ;; 表示のマッピング
  (setq whitespace-display-mappings
        '((space-mark ?\x3000 [?\□]) ; 全角　スペース
          (newline-mark 10 [8629 10]) ; 改行
          (tab-mark 9 [187 9] [92 9]) ; タブ
          ))
  ;; スペースは全角のみを可視化
  (setq whitespace-space-regexp "\\(\x3000+\\)")
  ;; whitespace-mode をオン
  (global-whitespace-mode t))
