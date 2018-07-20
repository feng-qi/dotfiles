(spacemacs|create-align-repeat-x "space" " " nil t)

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun fengqi/define-key (keymap &rest bindings)
  (while bindings
    (define-key keymap (pop bindings) (pop bindings))))

(defun fengqi/upcase-previous-WORD ()
  "Make the WORD before cursor upper case."
  (interactive)
  (save-excursion
    (setq end (point))
    (skip-chars-backward "[:alnum:]-_")
    (setq begin (point))
    ;; (message (concat (number-to-string begin) " " (number-to-string end)))
    (upcase-region begin end)))

(defun fengqi/insert-current-buffer-name ()
  "Insert the full path file name into the current buffer.

See URL `https://unix.stackexchange.com/questions/45125/how-to-get-current-buffers-filename-in-emacs/243679'."
  (interactive)
  (insert (buffer-name)))
;; (insert (buffer-file-name (window-buffer (minibuffer-selected-window)))))

(defun fengqi/copy-current-buffer-name ()
  "Copy the name of current buffer."
  (interactive)
  (kill-new (buffer-name)))
;; (kill-new (buffer-file-name (window-buffer (minibuffer-selected-window)))))

(defun fengqi/buffer-contains-pattern? (pattern)
  "Check if current buffer contains string <pattern>.

See URL `https://stackoverflow.com/questions/3034237/check-if-current-emacs-buffer-contains-a-string'."
  (interactive "sPattern: ")
  (save-excursion
    (goto-char (point-min))
    (search-forward pattern nil t)))

(defun fengqi/set-compile-command ()
  "Set compile-command to compile current file."
  (interactive)
  (let ((library-opt  (cond ((fengqi/buffer-contains-pattern? "gtest") " -lgtest -lgtest_main -lpthread")
                            ((fengqi/buffer-contains-pattern? "BOOST_") " -lboost_unit_test_framework")
                            (t "")))
        (static-opt   (if (fengqi/buffer-contains-pattern? "BOOST_") " -static" ""))
        (c++17-opt    (if (string= major-mode "c++-mode") " -std=c++17" ""))
        (file-name    (file-name-nondirectory (buffer-file-name)))
        (compiler-opt (cond ((string= major-mode "c++-mode")  "clang++ ")
                            ((string= major-mode "c-mode")    "clang ")
                            ((string= major-mode "java-mode") "javac ")
                            (t ""))))
    (when (not (string= compiler-opt ""))
      (setq compile-command (concat compiler-opt file-name c++17-opt library-opt static-opt)))))

(defun fengqi/move-current-buffer-file ()
  "Move current buffer file."
  (interactive)
  (let* ((filename-old (buffer-file-name))
         (buffer-old   (current-buffer))
         (dirname      (read-directory-name "Move to: "))
         (filename-new (concat dirname (file-name-nondirectory filename-old))))
    ;; (call-interactively 'write-file)
    (copy-file filename-old filename-new)
    (delete-file filename-old)
    (kill-buffer buffer-old)
    (find-file filename-new)
    (message "Move `%s' to `%s' successfully." filename-old filename-new)))

(defun fengqi/string-reverse (beg end)
  (interactive "r")
  (save-restriction
    (narrow-to-region beg end)
    (let ((string-to-reverse (buffer-substring-no-properties (point-min) (point-max))))
      (message string-to-reverse)
      (goto-char (point-min))
      (search-forward string-to-reverse)
      (replace-match (string-reverse string-to-reverse))))
  )

(defun fengqi/describe-buffer-file-coding-system ()
  (interactive)
  (message "%s" buffer-file-coding-system))

(defun fengqi/count-words-region (posBegin posEnd)
  "Print number of words and chars in region.

See URL `http://ergoemacs.org/emacs/elisp_count-region.html'.
See also `count-words-region'"
  (interactive "r")
  (message "Counting …")
  (save-excursion
    (let (wordCount charCount)
      (setq wordCount 0)
      (setq charCount (- posEnd posBegin))
      (goto-char posBegin)
      (while (and (< (point) posEnd)
                  (re-search-forward "\\w+\\W*" posEnd t))
        (setq wordCount (1+ wordCount)))

      (kill-new (number-to-string charCount))
      (evil-exit-visual-state)
      (message "Words: %d. Chars: %d." wordCount charCount)
      )))
