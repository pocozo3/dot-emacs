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
  ;; キーバインド
  (bind-key "C-\\" 'skk-mode)
  :config
  ;; migemo を使うので skk-isearch は使わない
  (setq skk-isearch-mode-enable nil)
  (setq skk-isearch-start-mode 'latin)
  ;; Sticky キー
  (setq skk-sticky-key "'")
  ;; 各種メッセージを日本語で通知する
  (setq skk-japanese-message-and-error t)
  ;; メニューを日本語にしない
  (setq skk-show-japanese-menu nil)
  ;; インジケータに色を付けない
  (setq skk-indicator-use-cursor-color nil)
  ;; 各インジケータのカスタマイズ
  (setq skk-hiragana-mode-string "[あ]")
  (setq skk-katakana-mode-string "[ア]")
  (setq skk-jisx0208-latin-mode-string "[Ａ]")
  (setq skk-jisx0201-mode-string "[_ｱ]")
  ;; mode-line が動くのが許せないので，ちょっと修正
  ;;; https://github.com/uwabami/emacs
  (defadvice skk-make-indicator-alist
    (after my/set-skk-default-indicator activate)
  (dolist (elem
            '((abbrev " [aA]" . "--[aA]:")
               (latin " [_A]" . "--[_A]:")
             (default " [--]" . "--[--]:")))
    (setq ad-return-value
          (append (cons elem nil)
                  (delq (assoc (car elem) ad-return-value)
                                          ad-return-value)))))
  ;; 起動時からモードライン上にインジケータを表示する
  (skk-update-modeline)
  ;; *** flozen ****
  ;; 起動時からモードライン上にインジケータを表示するための工夫
  ;;; https://github.com/uwabami/emacs
  ;(defun my/update-modeline-for-ddskk ()
  ;  "To switch to SKK mode once when switching to major mode."
  ;  (progn
  ;    (skk-mode) (skk-mode)))
  ;(add-hook 'after-change-major-mode-hook 'my/update-modeline-for-ddskk)
  ;; *** flozen ****
  ;; 変換の学習
  (use-package skk-study)
  ;; 半角カナを入力
  (setq skk-use-jisx0201-input-method t)
  ;; Enter で改行しない
  (setq skk-egg-like-newline t)
  ;;"「"を入力したら"」"も自動で挿入
  (setq skk-auto-insert-paren t)
  ;; 句読点変換ルール
  (setq skk-kuten-touten-alist
    '(
      (jp . ("．" . "，" ))
      (en . ("." . ","))))
  ;; @で挿入する日付表示を西暦&半角に
  (setq skk-date-ad t)
  (setq skk-number-style nil)
  ;; 送り仮名が厳密に正しい候補を優先して表示する
  (setq skk-henkan-strict-okuri-precedence t)
  ;; 辞書登録のとき、余計な送り仮名を送らないようにする
  (setq skk-check-okurigana-on-touroku 'auto)
  ;; 複数の Emacsen を起動して個人辞書を共有する
  (setq skk-share-private-jisyo t)
  ;; Server 補完
  (add-to-list 'skk-search-prog-list
    '(skk-server-completion-search) t)
  (add-to-list 'skk-completion-prog-list
    '(skk-comp-by-server-completion) t)
  ;; AZIK 入力モード
  (setq skk-use-azik t)
  (setq skk-azik-keyboard-type 'us101)
  ;; 起動時からモードライン上にインジケータを表示するための工夫
  ;;; https://github.com/uwabami/emacs
  (defun my:update-modeline-for-ddskk ()
    ""
    (progn
      (skk-mode) (skk-mode)))
  (add-hook 'after-change-major-mode-hook 'my:update-modeline-for-ddskk)
)
