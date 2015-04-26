;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; org-gcal: Google Calendar と org-mode を連携させる
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package org-gcal
  :config
  ;; 設定
  (setq org-gcal-client-id (my/auth-source-get-property 'id :app "org-gcal"))
  (setq org-gcal-client-secret
        (my/auth-source-get-property 'secret :app "org-gcal" :id org-gcal-client-id))
  (setq org-gcal-file-alist '(("pocota.papa@gmail.com" . "~/Dropbox/Documents/Org/gcal.org")))
  ;; キーバインド
  ;;; 同期をとる
  (bind-key "g s" 'org-gcal-sync poco-key-map)
  ;;; フェッチ
  (bind-key "g f" 'org-gcal-fetch poco-key-map)
  ;;; org エレメントを Google Calendar に送る
  (bind-key "g p" 'org-gcal-post-at-point poco-key-map)
  ;;; Token をリフレッシュ
  (bind-key "g t" 'org-gcal-refresh-token poco-key-map))
