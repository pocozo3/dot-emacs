;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; pkgbuild-mode: ArchLinuxパッケージマネージャへのインタフェース
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package pkgbuild-mode
  :init
  ;; モードの登録
  (setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode))
                                auto-mode-alist)))
