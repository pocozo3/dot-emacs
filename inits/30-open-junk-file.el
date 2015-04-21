;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; open-junk-file: 使い捨て用ファイルを作成する
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package open-junk-file
  :init
  ;; Junk ファイルを作成する
  (bind-key "j" 'open-junk-file poco-key-map)
  :config
  ;; 開くファイルの名称
  (setq open-junk-file-format
        "~/Dropbox/Documents/Junk/%Y-%m-%d-%H%M%S."))
