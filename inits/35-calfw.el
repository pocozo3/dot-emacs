;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; calfw: カレンダービュー
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; ロードと設定
(use-package calfw
  :init
  ;; org との連携
  (use-package calfw-org
    :init
    ;; org テンプレートを設定
    (setq cfw:org-capture-template
      '("c" "calfw2org" entry
        (file (concat org-directory "gcal.org"))
        "* %?\n%(cfw:org-capture-day)"))
    :config
    ;; org-agenda ソースで表示する内容を制限する
    ;;; Scheduled と Deadline のみ表示する
    (setq cfw:org-agenda-schedule-args
          (append '(:scheduled)
                  '(:deadline)))
    ;; カレンダーに DONE を表示しないためのアドバイス
    (defun my/cfw:org-schedule-period-to-calendar (orig-func &rest arg)
      (let ((org-agenda-skip-scheduled-if-done t))
        (apply orig-func arg)))
    (advice-add 'cfw:org-schedule-period-to-calendar
                :around
                #'my/cfw:org-schedule-period-to-calendar)
    ;; "C-q c a" で org-agenda をカレンダー上に表示する
    (bind-key "c a" 'cfw:open-org-calendar poco-key-map))
  ;; カレンダーを開く関数を定義
  (defun my/cfw:open-calendar ()
    (interactive)
    (let ((cp
           (cfw:create-calendar-component-buffer
            :view 'month
            :contents-sources
            (list
             (cfw:org-create-file-source
              "ToDo" (concat org-directory "gtd.org") "#859900")
             (cfw:org-create-file-source
              "予定" (concat org-directory "gcal.org") "#268bd2")))))
      (switch-to-buffer (cfw:cp-get-buffer cp))))
  ;; 祝日表記を日本の祝日にする
  (use-package holidays
    :config
    (use-package japanese-holidays)
    (setq calendar-holidays
          (append japanese-holidays holiday-local-holidays holiday-other-holidays)))
  ;; "C-q c c" でカレンダービューを開く
  (bind-key "c c" 'my/cfw:open-calendar poco-key-map)
  :config
  ;; 休日を表示する
  (setq cfw:display-calendar-holidays t)
  ;; 月名表記
  (setq calendar-month-name-array
        [" 1月(Jan)" " 2月(Feb)" " 3月(Mar)" " 4月(Apr)" " 5月(May)" " 6月(Jun)"
         " 7月(Jul)" " 8月(Aug)" " 9月(Sep)" "10月(Oct)" "11月(Nov)" "12月(Dec)"])
  ;; 曜日名表記
  (setq calendar-day-name-array
        ["日(Sun)" "月(Mon)" "火(Tue)" "水(Wed)" "木(Thu)" "金(Fri)" "土(Sat)"])
  ;; 週の先頭の曜日 (0: 日曜日)
  (setq calendar-week-start-day 0)
  ;; カレンダーに開始時刻を表示
  (setq cfw:event-format-overview "%s%t")
  ;;キーバインド
  )
