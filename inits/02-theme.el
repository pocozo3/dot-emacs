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
))
