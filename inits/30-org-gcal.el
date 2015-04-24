;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; org-gcal: Google Calendar と org-mode を連携させる
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package org-gcal
  :config
  (setq
   org-gcal-client-id "763450365609-r54h9lmjbauttcnuekiv3vfajkapc4ke.apps.googleusercontent.com"
   org-gcal-client-secret "BpZsjuAR1k7MbYZHL4usDZgF"
   org-gcal-file-alist '(("pocota.papa@gmail.com" .  "~/Dropbox/Documents/Org/gcal.org")))
  ;; キーバインド
  ;;; 同期をとる
  (bind-key "g s" 'org-gcal-sync poco-key-map)
  ;;; フェッチ
  (bind-key "g f" 'org-gcal-fetch poco-key-map)
  ;;; org エレメントを Google Calendar に送る
  (bind-key "g p" 'org-gcal-post-at-point poco-key-map)
  ;;; Token をリフレッシュ
  (bind-key "g t" 'org-gcal-refresh-token poco-key-map)
  )
