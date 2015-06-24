;;; helm-open-junk-files.el --- helm for open-junk-file -*- lexical-binding: t; -*-

;; Copyright (C) 2014 by masaaki1001

;; Author: masaaki1001
;; URL: https://github.com/masaaki1001/helm-open-junk-files
;; Version: 0.1
;; Package-Requires: ((helm "1.6.2") (open-junk-file "1.3") (f "20140220.21"))
;; Keywords: helm open-junk-file

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;;; Commentary:
;; http://qiita.com/akisute3@github/items/eba6bc64f66d278f0032

;;; Code:

(require 'helm)
(require 'open-junk-file)
(require 'f)

(defgroup helm-open-junk-files nil
  "helm-open-junk-files"
  :group 'emacs)

(defcustom helm-open-junk-files-dir (expand-file-name "junk" user-emacs-directory)
  "open-junk-file directory path."
  :type 'string
  :initialize 'custom-initialize-default
  :group 'helm-open-junk-files)

(defcustom helm-open-junk-files-exclude '(".git")
  "If Non-nil. exclude file."
  :type 'string
  :group 'helm-open-junk-files)

(defun helm-open-junk-files-include-p (filename)
  (let ((exclude helm-open-junk-files-exclude)
        (keepit t))
    (while (and exclude keepit)
      (setq keepit (not (ignore-errors
                          (if (stringp (car exclude))
                              (string-match (car exclude) filename)
                            (funcall (car exclude) filename))))
            exclude (cdr exclude)))
    keepit))

(defun helm-open-junk-files-files ()
  (f-entries helm-open-junk-files-dir
             (lambda (file) (helm-open-junk-files-include-p file))))

(defvar helm-source-junk-files
  '((name . "Junk Files")
    (candidates . helm-open-junk-files-files)
    (type . file)))

;;;###autoload
(defun helm-open-junk-files ()
  (interactive)
  (helm :sources '(helm-source-junk-files)
        :buffer "*helm for junk files*"))

(provide 'helm-open-junk-files)
;;; helm-open-junk-file.el ends here
