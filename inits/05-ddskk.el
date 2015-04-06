;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; ddskk: 日本語入力システム
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package skk
  :init
  ;; SKK 辞書サーバを使う
  (setq skk-server-host "localhost")
  (setq skk-server-portnum 1178)
  (setq skk-server-report-response t)
  ;; デフォルト IM を SKK にする
  (setq default-input-method "japanese-skk")
  :bind (("C-\\" . skk-mode))
  :config
  ;; migemo を使うので skk-isearch は使わない
  (setq skk-isearch-mode-enable nil)
  ;; Sticky キー
  (setq skk-sticky-key "'")
)
