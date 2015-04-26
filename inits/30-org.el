;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; org-mode: Org ファイル編集 強力なアウトラインプロセッサ
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package org
  :init
  ;; org-mode で起動するファイルの種類を登録
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  ;; org ファイルのデフォルトの保存場所
  (setq org-directory "~/Dropbox/Documents/Org/")
  :config
  ;; リンクを RET で追う
  (setq org-return-follows-link t)
  ;; 時刻の形式
  (setq org-display-custom-times "<%Y-%m-%d %H:%M:%S>")
  (setq org-time-stamp-custom-formats "<%Y-%m-%d %H:%M:%S>")
  ;; GTD: グローバルなタグの追加
  (setq org-tag-alist
        '(("Doing" . ?d)
          ("@HOME" . ?h)
          ("@OFFICE" . ?o)
          ("TWITTER" . ?t)
          ("MAIL" . ?m)
          ("PC" . ?w)
          ("GAME" . ?g)
          ("GOLF" . ?l)))
  ;; キーバインド
  (bind-key "C-c l" 'org-store-link))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; org-bable: 文芸的プログラミング環境
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package ob
  :config
  ;; org-babel のソースブロックにシンタックスカラーを付ける
  (setq org-src-fontify-natively t)
  ;; org-babel の評価時に質問を省略
  (setq org-confirm-babel-evaluate nil))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; org-capture: メモ記録
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package org-capture
  :bind
  ;; キーバインド
  ("C-c c" . org-capture)
  :init
  ;; メモを取るファイルのデフォルト
  (setq org-default-notes-file (concat org-directory "notes.org"))
  ;; GTD: TODO の状態を追加
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
  :config
  ;; 見出しの余分な * を消す
  (setq org-hide-leading-stars t)
  ;; GTD: DONE の時刻を記録
  (setq org-log-done 'time)
  ;; テンプレート
  (setq org-capture-templates
        `(
          ("t" "Todo" entry
           (file (concat org-directory "gtd.org"))
           "* TODO %?\n    TIME: %T\n    CAPTURED_AT: %a\n    %i")
          ("m" "Memo" entry
           (file+headline nil "Memos")
           "** %?\n    TIME: %T\n    CAPTURED_AT: %a\n    %i")
        ))
)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; org-agenda: 議事一覧
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package  org-agenda
  :bind
  ("C-c a" . org-agenda)
  :init
  ;; Agenda で表示するファイル登録
  (setq org-agenda-files nil)
  (dolist (file
           '("gtd.org"
             "gcal.org"
             ))
    (add-to-list 'org-agenda-files (concat org-directory file)))
  :config
  ;;時刻表示が一桁の時に 0 を付加
  (setq org-agenda-time-leading-zero t)
)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; ox-gfm: GFM 形式でエクスポートする
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package ox-gfm)
