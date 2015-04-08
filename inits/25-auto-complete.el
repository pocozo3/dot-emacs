;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; auto-complete: 自動補完機能
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package auto-complete-config
  :init
  (use-package fuzzy)
  ;; 追加メジャーモード
  (add-to-list 'ac-modes 'org-mode)
  (add-to-list 'ac-modes 'text-mode)
  :config
  ;; 初期化
  (ac-config-default)
  ;; ユーザー定義辞書の登録
  (add-to-list 'ac-user-dictionary-files "~/.emacs.d/ac-user-dict")
  ;; 補完推測データを保存するファイル
  (setq ac-comphist-file "~/.emacs.d/ac-comphist.dat")
  ;; グローバルで自動補完を有効にする
  (global-auto-complete-mode t)
  ;; 自動補完を 4 文字以上の単語で開始する
  (setq ac-auto-start 4)
  ;; 自動補完を 0.05 秒後に開始
  (setq ac-delay 0.05)
  ;; 曖昧マッチ補完を有効にする
  (setq ac-use-fuzzy t)
  ;; 補完推測機能を有効にする
  (setq ac-use-comphist t)
  ;; 補完メニューを 0.8 秒後に自動で表示
  (setq ac-auto-show-menu 0.8)
  ;; クイック(ツールチップ)ヘルプを非表示にする
  (setq ac-use-quick-help nil)
  ;; 補完メニュー表示時のみのキーマップを有効にする
  (setq ac-use-menu-map t)
  ;; 曖昧マッチ補完時のカーソル色 (GUI のみ有効)
  (setq ac-fuzzy-cursor-color my/sct-violet)
  ;; キーバインド
  ;;; M-/ を標準の補完機能から auto-complete に変更
  (bind-key "M-/" 'auto-complete)
  ;;; 最後に補完したヘルプを表示
  (bind-key "C-c h" 'ac-last-help ac-mode-map)
  ;;; AC メニュー上を C-p/C-n で上下移動できるように
  (bind-keys :map ac-menu-map
    ("C-n" . ac-next)
    ("C-p" . ac-previous))
  ;; 機能強化
  ;;; 候補に日本語を含む単語が含まれないようにする
  ;;; http://d.hatena.ne.jp/IMAKADO/20090813/1250130343
  (defadvice ac-word-candidates (after remove-word-contain-japanese activate)
    (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
      (setq ad-return-value
            (remove-if contain-japanese ad-return-value)))))
