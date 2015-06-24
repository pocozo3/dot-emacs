;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; Helm: インクリメンタル補完と選択絞り込みフレームワーク
;;; ここでは、その派生 elisp の設定も含む
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package helm-config
  :init
  ;; キーバインド
  ;;; "C-h" のキーバインドを解除
  (bind-key "C-h" nil helm-map)
  ;;; "C-z" のキーバインドを解除
  (bind-key "C-z" nil)
  ;;; "C-z" をプレフィックスキーにする
  (custom-set-variables
   '(helm-command-prefix-key "C-z"))
  :config
  ;; 長い行を切り詰める
  (setq helm-truncate-lines t)
  ;; バッファ名の領域サイズを 50 に変更
  (setq helm-buffer-max-length 50)
  (setq helm-delete-minibuffer-contents-from-point t)
  ;; helm-file の読み込み
  (use-package helm-files
    :config
    ;; ファイル選択時の自動補完を無効
    (setq helm-ff-auto-update-initial-value nil)
    (setq helm-ff-skip-boring-files t)
    (add-to-list 'helm-boring-file-regexp-list "~$")
    (add-to-list 'helm-boring-file-regexp-list "\\.elc$")
    ;; TAB で任意補完。
    ;;; 選択肢が出てきたら C-n や C-p で上下移動してから決定することも可能
    (bind-key "C-i" 'helm-execute-persistent-action helm-find-files-map)
    (bind-key "C-i" 'helm-execute-persistent-action helm-read-file-map))
  ;; 検索結果によってリサイズ
  (setq helm-autoresize-mode t)
  ;; 高さは最大で50% (デフォルトは 40%)
  (setq helm-autoresize-max-height 50)
  ;; キーバインド
  (bind-key "M-x" 'helm-M-x)
  (bind-key "C-x C-c" 'helm-mini)
  (bind-key "M-y" 'helm-show-kill-ring)
  (bind-key "C-x C-b" 'helm-buffers-list)
  (bind-key "C-x C-r" 'helm-recentf)
  (bind-keys :map helm-command-map
    ("d" . helm-descbinds)
    ("m" . helm-mini)
    ("C-s" . helm-ag)
    ("C-k" . backward-kill-sexp)
    ("C-M-s" . helm-ag-this-file)
    ("C-:" . helm-swoop-nomigemo)
    ("C-j" . helm-open-junk-files)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; helm-migemo: helm 絞り込みの migemo 化
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package helm-migemo
  :config
  ;; migemo を使用できるようにするためのパッチ
  (defun helm-compile-source--candidates-in-buffer (source)
    (helm-aif (assoc 'candidates-in-buffer source)
      (append source
              `((candidates
                . ,(or (cdr it)
                       (lambda ()
                         ;; Do not use `source' because other plugins
                         ;; (such as helm-migemo) may change it
                         (helm-candidates-in-buffer (helm-get-current-source)))))
                (volatile) (match identity)))
       source))
  (setq helm-idle-delay 0.1)
  ;;;; migemo を有効にするコマンド指定
  ;(helm-migemize-command helm-recentf)
  ;;;; migemo を情報源に登録
  ;(push '(migemo) helm-source-recentf)
  )


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; helm-descbinds: キーバインド一覧の helm インターフェイス
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package helm-descbinds
  :config
  ;; 有効化
  (helm-descbinds-mode t)
  )


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; helm-swoop: バッファ内検索 & ジャンプ
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package helm-swoop
  :defer t
  :init
  ;; シンボル検索用 Migemo 無効版 helm-swoop
  (cl-defun helm-swoop-nomigemo (&key $query ($multiline current-prefix-arg))
    "シンボル検索用 Migemo 無効版 helm-swoop"
    (interactive)
    (let ((helm-swoop-pre-input-function
           (lambda () (format "\\_<%s\\_> " (thing-at-point 'symbol)))))
      (helm-swoop :$source (delete '(migemo) (copy-sequence (helm-c-source-swoop)))
                  :$query $query :$multiline $multiline)))
  :config
  ;; t なら helm-multi-swoop-edit の補完時にバッファを保存
  (setq helm-multi-swoop-edit-save t)
  ;; 値が t の場合はウィンドウ内に分割、nil なら別のウィンドウを使用
  (setq helm-swoop-split-with-multiple-windows nil)
  ;; ウィンドウ分割方向
  ;;; 'split-window-vertically(垂直) or 'split-window-horizontally(水平)
  (setq helm-swoop-split-direction 'split-window-horizontally)
  ;; nil なら一覧のテキストカラーを失う代わりに、起動スピードをほんの少し上げる
  (setq helm-swoop-speed-or-color nil)
  ;; 端を折り返しにするか
  (setq helm-swoop-move-to-line-cycle t)
  ;; 行番号用のオプションフェイス
  ;;; フェイス名 `helm-swoop-line-number-face`
  (setq helm-swoop-use-line-number-face t)
  ;; "C-u C-s" か "C-u C-u C-s" で helm-swoop を直接起動する
  (defun isearch-forward-or-helm-swoop (use-helm-swoop)
    (interactive "p")
    (let (current-prefix-arg
          (helm-swoop-pre-input-function 'ignore))
      (call-interactively
       (case use-helm-swoop
         (1 'isearch-forward)
         (4 'helm-swoop)
         (16 'helm-swoop-nomigemo)))))
  ;; キーバインド
  (bind-key "C-s" 'isearch-forward-or-helm-swoop)
  ;;; isearch 実行中に helm-swoop に移行
  (bind-key "M-i" 'helm-swoop-from-isearch isearch-mode-map)
  ;;; helm-swoop 実行中に helm-multi-swoop-all に移行
  (bind-key "M-i" 'helm-multi-swoop-all-from-helm-swoop helm-swoop-map)
  ;;; isearch と helm-swoop の連携を考え C-r/C-s に移動を割り当て
  (bind-keys :map helm-swoop-map
    ("C-r" . helm-previous-line)
    ("C-s" . helm-next-line)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; helm-ag: 高速検索ツール ag (the silver searcher) の helm インターフェイス
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package helm-ag
  :defer t
  :config
  ;; helm-ag のコマンドオプション
  (setq helm-ag-base-command "ag --nocolor --nogroup -S")
  (setq helm-ag-command-option "--hidden")
  ;; helm-ag でカーソル以下のオブジェクトを検索パターンを symbol に指定
  (setq helm-ag-insert-at-point 'symbol))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; helm-package: パッケージ一覧の helm インターフェース
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package helm-package
  :defer t)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; helm-open-junk-file: Junk ファイルの一覧表示
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; Junk ファイルの一覧作成
(use-package helm-open-junk-files
  :config
  (setq helm-open-junk-files-dir "~/dropbox/Documents/junk/"))
