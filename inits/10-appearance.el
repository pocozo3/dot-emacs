;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; フレーム描画
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; デフォルトの外観
(setq default-frame-alist
      (append '((width                . 95 ) ; フレーム幅
                (height               . 40 ) ; フレーム高
                (left                 . 25 ) ; 配置左位置
                (top                  . 25 ) ; 配置上位置
                (line-spacing         . 0  ) ; 文字間隔
                (left-fringe          . 10 ) ; 左フリンジ幅
                (right-fringe         . 11 ) ; 右フリンジ幅
                (menu-bar-lines       . 1  ) ; メニューバー
                (tool-bar-lines       . 1  ) ; ツールバー
                (vertical-scroll-bars . 1  ) ; スクロールバー
                (scroll-bar-width     . 17 ) ; スクロールバー幅
                (cursor-type          . box) ; カーソル種別
                (alpha                . (0.95 0.5)) ; 透明度
                ) default-frame-alist))
(setq initial-frame-alist default-frame-alist)

;;; スタートアップメッセージを非表示
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

;;; スタートアップ時のエコー領域メッセージの非表示
(setq inhibit-startup-echo-area-message t)

;;; *scratch* バッファの最初に書かれるメッセージを消す
(setq initial-scratch-message "")

;;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)

;;; フレーム タイトル
(setq frame-title-format
      '("emacs " emacs-version (buffer-file-name " - %f")))

;;; メニューとツールバーを隠す
;;;; 暫定マークモードをオン
(custom-set-variables
 '(menu-bar-mode nil)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))

;;; スクロールバーを隠す
(scroll-bar-mode -1)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; バッファ描画
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; 通常のウィンドウで行を折り返さない
(setq-default truncate-lines t)

;;; ウィンドウ縦分割時のバッファ画面外文字行を折り返さない
(setq-default truncate-partial-width-windows t)

;;; uniquify
;;;; ロードと設定
(use-package uniquify
  :config
  ;; 複数ディレクトリの同じファイル名オープン時のバッファ名を
  ;;; filename<dir> 形式のバッファ名にする
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*"))

;;; 現在行をハイライト表示
(global-hl-line-mode t)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; カーソル
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; デフォルトのカーソル色 -> 文字色
(set-cursor-color my/sct-base0)

;;; カーソルの点滅
(setq-default blink-cursor-mode t)

;;; 非アクティブウィンドウのカーソル表示オン
(setq-default cursor-in-non-selected-windows t)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; 括弧
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; 強調する待ち時間
(setq show-paren-delay 0)

;;; 強調のスタイル: expression は括弧内を常に強調表示
;;;                 mixed はウィンドウ内に収まらない時だけ括弧内を光らせる
(setq show-paren-style 'expression)

;;; 有効化
(show-paren-mode t)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; 行番号
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package linum
  :config
  ;; 行移動を契機に描画
  (defvar linum-line-number 0)
  (declare-function linum-update-current "linum" ())
  (defadvice linum-update-current
      (around linum-update-current-around activate compile)
    (unless (= linum-line-number (line-number-at-pos))
      (setq linum-line-number (line-number-at-pos))
      ad-do-it))
  ;; バッファ中の行番号表示の遅延設定による描画高速化
  (defvar linum-delay nil)
  (setq linum-delay t)
  (defadvice linum-schedule (around my-linum-schedule () activate)
    (run-with-idle-timer 0.2 nil #'linum-update-current))
  ;; 行番号のフォーマット
  (defvar linum-format nil)
  (setq linum-format "%5d")
  (set-face-attribute 'linum nil :height 0.75)
  ;; バッファ中の行番号表示
  (global-linum-mode t))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; スクロール
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; スクロール時のカーソル位置を維持
(setq scroll-preserve-screen-position t)

;;; スクロール開始の残り行数
(setq scroll-margin 0)

;;; スクロール時の行数
(setq scroll-conservatively 10000)

;;; スクロール時の行数（scroll-margin に影響せず）
(setq scroll-step 0)

;;; 画面スクロール時の重複表示する行数
(setq next-screen-context-lines 1)

;;; キー入力中の画面更新を抑止
(setq redisplay-dont-pause t)

;;; recenter-top-bottom のポジション
(setq recenter-positions '(top bottom))

;;; 横スクロール開始の残り列数
(setq hscroll-margin 1)

;;; 横スクロール時の列数
(setq hscroll-step 1)

;;; バッファの最後までスクロールダウン
(defadvice scroll-down (around scroll-down activate compile)
  (interactive)
  (let (
        (bgn-num (+ 1 (count-lines (point-min) (point))))
        )
    (if (< bgn-num (window-height))
        (goto-char (point-min))
      ad-do-it) ))

;;; バッファの先頭までスクロールアップ
(defadvice scroll-up (around scroll-up activate compile)
  (interactive)
  (let (
        (bgn-num (+ 1 (count-lines (point-min) (point))))
        (end-num nil)
        )
    (save-excursion
      (goto-char (point-max))
      (setq end-num (+ 1 (count-lines (point-min) (point))))
      )
    (if (< (- (- end-num bgn-num) (window-height)) 0)
        (goto-char (point-max))
      ad-do-it) ))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; generic-x: さまざまなファイルのメジャーモードでシンタックスカラーを付ける
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロード
(use-package generic-x
  :init
  ;; systemd の設定ファイルを conf-unix-mode に紐付けする
  (add-to-list 'auto-mode-alist '("\\.service\\'" . conf-unix-mode))
  (add-to-list 'auto-mode-alist '("\\.timer\\'" . conf-unix-mode))
  (add-to-list 'auto-mode-alist '("\\.target\\'" . conf-unix-mode))
  (add-to-list 'auto-mode-alist '("\\.mount\\'" . conf-unix-mode))
  (add-to-list 'auto-mode-alist '("\\.automount\\'" . conf-unix-mode))
  (add-to-list 'auto-mode-alist '("\\.slice\\'" . conf-unix-mode))
  (add-to-list 'auto-mode-alist '("\\.socket\\'" . conf-unix-mode))
  (add-to-list 'auto-mode-alist '("\\.path\\'" . conf-unix-mode)))
