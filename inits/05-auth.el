;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; auth: 認証情報の暗号化とサポート関数
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package auth-source
  :config
  ;; auth-sourcesにパスワードリストファイルを追加
  (add-to-list 'auth-sources (concat user-emacs-directory ".authinfo.plist"))
  ;; 情報取得用関数定義
  (defun* my/auth-source-get-property (prop-name &rest spec &allow-other-keys)
    (let* ((founds (apply 'auth-source-search spec))
           (pkey (intern (concat ":" (format "%s" prop-name))))
           (ret (when founds (plist-get (nth 0 founds) pkey))))
      (if (functionp ret)
          (funcall ret)
        ret))))
