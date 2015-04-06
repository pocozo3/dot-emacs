;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; モードによらないキーバインド
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; シェルに合わせるため、"C-h" は全てのモードで後退に割り当てる
(bind-key* "C-h" 'backward-delete-char)

;;; ヘルプコマンド
(bind-key "C-x ?" 'help-command)
;;; 多機能ヘルプコマンド
(bind-key "M-?" 'help-for-help)

;;; 循環スペースの割り当て
;;;; http://rubikitch.com/2014/10/22/emacs244-edit-changes/
(bind-key "M-SPC" 'cycle-spacing)

;;; 別ウィンドウに切り替え
(bind-key "C-o" 'other-window)

;;; "C-q" オリジナルプレフィックス
;;;; 主に元の機能の復活やトグルコマンドなど
(bind-keys :map poco-key-map
  ;; 元の "C-q" の機能を復元 (特殊文字を入力)
  ("C-q" . quoted-insert)
  ;; Elscreen のプリフィックスに使用するため、
  ;;; 元の "C-t" の機能を復元 (transpose-chars)
  ("C-t" . transpose-chars)
  ;; Helm のプリフィックスに使用するため、
  ;;; 元の "C-z" の機能を復元 (Emacs の一時停止/最小化)
  ("C-z" . suspend-emacs)
  ;; 読み取り専用モードでファイルを開く
  ("C-r" . find-file-read-only)
  ;; 行番号表示トグルコマンド
  ("l" . linum-mode)
  ;; 折り返しトグルコマンド
  ("t" . toggle-truncate-lines))
