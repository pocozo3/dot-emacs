;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; Smart-Newline: コードを書くための改行の入力を
;;; エンターキー1つで快適に行うための拡張
;;; http://rubikitch.com/2014/12/31/smart-newline/
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package smart-newline
  :if (locate-library "smart-newline")
  :bind (("C-m" . smart-newline))
  :init
  ;; smart-newline マイナーモードをフックするモードを指定
  (add-hook 'emacs-lisp-mode-hook 'smart-newline-mode)
  (add-hook 'org-mode-hook 'smart-newline-mode)
  :config
  ;; 使い勝手を向上させる工夫
  (defadvice smart-newline (around C-u activate)
    "C-uを押したら元のC-mの挙動をするようにした。
  org-modeなどで活用。"
    (if (not current-prefix-arg)
        ad-do-it
      (let (current-prefix-arg)
        (let (smart-newline-mode)
          (call-interactively (key-binding (kbd "C-m"))))))))
