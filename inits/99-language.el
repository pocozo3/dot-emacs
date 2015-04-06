;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; 文字コード指定
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; 言語環境設定
(set-language-environment "Japanese")

;;; デフォルトの文字コード
(set-default-coding-systems 'utf-8-unix)

;;; テキストファイル／新規バッファの文字コード
(prefer-coding-system 'utf-8-unix)

;;; ファイル名の文字コード
(set-file-name-coding-system 'utf-8-unix)

;;; キーボード入力の文字コード
(set-keyboard-coding-system 'utf-8-unix)

;;; サブプロセスのデフォルト文字コード
(setq default-process-coding-system 'utf-8-unix)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; フォント指定
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; デフォルト フォント
(set-face-attribute 'default nil
                    :family "Ricty"
                    :height 120)

;;; プロポーショナル フォント
(set-face-attribute 'variable-pitch nil
                    :family "MeiryoKe_PGothic"
                    :height 110)

;;; 等幅フォント
(set-face-attribute 'fixed-pitch nil
                    :family "Ricty"
                    :height 120)

;;; ツールチップ表示フォント
(set-face-attribute 'tooltip nil
                    :family "MeiryoKe_UIGothic"
                    :height 90)
