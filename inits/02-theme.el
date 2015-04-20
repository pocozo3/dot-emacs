;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; color-theme-solarized: Solarized テーマ
;;; https://github.com/sellout/emacs-color-theme-solarized
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;;; カラーテーマライブラリのロード
(use-package color-theme)

;;; ロードと設定
(use-package color-theme-solarized
  :config
  ;; Solarized テーマをロード
  (load-theme 'solarized t)
  ;; Dark スキーマを使用
  (set-frame-parameter nil 'background-mode 'dark)
  (enable-theme 'solarized)
   ;; 追加の色設定
  (custom-theme-set-faces
    ;; テーマ名
    'solarized

    ;; paren
    `(show-paren-match ((t (:inverse-video nil :underline ,my/sct-yellow
                            :slant normal :weight extra-bold))))

    ;; ddskk
    `(skk-dcomp-face ((t (:foreground ,my/sct-base1 :slant italic))))
    `(skk-dcomp-multiple-selected-face ((t (:background ,my/sct-base2
                                            :foreground ,my/sct-violet
                                            :weight bold))))
    `(skk-dcomp-multiple-trailing-face ((t (:inherit skk-dcomp-multiple-face
                                            :foreground ,my/sct-base3
                                            :weight bold))))
    `(skk-display-code-char-face ((t (:inherit default
                                      :background ,my/sct-yellow
                                      :foreground ,my/sct-base03))))
    `(skk-display-code-prompt-face ((t (:inherit default
                                        :foreground ,my/sct-cyan))))
    `(skk-emacs-abbrev-face ((t (:foreground ,my/sct-blue))) t)
    `(skk-emacs-hiragana-face ((t (:foreground ,my/sct-red))) t)
    `(skk-emacs-jisx0201-face ((t (:foreground ,my/sct-violet))) t)
    `(skk-emacs-jisx0208-latin-face ((t (:foreground ,my/sct-yellow))) t)
    `(skk-emacs-katakana-face ((t (:foreground ,my/sct-green))) t)
    `(skk-henkan-face-default ((t (:background ,my/sct-green
                                   :foreground ,my/sct-base3))))
    `(skk-list-chars-table-header-face ((t (:inherit default
                                            :foreground ,my/sct-orange))))
    `(skk-prefix-hiragana-face ((t (:foreground ,my/sct-red))))
    `(skk-prefix-jisx0201-face ((t (:foreground ,my/sct-violet))))
    `(skk-prefix-katakana-face ((t (:foreground ,my/sct-green))))
    `(skk-show-mode-inline-face ((t (:inherit default
                                     :background ,my/sct-base02 :box 1))))
    `(skk-treat-default ((t (:foreground ,my/sct-base3))))
    `(skk-verbose-kbd-face ((t (:inherit default :foreground ,my/sct-cyan))))

    ;; modeline
    `(mode-line ((t (:background ,my/sct-base02 :foreground ,my/sct-base1
                     :inverse-video nil :box (:line-width 2 :color ,my/sct-base02)
                     :weight normal :height 120))))
    `(mode-line-inactive ((t (:background ,my/sct-base01
                              :foreground ,my/sct-base00
                              :inverse-video nil
                              :box (:line-width 2 :color ,my/sct-base01)
                              :weight extra-light :height 120))))
    ;; whitespace
    `(whitespace-newline ((t (:foreground ,my/sct-violet :weight normal))))
    `(whitespace-space ((t (:foreground ,my/sct-violet))))
    `(whitespace-tab ((t (:foreground ,my/sct-violet))))

    ;; dired
    `(dired-mark ((t (:inherit font-lock-keyword-face))))
    `(dired-symlink ((t (:inherit font-lock-constant-face))))
    `(dired-async-message ((t (:foreground ,my/sct-yellow))))
    `(dired-async-mode-message ((t (:background ,my/sct-red))))

    ;; elscreen
    `(elscreen-tab-background-face ((t (:background ,my/sct-base01))))
    `(elscreen-tab-control-face ((t (:background ,my/sct-base2
                                     :foreground ,my/sct-base02
                                     :underline ,my/sct-base01))))
    `(elscreen-tab-current-screen-face ((t (:background ,my/sct-base2
                                            :foreground ,my/sct-base02))))
    `(elscreen-tab-other-screen-face ((t (:background ,my/sct-base1
                                          :foreground ,my/sct-base01))))

    ;; auto-complete
    `(ac-completion-face ((t (:foreground ,my/sct-base01 :underline t))))

    ;; undo-tree
    `(undo-tree-visualizer-active-branch-face ((t (:foreground ,my/sct-base1
                                                   :weight bold))))
    `(undo-tree-visualizer-current-face ((t (:foreground ,my/sct-red
                                             :weight bold))))
    `(undo-tree-visualizer-default-face ((t (:foreground ,my/sct-base01))))
    `(undo-tree-visualizer-register-face ((t (:foreground ,my/sct-yellow))))
    `(undo-tree-visualizer-unmodified-face ((t (:foreground ,my/sct-cyan))))

    ;; popup
    `(popup-face ((t (:background ,my/sct-base0 :foreground ,my/sct-base02))))
    `(popup-menu-selection-face ((t (:background ,my/sct-cyan
                                     :foreground ,my/sct-base3 :weight bold))))
    `(popup-isearch-match ((t (:background ,my/sct-blue
                               :foreground ,my/sct-base3 :weight bold))))
    `(popup-menu-mouse-face ((t (:background ,my/sct-violet
                                 :foreground ,my/sct-base3 :weight bold))))
    `(popup-scroll-bar-background-face ((t (:background ,my/sct-base2))))
    `(popup-scroll-bar-foreground-face ((t (:background ,my/sct-base02))))
    `(popup-summary-face ((t (:inherit popup-face :foreground ,my/sct-base01))))
    `(popup-tip-face ((t (:background ,my/sct-yellow
                          :foreground ,my/sct-base03))))

    ;; zlc
    `(zlc-selected-completion-face ((t (:background ,my/sct-red
                                        :foreground ,my/sct-base2 :weight bold))))
    ;; git-rebase-mode
    `(git-rebase-hash ((t (:foreground ,my/sct-magenta))))

    ;; magit
    `(magit-branch ((t (:background ,my/sct-base01 :foreground ,my/sct-cyan))))
    `(magit-cherry-equivalent ((t (:foreground ,my/sct-magenta))))
    `(magit-cherry-unmatched ((t (:foreground ,my/sct-cyan))))
    `(magit-log-author ((t (:foreground ,my/sct-magenta))))
    `(magit-log-graph ((t (:foreground ,my/sct-base2))))
    `(magit-log-head-label-bisect-bad ((t (:background ,my/sct-base2
                                           :foreground ,my/sct-red :box 1))))
    `(magit-log-head-label-bisect-good ((t (:background ,my/sct-base01
                                            :foreground ,my/sct-green :box 1))))
    `(magit-log-head-label-default ((t (:background ,my/sct-base01 :box 1))))
    `(magit-log-head-label-head ((t (:background ,my/sct-base02
                                     :foreground ,my/sct-base3 :box 1))))
    `(magit-log-head-label-local ((t (:background ,my/sct-base02
                                      :foreground ,my/sct-cyan :box 1))))
    `(magit-log-head-label-patches ((t (:background ,my/sct-base2
                                        :foreground ,my/sct-red :box 1))))
    `(magit-log-head-label-remote ((t (:background ,my/sct-base02
                                       :foreground ,my/sct-green :box 1))))
    `(magit-log-head-label-tags ((t (:background ,my/sct-base01
                                     :foreground ,my/sct-yellow :box 1))))
    `(magit-log-head-label-wip ((t (:background ,my/sct-base2
                                    :foreground ,my/sct-base1 :box 1))))
    `(magit-log-reflog-label-checkout ((t (:background ,my/sct-base02
                                           :foreground ,my/sct-cyan :box 1))))
    `(magit-log-reflog-label-cherry-pick ((t (:background ,my/sct-green
                                              :foreground ,my/sct-blue :box 1))))
    `(magit-log-reflog-label-commit ((t (:background ,my/sct-base00
                                         :foreground ,my/sct-yellow :box 1))))
    `(magit-log-reflog-label-other ((t (:background ,my/sct-base01 :box 1))))
    `(magit-log-reflog-label-rebase ((t (:background ,my/sct-base03
                                         :foreground ,my/sct-green :box 1))))
    `(magit-log-reflog-label-remote ((t (:background ,my/sct-base01 :box 1))))
    `(magit-log-reflog-label-reset ((t (:background ,my/sct-base2
                                        :foreground ,my/sct-red :box 1))))
    `(magit-log-sha1 ((t (:foreground ,my/sct-magenta))))
    `(magit-process-ng ((t (:inherit magit-section-title
                            :foreground ,my/sct-red))))
    `(magit-process-ok ((t (:inherit magit-section-title
                            :foreground ,my/sct-green))))
    `(magit-signature-bad ((t (:foreground ,my/sct-red))))
    `(magit-signature-good ((t (:foreground ,my/sct-green))))
    `(magit-signature-untrusted ((t (:foreground ,my/sct-cyan))))
    `(magit-tag ((t (:background ,my/sct-base2 :foreground ,my/sct-yellow))))

    ;; helm
    `(helm-M-x-key ((t (:foreground ,my/sct-orange :underline t))))
    `(helm-buffer-directory ((t (:foreground ,my/sct-blue :weight bold))))
    `(helm-buffer-not-saved ((t (:foreground ,my/sct-magenta))))
    `(helm-buffer-process ((t (:foreground ,my/sct-orange))))
    `(helm-buffer-saved-out ((t (:background ,my/sct-base03
                                 :foreground ,my/sct-red))))
    `(helm-buffer-size ((t (:foreground ,my/sct-base1 :weight bold))))
    `(helm-candidate-number ((t (:background ,my/sct-yellow
                                 :foreground ,my/sct-base03))))
    `(helm-ff-directory ((t (:foreground ,my/sct-blue :weight bold))))
    `(helm-ff-executable ((t (:foreground ,my/sct-green))))
    `(helm-ff-file ((t (:inherit font-lock-doc-face))))
    `(helm-ff-invalid-symlink ((t (:background ,my/sct-red
                                   :foreground ,my/sct-base03))))
    `(helm-ff-prefix ((t (:background ,my/sct-yellow
                          :foreground ,my/sct-base03))))
    `(helm-ff-symlink ((t (:foreground ,my/sct-cyan))))
    `(helm-grep-file ((t (:foreground ,my/sct-violet :underline t))))
    `(helm-grep-finish ((t (:foreground ,my/sct-green))))
    `(helm-grep-lineno ((t (:foreground ,my/sct-orange))))
    `(helm-grep-match ((t (:foreground ,my/sct-yellow))))
    `(helm-grep-running ((t (:foreground ,my/sct-red))))
    `(helm-history-remote ((t (:foreground ,my/sct-magenta))))
    `(helm-lisp-completion-info ((t (:foreground ,my/sct-red))))
    `(helm-lisp-show-completion ((t (:background ,my/sct-base01))))
    `(helm-locate-finish ((t (:foreground ,my/sct-green))))
    `(helm-match ((t (:foreground ,my/sct-yellow))))
    `(helm-moccur-buffer ((t (:foreground ,my/sct-cyan :underline t))))
    `(helm-prefarg ((t (:foreground ,my/sct-green))))
    `(helm-resume-need-update ((t (:background ,my/sct-red))))
    `(helm-selection ((t (:background ,my/sct-green
                          :foreground ,my/sct-base03 :underline t))))
    `(helm-selection-line ((t (:background ,my/sct-magenta
                               :foreground ,my/sct-base03 :underline t))))
    `(helm-separator ((t (:foreground ,my/sct-red))))
    `(helm-source-header ((t (:background ,my/sct-blue :foreground ,my/sct-base2
                              :weight bold :height 1.3 :family "Sans Serif"))))
    `(helm-visible-mark ((t (:background ,my/sct-cyan
                             :foreground ,my/sct-base03))))

    ;; helm-swoop
    `(helm-swoop-line-number-face ((t (:foreground ,my/sct-base01))))
    `(helm-swoop-target-line-block-face ((t (:background ,my/sct-orange
                                             :foreground ,my/sct-base03))))
    `(helm-swoop-target-line-face ((t (:background ,my/sct-yellow
                                       :foreground ,my/sct-base03))))
    `(helm-swoop-target-word-face ((t (:background ,my/sct-violet
                                       :foreground ,my/sct-base2 :weight bold))))
    ))
