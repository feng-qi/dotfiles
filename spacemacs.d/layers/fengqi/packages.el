;;; packages.el --- fengqi layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: fengqi <qi@qi-laptop>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `fengqi-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `fengqi/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `fengqi/pre-init-PACKAGE' and/or
;;   `fengqi/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst fengqi-packages
  '(
    bison-mode
    cuda-mode
    solarized-theme
    monokai-theme
    plur ; vim Abolish
    nhexl-mode
    thrift
    rtags
    yasnippet-snippets
    tldr
    ;; org-ac
    zenburn-theme
    )
  "The list of Lisp packages required by the fengqi layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun fengqi/init-cuda-mode ()
  (use-package cuda-mode
    :defer t
    ))

(defun fengqi/init-bison-mode ()
  (use-package bison-mode
    :defer t
    ))

(defun fengqi/init-solarized-theme ()
  (use-package solarized-theme
    :defer t
    ))

(defun fengqi/init-monokai-theme ()
  (use-package monokai-theme
    :defer t
    ))

(defun fengqi/init-plur ()
  (use-package plur
    :defer t
    ))

(defun fengqi/init-nhexl-mode ()
  (use-package nhexl-mode
    :defer t
    ))

(defun fengqi/init-thrift ()
  (use-package thrift
    :defer t
    ))

(defun fengqi/init-rtags ()
  (use-package rtags
    :defer t
    ))

(defun fengqi/init-yasnippet-snippets ()
  (use-package yasnippet-snippets
    :defer t
    ))

(defun fengqi/init-tldr ()
  (use-package tldr
    :defer t
    ))

(defun fengqi/init-zenburn-theme ()
  (use-package tldr
    :defer t
    ))

;;; packages.el ends here
