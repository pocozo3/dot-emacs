;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; Elscreen: GNU screen のようなウィンドウ管理ユーティリティ
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package elscreen
  :init
  ;; 起動
  (elscreen-start)
  :bind (
    ;; Create (バッファ構成を初期化)
    ("<f5>" . elscreen-create)
    ;; Clone (バッファ構成をコピー)
    ("C-<f5>" . elscreen-clone)
    ;; Previous
    ("<f6>" . elscreen-previous)
    ;; Next
    ("<f7>" . elscreen-next)
    ;; Kill
    ("<f8>" . elscreen-kill))
  :config
  ;; "C-t" を Elscreen のプレフィックスキーにする
  (setq elscreen-prefix-key (kbd "C-t"))
  ;; タブの先頭に[X]を表示しない
  (setq elscreen-tab-display-kill-screen nil)
  ;; header-lineの先頭に[<->]を表示しない
  (setq elscreen-tab-display-control nil)
  ;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
  (setq elscreen-buffer-to-nickname-alist
        '(("^dired-mode$" .
           (lambda ()
             (format "Dired(%s)" dired-directory)))
          ("^Info-mode$" .
           (lambda ()
             (format "Info(%s)" (file-name-nondirectory Info-current-file))))
          ("^mew-draft-mode$" .
           (lambda ()
             (format "Mew(%s)" (buffer-name (current-buffer)))))
          ("^mew-" . "Mew")
          ("^irchat-" . "IRChat")
          ("^liece-" . "Liece")
          ("^lookup-" . "Lookup")))
  (setq elscreen-mode-to-nickname-alist
        '(("[Ss]hell" . "shell")
          ("compilation" . "compile")
          ("-telnet" . "telnet")
          ("dict" . "OnlineDict")
          ("*WL:Message*" . "Wanderlust")))
  ;; emacsclient から呼びだされた場合、新しいタブを開く
  (use-package elscreen-server))


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; elscreen-persist: elscreen の構成を永続保持
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; ロードと設定
(use-package elscreen-persist
  :bind (
    ;; スクリーン構成を記録／リストア
    ("C-<f6>" . elscreen-persist-restore)
    ("C-<f7>" . elscreen-persist-store))
)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; elscreen-separate-buffer-list: screen ごとに個別のバッファリストを保持
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; ロードと設定
(use-package elscreen-separate-buffer-list
  :config
  ;; 初期化
  (elscreen-separate-buffer-list-mode t))
