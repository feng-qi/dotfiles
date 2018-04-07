;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     vimscript
     auto-completion
     better-defaults
     ;; semantic
     asm
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            c-c++-enable-clang-support t)
     (chinese :variables
              chinese-default-input-method 'wubi
              chinese-enable-youdao-dict t)
     (clojure :variables clojure-enable-fancify-symbols t)
     ;; ivy
     emacs-lisp
     (go :variables go-tab-width 4)
     haskell
     lua
     rust
     (scala :variables
            scala-indent:use-javadoc-style t
            scala-enable-eldoc t
            ;; scala-use-unicode-arrows t
            ;; scala-auto-start-ensime t
            scala-auto-insert-asterisk-in-comments t)
     ;; emoji
     ;; games
     ;; dash
     git
     github
     version-control
     ;; (gtags :variables gtags-enable-by-default nil)
     cscope
     html
     java
     javascript
     latex
     markdown
     org
     pdf-tools
     python
     ipython-notebook
     ranger
     sql
     ;; fasd
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     ;; speed-reading
     spell-checking
     ;; vimscript
     yaml
     ;; syntax-checking
     ;; fengqi
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(bison-mode
                                      cuda-mode
                                      monokai-theme
                                      plur ; vim Abolish
                                      ;; material-theme
                                      nhexl-mode
                                      thrift
                                      )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(chinese-pyim
                                    vi-tilde-fringe
                                    ;; evil-escape
                                    clean-aindent-mode
                                    multiple-cursors
                                    ace-pinyin
                                    find-by-pinyin-dired
                                    fancy-battery
                                    pangu-spacing
                                    )
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https nil
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style '(hybrid :variables
                                       hybrid-mode-enable-evilified-state t
                                       hybrid-mode-enable-hjkl-bindings t
                                       hybrid-mode-default-state 'normal)
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner nil
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-light
                         solarized-dark
                         spacemacs-dark
                         solarized-light
                         zenburn
                         leuven
                         monokai)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font `("Source Code Pro"
                               :size ,(if (string= system-name "qi-laptop") 15 13)
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab t
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ t
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text t
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.6
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar nil
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols nil
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'any
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (setq configuration-layer--elpa-archives
    '(("melpa-cn" . "http://elpa.zilongshanren.com/melpa/")
      ("org-cn"   . "http://elpa.zilongshanren.com/org/")
      ("gnu-cn"   . "http://elpa.zilongshanren.com/gnu/")))
  (setq tramp-ssh-controlmaster-options
        "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
  (setq byte-compile-warnings '(not obsolete))
  ;; (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
  (setq org-agenda-files '("~/org"))
  (setq org-pomodoro-length 40)
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks") "* TODO")))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (load-file "~/.spacemacs.d/funcs.el")
  ;; (setq ivy-count-format "(%d/%d) ")
  (setq powerline-default-separator nil)
  ;; (spaceline-compile)
  ;; (setq-default evil-escape-key-sequence "jk")
  (global-company-mode t)
  (global-prettify-symbols-mode t)
  ;; (setq-default show-trailing-whitespace t)
  (setq-default python-shell-interpreter "python3")

  (fengqi/define-key evil-normal-state-map
                     "g[" 'backward-page ; https://github.com/lujun9972/emacs-document/blob/master/emacs-common/%E5%90%88%E7%90%86%E5%9C%B0%E5%9C%A8Emacs%E4%B8%AD%E4%BD%BF%E7%94%A8%E5%88%86%E9%A1%B5%E7%AC%A6.org
                     "g]" 'backward-page
                     "+" 'evil-numbers/inc-at-pt
                     "-" 'evil-numbers/dec-at-pt)
  (fengqi/define-key evil-visual-state-map
                     "+" 'evil-numbers/inc-at-pt
                     "-" 'evil-numbers/dec-at-pt)
  ;; (fengqi/define-key evil-motion-state-map
  ;;                    "t" 'evil-find-char-backward)

  ;; (global-set-key (kbd "C-=") 'er/expand-region)
  (global-set-key (kbd "C-c i") 'ido-insert-buffer)
  (global-set-key (kbd "C-'") 'fengqi/upcase-previous-WORD)
  (spacemacs/set-leader-keys
    (kbd "xas") 'spacemacs/align-repeat-space
    (kbd "iv")  'rectangle-number-lines ; https://www.reddit.com/r/emacs/comments/3n1ikz/turn_column_of_0s_into_incrementing_values/
    (kbd "bv")  'mark-whole-buffer
    (kbd "by")  'spacemacs/copy-whole-buffer-to-clipboard
    (kbd "fm")  'fengqi/move-current-buffer-file
    (kbd "oe")  'eval-and-replace
    ;; (kbd "om")  'evil-mc-mode
    (kbd "oi")  'fengqi/insert-current-buffer-name
    (kbd "oc")  'fengqi/copy-current-buffer-name
    (kbd "oo")  'fengqi/set-compile-command
    (kbd "op")  'plur-replace
    (kbd "or")  'fengqi/string-reverse
    (kbd "os")  'just-one-space
    ;; (kbd "ou")  'fengqi/upcase-previous-WORD
    (kbd "oy")  'youdao-dictionary-search-at-point+
    ;; (kbd "tf")  'spacemacs/toggle-auto-fill-mode
    ;; (kbd "tF")  'spacemacs/toggle-fill-column-indicator
    (kbd "wo")  'spacemacs/toggle-maximize-buffer
    (kbd "ws")  'split-window-below-and-focus
    (kbd "wv")  'split-window-right-and-focus
    (kbd "fCr") 'revert-buffer-with-coding-system
    (kbd "fCc") 'set-buffer-file-coding-system ; change buffer encoding
    (kbd "dw")  'delete-trailing-whitespace
    (kbd "dc")  'fengqi/describe-buffer-file-coding-system
    (kbd "toi") 'org-toggle-inline-images
    (kbd "8")   'spacemacs/toggle-maximize-frame)

  (dolist (mode '(c-mode c++-mode))
    (evil-leader/set-key-for-mode mode
      "f f" 'clang-format-region
      "o o" 'fengqi/set-compile-command
      ))

  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (setq TeX-engine 'xetex)
              (add-to-list 'TeX-command-list
                           '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))))

  (add-hook 'compilation-mode-hook (lambda () (setq compilation-window-height 10)))
  (add-hook 'markdown-mode-hook 'auto-fill-mode)
  (add-hook 'org-mode-hook (lambda () (progn
                                   (setq show-trailing-whitespace t)
                                   (smartparens-mode t)
                                   (auto-fill-mode t)
                                   )))

  ;; markdown exporter, more info: https://orgmode.org/worg/exporters/ox-overview.html
  (eval-after-load "org"
    '(progn
       ;; (define-key org-mode-map [(kbd "C-'")] nil)
       (fengqi/define-key org-mode-map
                          (kbd "C-'") 'fengqi/upcase-previous-WORD)
       (require 'ox-md nil t)
       (setq org-link-frame-setup
             '((vm      . vm-visit-folder-other-frame)
               (vm-imap . vm-visit-imap-folder-other-frame)
               (gnus    . org-gnus-no-new-news)
               (file    . find-file)
               (wl      . wl-other-frame)))
       ))

  ;; https://emacs.stackexchange.com/questions/9583/how-to-treat-underscore-as-part-of-the-word
  (with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol))
  ;; https://github.com/syl20bnr/spacemacs/blob/develop/doc/FAQ.org#include-underscores-in-word-motions
  ;; (add-hook 'c++-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  ;; (add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

  ;; (add-hook 'term-mode-hook (lambda () (setq show-trailing-whitespace nil)))

  ;; (add-to-list 'auto-mode-alist '("\\.cu\\'" . c-mode))

  (setq sp-highlight-pair-overlay     nil
        sp-highlight-wrap-overlay     nil
        sp-highlight-wrap-tag-overlay nil)

  (setq-default tab-width      4
                fill-column    80
                truncate-lines t
                c-basic-offset 4)
  ;; (setq browse-url-browser-function 'eww-browse-url)
  (when window-system
    (add-to-list 'default-frame-alist '(height . 52))
    (add-to-list 'default-frame-alist '(width . 100))
    (add-to-list 'default-frame-alist '(top . 0))
    (add-to-list 'default-frame-alist '(left . 1100)))

  (c-add-style "fengqi"
               '((c-basic-offset . 2)
                 (c-offset-alist
                  (defun-open . 0)
                  (defun-block-intro . +))))

  ;; https://github.com/lujun9972/emacs-document/blob/master/emacs-common/%E8%AE%A9Emacs%E4%B8%BA%E4%BD%A0%E8%87%AA%E5%8A%A8%E6%8F%92%E5%85%A5%E5%86%85%E5%AE%B9(Emacs%E6%A8%A1%E6%9D%BF%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97).org
  ;; (add-hook 'find-file-hook 'auto-insert)
  ;; (define-auto-insert "CMakeLists.txt" "~/github/cpp_starter_project/CMakeLists.txt")

  (add-to-list 'yas-snippet-dirs "~/dotfiles/snippets")
  (setq eclim-eclipse-dirs '("~/eclipse")
        eclim-executable "~/eclipse/eclim"
        eclimd-default-workspace "~/workspace")
  ;; (add-hook 'java-mode-hook (lambda () (company-emacs-eclim-setup)))


  (put 'helm-make-build-dir 'safe-local-variable 'stringp)
  ;; (with-eval-after-load 'projectile
  ;;   (push '("c" "h") projectile-other-file-alist))
  ;; (push '(other . "k&r") c-default-style)
  ;; (when (file-exists-p "~/.local.el")
  ;;   (load "~/.local.el"))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(setq custom-file (expand-file-name "customize-group-setup.el" dotspacemacs-directory))
(load custom-file 'no-error 'no-message)
