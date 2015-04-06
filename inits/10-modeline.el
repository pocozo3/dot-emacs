;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; モードライン表示項目の設定
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; モードラインフォーマットを変更
(setq-default mode-line-position
  '(
    " "
    ;; ポジション, 80桁で警告色に変更
    (:propertize "%4l" face mode-line-position-face)
    (:propertize "/" face mode-line-delim-face-1)
    (:eval
      (number-to-string (count-lines (point-min) (point-max))))
    " "
    (:eval (propertize "%3c" 'face
                       (if (>= (current-column) 80)
                         'mode-line-80col-face
                         'mode-line-position-face)))
    " "))

;;; カーソルの位置が何行目かを表示する
(line-number-mode t)

;;; カーソルの位置が何文字目かを表示する
(column-number-mode t)

;;; cp932 エンコードの表記変更
(coding-system-put 'cp932 :mnemonic ?P)
(coding-system-put 'cp932-dos :mnemonic ?P)
(coding-system-put 'cp932-unix :mnemonic ?P)
(coding-system-put 'cp932-mac :mnemonic ?P)

;;; UTF-8 エンコードの表記変更
(coding-system-put 'utf-8 :mnemonic ?U)
(coding-system-put 'utf-8-with-signature :mnemonic ?u)

;;; 改行コードの表記追加
(setq eol-mnemonic-dos       ":CRLF ")
(setq eol-mnemonic-mac       ":CR   ")
(setq eol-mnemonic-unix      ":LF   ")
(setq eol-mnemonic-undecided ":---- ") 

;;; 時計のフォーマットを変更
(setq display-time-string-forms
  '((format "%s/%s(%s) %s:%s"
            month day dayname 24-hours minutes)))
;;; 時計を表示
(display-time-mode t)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; モードラインフォーマット
;;; http://kotatu.org/blog/2012/04/27/neat-emacs-modeline/
;;; https://github.com/yukihr/dotfiles/blob/master/.emacs.d/inits/init-modeline.el
;;; http://amitp.blogspot.jp/2011/08/emacs-custom-mode-line.html
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; モードライン用各種フェイス
(make-face 'mode-line-base-face)
(make-face 'mode-line-base-mono-face)
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-filesize-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)
(make-face 'mode-line-delim-face-1)
(make-face 'mode-line-global-face)
(custom-set-faces
  `(mode-line-base-face ((t (:foreground ,my/sct-base1 :inverse-video nil
                             :weight normal :height 110 :family "MeiryoKe_UIGothic"))))
  `(mode-line-base-mono-face ((t (:inherit mode-line-base-face :family "MeiryoKe_Gothic"))))
  `(mode-line-read-only-face ((t (:inherit mode-line-base-mono-face :foreground ,my/sct-blue
                                  :box (:line-width 2 :color ,my/sct-blue)))) t)
  `(mode-line-modified-face ((t (:inherit mode-line-base-mono-face :foreground ,my/sct-red
                                 :box (:line-width 2 :color ,my/sct-red)))) t)
  `(mode-line-folder-face ((t (:inherit mode-line-base-face :foreground ,my/sct-base2
                               :weight extra-light :height 100))) t)
  `(mode-line-filename-face ((t (:inherit mode-line-base-face :foreground ,my/sct-orange
                                 :weight bold))) t)
  `(mode-line-filesize-face ((t (:inherit mode-line-base-face :foreground ,my/sct-base00
                                 :height 90 :family "Arial"))) t)
  `(mode-line-position-face ((t (:inherit mode-line-base-face
                                 :height 100 :family "Arial"))) t)
  `(mode-line-mode-face ((t (:inherit mode-line-base-face
                             :foreground ,my/sct-base3 ))) t)
  `(mode-line-minor-mode-face ((t (:inherit mode-line-mode-face
                                   :foreground ,my/sct-base00 :height 80))) t)
  `(mode-line-process-face ((t (:inherit mode-line-base-face
                                :foreground ,my/sct-yellow))) t)
  `(mode-line-80col-face ((t (:inherit mode-line-position-face :background ,my/sct-orange
                              :foreground ,my/sct-base2))) t)
  `(mode-line-delim-face-1 ((t (:inherit mode-line-base-face
                                :foreground ,my/sct-base1))) t)
  `(mode-line-global-face ((t (:inherit mode-line-base-face :height 100))) t)
)

;;; フォーマットカスタマイズ
(setq-default mode-line-format
  '(
    "%e"
    (:propertize mode-line-mule-info
                 face mode-line-base-mono-face)
    ;; emacsclient [default -- keep?]
    mode-line-client
    mode-line-remote
    ;; evil-mode-line-tag
    mode-line-position
    ;; 読み込み専用 (RO) または変更 (**)
    (:eval
      (cond (buffer-read-only
             (propertize " RO " 'face 'mode-line-read-only-face))
            ((buffer-modified-p)
             (propertize " ** " 'face 'mode-line-modified-face))
            (t "  ")))
    " "
    ;; ディレクトリまたはバッファ/ファイル名
    (:propertize (:eval (shorten-directory default-directory 30))
                 face mode-line-folder-face)
    (:propertize "%b" face mode-line-filename-face)
    " "
    ;; ファイルサイズ
    (:propertize "(%I)" face mode-line-filesize-face)
    ;; narrow [default -- keep?]
    " %n"
    ;; モードインジケータ:
    ;;; バージョン管理, 再帰編集, メジャーモード, マイナーモード, プロセス, グローバル
    (:propertize (vc-mode vc-mode)
                 face mode-line-base-face)
    "  %["
    (:propertize mode-name
                 face mode-line-mode-face)
    "%]"
    (:eval (propertize (format-mode-line minor-mode-alist)
                       'face 'mode-line-minor-mode-face))
    "  "
    (:propertize mode-line-process
                 face mode-line-process-face)
    "  "
    (:propertize (global-mode-string global-mode-string)
                 face mode-line-global-face)
    ))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; ヘルパー関数
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ディレクトリ名 [dir] のうち、[max-length] 文字目まで表示する
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
       (output ""))
  (when (and path (equal "" (car path)))
        (setq path (cdr path)))
  (while (and path (< (length output) (- max-length 4)))
         (setq output (concat (car path) "/" output))
         (setq path (cdr path)))
  (when path
    (setq output (concat ".../" output)))
    output))
