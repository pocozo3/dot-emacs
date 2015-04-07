;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; Direx: Yet another dired ディレクトリ・エクスプローラ
;;; http://rubikitch.com/2014/10/18/direx/
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロード
(use-package direx
  :init
  ;; GIT プロジェクトが見つかったら direx-project を
  ;;; 見つからなければ direx を表示する関数
  ;;; http://d.hatena.ne.jp/syohex/20130202/1359814263
  (defun my/direx-jump ()
    (interactive)
    (cond (current-prefix-arg
           (dired-jump))
          ((not (one-window-p))
           (or (ignore-errors
                 (direx-project:jump-to-project-root) t)
               (direx:jump-to-directory)))
          (t
           (or (ignore-errors
                 (direx-project:jump-to-project-root-other-window) t)
               (direx:jump-to-directory-other-window)))))
  :bind (("C-x C-j" . my/direx-jump)))
