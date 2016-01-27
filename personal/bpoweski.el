;;; package --- custom init
;;; Commentary:
;;;
;;; Code:

<<<<<<< HEAD
=======
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
>>>>>>> bpoweski.el
(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

(defun set-frame-pixel-size (frame width height)
  "Sets size of FRAME to WIDTH by HEIGHT, measured in pixels."
  (let ((pixels-per-char-width (/ (frame-pixel-width) (frame-width)))
        (pixels-per-char-height (/ (frame-pixel-height) (frame-height))))
    (set-frame-size frame
                    (floor (/ width pixels-per-char-width))
                    (floor (/ height pixels-per-char-height)))))

(defun use-left-half-screen ()
  (interactive)
  (let* ((excess-width 32)
         (excess-height 48)
         (half-screen-width (- (/ 2560 2) excess-width))
         (screen-height (- (x-display-pixel-height nil) excess-height)))
    (set-frame-pixel-size (selected-frame) half-screen-width screen-height)))

(if window-system
    (use-left-half-screen))

;; smartparens
(cua-selection-mode t)
;; (electric-indent-mode +1)

(sp-use-paredit-bindings)
;; (setq sp-autoinsert-if-followed-by-word t)

;; (defun live-sp-add-space-after-sexp-insertion (id action _context)
;;   (when (eq action 'insert)
;;     (save-excursion
;;       (forward-char (length (plist-get (sp-get-pair id) :close)))
;;       (when (or (eq (char-syntax (following-char)) ?w)
;;                 (looking-at (sp--get-opening-regexp)))
;;         (insert " ")))))

;; (defun live-sp-add-space-before-sexp-insertion (id action _context)
;;   (when (eq action 'insert)
;;     (save-excursion
;;       (backward-char (length id))
;;       (when (or (eq (char-syntax (preceding-char)) ?w)
;;                 (looking-at (sp--get-closing-regexp)))
;;         (insert " ")))))

;; solarized
(disable-theme 'zenburn)
(load-theme 'solarized-dark t)

(prelude-require-package 'align-cljlet)
(key-chord-define-global "LL" 'align-cljlet)
(key-chord-define-global "uu" nil)
(key-chord-define-global "UU" 'undo-tree-visualize)

;; ess/R
(require 'ess-site)
;; (require 'poly-R)
;; (require 'poly-markdown)
;;(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
(setq auto-mode-alist (cons '("\\.R$" . R-mode) auto-mode-alist))
(ess-toggle-underscore nil)
(setq-default flycheck-disabled-checkers '(r-lintr))
(setq ess-swv-weave "knitr")

<<<<<<< HEAD
=======
(add-hook 'ess-R-post-run-hook 'ess-execute-screen-options)
>>>>>>> bpoweski.el

;; YAS
;; (prelude-require-package 'yasnippet)
;; (yas-global-mode 1)

;; clj-refactor
(prelude-require-package 'clj-refactor)

(add-hook 'cider-mode-hook 'eldoc-mode)

(defun cleanup-clojure-buffer ()
  (if (s-starts-with? "example_" (buffer-name))
      (message "skipping buffer cleanup")
    (if (not (string= (projectile-project-root) "/Users/bpoweski/Projects/getaroom/http.async.client/"))
        (crux-cleanup-buffer-or-region))))

(defun setup-clojure-mode ()
  (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
  (setq prelude-whitespace t)
  (setq prelude-clean-whitespace-on-save t)
  (add-hook 'before-save-hook 'cleanup-clojure-buffer nil t)
  (clj-refactor-mode 1)
  (cljr-add-keybindings-with-prefix "C-c RET")
  (setq cljr-favor-prefix-notation nil)
  ;; insert keybinding setup here
  (define-key smartparens-mode-map (kbd "C-k") 'sp-kill-sexp)
  (setq projectile-project-type 'lein-test)
  (setq cider-repl-pop-to-buffer-on-connect nil)
  ;;(set-variable 'cider-lein-parameters "with-profile +test,+cider repl")
  (setq nrepl-log-messages nil)
  (setq cider-repl-use-pretty-print t))

(require 'smartparens-config)

(eval-after-load 'clojure-mode
  '(progn
     (define-clojure-indent
       (fact 'defun)
       (facts 'defun)
<<<<<<< HEAD
=======
       (with-kryo 'defun)
>>>>>>> bpoweski.el
       (pform 'defun)
       (domonad 'defun)
       (against-background 'defun)
       (provided 0)
       (go-loop 'defun)
       (wcar 'defun)
       (match 'defun)
       (render-state 'defun)
       (init-state 'defun)
       (render 'defun)
       (did-mount 'defun)
       (letfn     '(1 ((:defn)) :form))
<<<<<<< HEAD
=======
       (deftype   '(2 nil nil (:defn)))
>>>>>>> bpoweski.el
       (defroutes 'defun)
       (GET 2)
       (POST 2)
       (PUT 2)
       (DELETE 2)
       (HEAD 2)
       (ANY 2)
       (OPTIONS 2)
       (PATCH 2)
       (rfn 2)
       (let-routes 1)
<<<<<<< HEAD
       (context 2))
=======
       (context 2)
       (with-precision :defn)
       (as-> 2))
>>>>>>> bpoweski.el
     (put-clojure-indent '-> nil)
     (put-clojure-indent '->> nil)
     (electric-indent-mode -1)

     (add-hook 'clojure-mode-hook 'setup-clojure-mode)
     (add-hook 'cider-mode-hook
               (lambda ()
                 (define-key cider-mode-map (kbd "C-c M-m") 'cider-macroexpand-1)
                 (setq cider-repl-use-pretty-print t)))

     (add-hook 'cider-repl-mode-hook #'company-mode)
     (add-hook 'cider-mode-hook #'company-mode)
     (global-set-key (kbd "TAB") #'company-indent-or-complete-common)

     (message "configured clojure mode")))

(defun clear-shell ()
  (interactive)
  (let ((old-max comint-buffer-maximum-size))
    (setq comint-buffer-maximum-size 0)
    (comint-truncate-buffer)
    (setq comint-buffer-maximum-size old-max)))

(global-linum-mode t)

(setq whitespace-line-column 250)

;;(setenv "MIDJE_COLORIZE" "false")
(setenv "FRAMEWORK_ENV" "test")
(setenv "RABBITMQ_VHOST" "/price_sheet_test")
(setenv "COUCHBASE_PASSWORD" "default")
;;(setenv "MONGODB_URI" "mongodb://127.0.0.1:27017/price_sheet_test")
(setenv "LEIN_JVM_OPTS" "-Xmx2g")




(define-key prelude-mode-map (kbd "C-c k") nil)

;; org-mode
(setq org-latex-create-formula-image-program 'dvipng)
(setq org-directory "~/OrgMode")
(setq org-default-notes-file "~/OrgMode/notes.org")
(setq org-agenda-files (list "~/OrgMode/work.org"))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(prelude-require-package 'helm-git-grep)
(prelude-require-package 'helm-ag)

(global-set-key (kbd "C-c C-g") 'helm-git-grep)
(global-set-key (kbd "C-c C-a") 'helm-do-ag-project-root)

;; Invoke `helm-git-grep' from isearch.
(define-key isearch-mode-map (kbd "C-c g") 'helm-git-grep-from-isearch)
;; Invoke `helm-git-grep' from other helm.
(eval-after-load 'helm
  '(define-key helm-map (kbd "C-c g") 'helm-git-grep-from-helm))



;; (prelude-require-package 'elpy)
;; (anaconda-mode 0)
;; (elpy-enable)

;; (add-hook 'markdown-mode (progn (electric-indent-mode -1)
;;                                 (setq prelude-whitespace t)
;;                                 (message "customized markdown mode")))

;; (add-hook 'python-mode (progn (anaconda-mode 0)))


;; https://emacs.stackexchange.com/questions/30082/your-python-shell-interpreter-doesn-t-seem-to-support-readline
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))

;;(prelude-require-package 'pyenv-mode)
(prelude-require-package 'elpy)



(elpy-enable)

(setq elpy-modules
      '(elpy-module-eldoc
        elpy-module-pyvenv
        elpy-module-sane-defaults)
      elpy-shell-echo-input nil
      elpy-shell-echo-output 'when-shell-not-visible)


(defun prelude-personal-python-mode-defaults ()
  "Personal defaults for Python programming."
  ;; Enable elpy mode
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "--simple-prompt -c exec('__import__(\\'readline\\')') -i")
  (add-to-list 'python-shell-completion-native-disabled-interpreters
               "jupyter")
  (setq eldoc-idle-delay 1)
  (pyenv-mode)
  (elpy-mode)


  (elpy-shell-toggle-dedicated-shell 1)
  (elpy-shell-set-local-shell (elpy-project-root))

  ;; disable find-file-in-project because of helm
  (define-key elpy-mode-map (kbd "C-c C-f") nil)
  (define-key elpy-mode-map (kbd "C-c C-g") nil)

  ;; disable elpy-rgrep-symbol of helm
  (define-key elpy-mode-map (kbd "C-c C-s") nil)


  (setq-local python-indent-offset 4)
  (setq prelude-whitespace nil)
  (electric-indent-mode -1)
  (setq prelude-whitespace t)
  (setq prelude-clean-whitespace-on-save t)
  (add-hook 'before-save-hook 'prelude-cleanup-buffer-or-region nil t)
  (message "ran python model hook"))


(add-hook 'python-mode-hook 'prelude-personal-python-mode-defaults)

(add-hook 'orgtbl-mode (progn (electric-indent-mode -1)
                              (setq prelude-clean-whitespace-on-save nil)))

(add-hook 'makefile-bsdmake-mode (progn (electric-indent-mode -1)
                                        (setq-local prelude-whitespace nil)
                                        (message "ran bsdmake-mode hook")))

;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=25055
(setq window-combination-resize t)

(define-key global-map (kbd "C-c l") 'helm-directory)
(define-key global-map (kbd "C-c C-l") 'helm-directory)

(require 'flycheck-yamllint)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))
