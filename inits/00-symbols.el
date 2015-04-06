;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
;; シンボルの定義
;;; 色 (Solarized Color Table - sct)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
(cond ((window-system)
        (defvar my/sct-base03  "#002b36")
        (defvar my/sct-base02  "#073642")
        (defvar my/sct-base01  "#586e75")
        (defvar my/sct-base00  "#657b83")
        (defvar my/sct-base0   "#839496")
        (defvar my/sct-base1   "#93a1a1")
        (defvar my/sct-base2   "#eee8d5")
        (defvar my/sct-base3   "#fdf6e3")
        (defvar my/sct-yellow  "#b58900")
        (defvar my/sct-orange  "#cb4b16")
        (defvar my/sct-red     "#dc322f")
        (defvar my/sct-magenta "#d33682")
        (defvar my/sct-violet  "#6c71c4")
        (defvar my/sct-blue    "#268bd2")
        (defvar my/sct-cyan    "#2aa198")
        (defvar my/sct-green   "#859900"))
      (t
        (defvar my/sct-base03  "brightblack")
        (defvar my/sct-base02  "black")
        (defvar my/sct-base01  "brightgreen")
        (defvar my/sct-base00  "brightyellow")
        (defvar my/sct-base0   "brightblue")
        (defvar my/sct-base1   "brightcyan")
        (defvar my/sct-base2   "white")
        (defvar my/sct-base3   "brightwhite")
        (defvar my/sct-yellow  "yellow")
        (defvar my/sct-orange  "brightred")
        (defvar my/sct-red     "red")
        (defvar my/sct-magenta "magenta")
        (defvar my/sct-violet  "brightmagenta")
        (defvar my/sct-blue    "blue")
        (defvar my/sct-cyan    "cyan")
        (defvar my/sct-green   "green")))
