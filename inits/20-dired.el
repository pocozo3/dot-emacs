;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;; dired: ディレクトリ・エクスプローラ
;; dired-x: 拡張版ディレクトリ・エクスプローラ
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; ロードと設定
(use-package dired-x
  :init
  (add-hook 'dired-load-hook
            (lambda ()
                    (load "dired-x")))
  :config
  ;; ファイルコピーなどで async を使用する
  (use-package dired-aux
    :defer t
    :config
      (use-package dired-async))
  ;; ls のオプション
  (setq dired-listing-switches "-lah --group-directories-first")
  ;; ファイルを削除したらゴミ箱へ
  (setq delete-by-moving-to-trash t)
  ;; dired で再帰コピーを可能にする
  (setq dired-recursive-copies 'always)
  ;; dired を2つのウィンドウで開いている場合
  ;;; デフォルトの移動 or コピー先を、もう一方の dired にする
  (setq dired-dwim-target t)
  ;; dired バッファで C-s した時にファイル名だけにマッチするように
  (setq dired-isearch-filenames t)
  ;; 新規にバッファを作成しない
  (put 'dired-find-alternate-file 'disabled nil)
  ;; dired-mode のキーバインド
  (bind-keys :map dired-mode-map
    ;; ウィンドウを消去
    ("q" . dired-dwim-quit-window)
    ;; ファイル/ディレクトリを開く
    ("RET" . dired-dwim-find-alternate-file)
    ;; スペースでマーク／マーク解除する
    ("SPC" . my/dired-toggle-mark)
    ;; マークしたファイルを全て開く
    ("f" . my/dired-find-marked-files)
    ;; マークしたファイルを view-mode で全て開く
    ("v" . my/dired-view-marked-files)
    ;; マークしたファイルを view-mode で全て別ウィンドウで開く
    ("V" . my/dired-do-view-marked-files)
    ;; ディレクトリの移動キーを追加(wdired 中は無効)
    ("<left>" . dired-dwim-up-alternate-directory)
    ("<right>" . dired-find-alternate-file)
    ;; ソート順を順次切り替える
    ("s" . dired-various-sort-change-or-edit)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; wdired: ファイル名をインライン編集する
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package dired-x
  :defer t
  :config
  ;; キーバインド
  (bind-key "r" 'wdired-change-to-wdired-mode dired-mode-map))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; dired の sort を拡張する
;;;; "-S (サイズ) -X (拡張子) -t (時間) "" (アルファベット順)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
(defvar dired-various-sort-type
    '(("S" . "size")
      ("X" . "ext")
      ("t" . "date")
      (""  . "name")))

(defun dired-various-sort-change (sort-type-alist &optional prior-pair)
  (setq dired-actual-switches
    (car (split-string dired-actual-switches " ")))
  (when (eq major-mode 'dired-mode)
    (let* (case-fold-search
           get-next
           (options
            (mapconcat 'car sort-type-alist ""))
           (opt-desc-pair
            (or prior-pair
                (catch 'found
                  (dolist (pair sort-type-alist)
                    (when get-next
                      (throw 'found pair))
                    (setq get-next
                      (string-match (car pair) dired-actual-switches)))
                  (car sort-type-alist)))))
      (setq dired-actual-switches
            (concat "-l" (dired-replace-in-string (concat "[l" options "-]")
                                                  ""
                                                  dired-actual-switches)
                    (car opt-desc-pair)))
      (setq dired-actual-switches
        (concat dired-actual-switches " --group-directories-first"))
      (setq mode-name
            (concat "Dired by " (cdr opt-desc-pair)))
      (force-mode-line-update)
      (revert-buffer))))

(defun dired-various-sort-change-or-edit (&optional arg)
  "Toggle sorting by various type, and refresh the Dired buffer.
With a prefix argument, edit the current listing switches instead."
  (interactive "P")
  (when dired-sort-inhibit
    (error "Cannot sort this dired buffer"))
  (if arg
      (dired-sort-other
       (read-string "ls switches (must contain -l): " dired-actual-switches))
    (dired-various-sort-change dired-various-sort-type)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; バッファ/ウィンドウ制御付き関数
;;; https://github.com/akisute3/dotfiles/blob/master/.emacs.d/inits/30_dired-0.el
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
(defun dired-dwim-find-alternate-file ()
  "画面分割に適した `dired-find-alternate-file'．
通常はファイルなら別バッファで、ディレクトリなら同じバッファで開くが、画面分割
されていて、他方のウィンドウに同じバッファが表示されていれば `dired-find-file'．"
  (interactive)
  (cond
    ;; 同じバッファが他のウィンドウにある場合
    ((delq (selected-window) (get-buffer-window-list))
      (dired-find-file))
    ;; 同じバッファが他のウィンドウにない場合
    (t
      (my/dired-open-in-accordance-with-situation))))

(defun dired-up-alternate-directory ()
  "バッファを増やさず上のディレクトリに移動．"
  (interactive)
  (let* ((dir (dired-current-directory))
         (up (file-name-directory (directory-file-name dir))))
    (or (dired-goto-file (directory-file-name dir))
        ;; Only try dired-goto-subdir if buffer has more than one dir.
        (and (cdr dired-subdir-alist)
             (dired-goto-subdir up))
        (progn
          (find-alternate-file up)
          (dired-goto-file dir)))))

(defun dired-dwim-up-alternate-directory ()
  "画面分割に適した `dired-up-alternate-directory'．"
  (interactive)
  (cond
    ;; 同じバッファが他のウィンドウにある場合
    ((delq (selected-window) (get-buffer-window-list))
      (dired-up-directory))
    ;; 同じバッファが他のウィンドウにない場合
    (t
      (dired-up-alternate-directory))))

(defun dired-dwim-quit-window ()
  "画面分割に適した `quit-window'．"
  (interactive)
  (quit-window (not (delq (selected-window) (get-buffer-window-list)))))

(defadvice dired-copy-filename-as-kill (before four-prefix activate)
  "C-u w でフルパス killing"
  (interactive "P")
  (when (eq 4 (prefix-numeric-value (ad-get-arg 0)))
    (ad-set-arg 0 0)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; ヘルパー関数
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ファイルなら別バッファで、ディレクトリなら同じバッファで開く
;;;; http://nishikawasasaki.hatenablog.com/entry/20120222/1329932699
(defun my/dired-open-in-accordance-with-situation ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (file-directory-p file)
        (dired-find-alternate-file)
      (dired-find-file))))

;;; 単体ファイルをマーク/マーク解除する
(defun my/dired-toggle-mark (arg)
  "Toggle the current (or next ARG) files."
  ;; S.Namba Sat Aug 10 12:20:36 1996
  (interactive "P")
  (let ((dired-marker-char
         (if (save-excursion (beginning-of-line)
                             (looking-at " "))
             dired-marker-char ?\040)))
    (dired-mark arg)
    (dired-previous-line 1)))

;;; マークをつけたファイルを開く
;;;; http://piro.hatenablog.com/entry/20101216/1292506110
(defun my/dired-find-marked-files (&optional arg)
  "Open each of the marked files, or the file under the point,
or when prefix arg, the next N files "
  (interactive "P")
  (let* ((fn-list (dired-get-marked-files nil arg)))
        (mapc 'find-file fn-list)))

;;; マークをつけたファイルを view-mode で開く
;;;; http://piro.hatenablog.com/entry/20101216/1292506110
(defun my/dired-view-marked-files (&optional arg)
  "Open each of the marked files, or the file under the point,
or when prefix arg, the next N files "
  (interactive "P")
    (let* ((fn-list (dired-get-marked-files nil arg)))
          (mapc 'view-file fn-list)))

;;; マークをつけたファイルごとに別ウィンドウで view-mode で開く
(defun my/dired-do-view-marked-files (&optional noselect)
  "Open each of the marked files, or the file under the point,
or when prefix arg, the next N files"
  (interactive "P")
  (my/dired-simultaneous-view-file (dired-get-marked-files) noselect))

(defun my/dired-simultaneous-view-file (file-list noselect)
  "`file-list' 内のすべてのファイルを参照し、それらを同時に表示する。
現在のウィンドウは、できるだけ均等に、`file-list' 内のすべてのファイルに分割される。
残りの行は一番下のウィンドウに移動します。表示することができるファイルの数は、
現在のウィンドウの高さ、および変数 `window-min-height' によって制限される。
`noselect' が non-nil の場合。ファイルが単に見つかっただけで、選択されていない。"
  (let (size)
    (if noselect
        (find-file-noselect (car file-list))
      (setq size (/ (window-height) (length file-list)))
      (or (<= window-min-height size)
          (error "Too many files to visit simultaneously. Try C-u prefix"))
      (view-file (car file-list)))
    (dolist (file (cdr file-list))
      (if noselect
          (find-file-noselect file)
          (select-window (split-window nil size))
      (view-file file)))))
