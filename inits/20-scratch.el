;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; scratch-pop: *scratch* バッファをポップアップ表示する
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package scratch-pop
  :defer t
  :init
  ;; キーバインド
  (bind-key "c" 'scratch-pop poco-key-map))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; *scratch* バッファ専用のマイナーモードを定義
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; *scratch* バッファを快適にするマイナーモード設定
(define-minor-mode scratch-ext-minor-mode
  "*scratch* バッファ専用のマイナーモード"
  nil ""
  '(("\C-c\C-xc" . scratch-pop-kill-ring-save-exit)
    ("\C-c\C-xe" . erase-buffer)))
(with-current-buffer (get-buffer-create "*scratch*")
  (erase-buffer)
  (ignore-errors
    (insert-file-contents
     auto-save-buffers-enhanced-file-related-with-scratch-buffer))
  (org-mode)
  (setq header-line-format "scratch!!")
  (scratch-ext-minor-mode t))

;;; *scratch* バッファの内容を kill-ring に入れてから閉じる
(defun scratch-pop-kill-ring-save-exit ()
  "*scratch* バッファの内容を kill-ring に入れてから閉じる"
  (interactive)
  (kill-new (buffer-string))
  (erase-buffer)
  (funcall (if (fboundp 'popwin:close-popup-window)
               'popwin:close-popup-window
             'quit-window)))
