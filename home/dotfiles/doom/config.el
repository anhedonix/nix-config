;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

(setq user-full-name "Anand Magaji"
      user-mail-address "anand@eosacro.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq
      doom-font (font-spec :family "Source Code Pro" :size 16)
      doom-unicode-font (font-spec :family "Source Code Pro")
      ;; doom-variable-pitch-font (font-spec :family "Cantarell" :size 16)
    )

(when (or window-system (daemonp))
  (setq default-frame-alist '(
                              (width . 120)
                              (height . 60)
                              ))
  ;; (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
  ;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
  )

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

;; (menu-bar-mode -1)            ; Disable the menu bar

;; Remove visual bell on MacOS
(setq visible-bell nil)

;; UTF-8 as default encoding
(set-language-environment "utf-8")
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(set-default-coding-systems 'utf-8)
(setq fancy-splash-image (concat doom-private-dir "eo_banner.png"))


(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Anand Magaji - Magaji.dev")))
;; set transparency
;; (set-frame-parameter (selected-frame) 'alpha '(80 80))
;; (add-to-list 'default-frame-alist '(alpha 80 80))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; (use-package doom-themes
;;   :init (load-theme 'doom-gruvbox t))

;; A nice theme that I seem to like and its default settings
;; Requires Roboto nerd font
;; (load-theme 'nano-dark t)
;; (nano-setup)

(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs t
      modus-themes-mixed-fonts t
      modus-themes-subtle-line-numbers t
      modus-themes-intense-markup nil
      modus-themes-deuteranopia nil
      modus-themes-tabs-accented t
      modus-themes-variable-pitch-ui t
      modus-themes-inhibit-reload t ; only applies to `customize-set-variable' and related

      ;; modus-themes-fringes 'subtle  ; {nil,'subtle,'intense}

      ;; Options for `modus-themes-lang-checkers' are either nil (the
      ;; default), or a list of properties that may include any of those
      ;; symbols: `straight-underline', `text-also', `background',
      ;; `intense' OR `faint'.
      modus-themes-lang-checkers (quote (faint text-also background))

      ;; Options for `modus-themes-mode-line' are either nil, or a list
      ;; that can combine any of `3d' OR `moody', `borderless',
      ;; `accented', and a natural number for extra padding
      modus-themes-mode-line '(borderless)

      ;; Options for `modus-themes-syntax' are either nil (the default),
      ;; or a list of properties that may include any of those symbols:
      ;; `faint', `yellow-comments', `green-strings', `alt-syntax'
      ;; modus-themes-syntax '(alt-syntax green-strings yellow-comments)
      modus-themes-syntax nil

      ;; Options for `modus-themes-hl-line' are either nil (the default),
      ;; or a list of properties that may include any of those symbols:
      ;; `accented', `underline', `intense'
      ;; modus-themes-hl-line '(underlined)
      modus-themes-hl-line nil

      ;; Options for `modus-themes-paren-match' are either nil (the
      ;; default), or a list of properties that may include any of those
      ;; symbols: `bold', `intense', `underline'
      modus-themes-paren-match '(intense underline)

      ;; Options for `modus-themes-links' are either nil (the default),
      ;; or a list of properties that may include any of those symbols:
      ;; `neutral-underline' OR `no-underline', `faint' OR `no-color',
      ;; `bold', `italic', `background'
      modus-themes-links '(neutral-underline background)

      ;; Options for `modus-themes-prompts' are either nil (the
      ;; default), or a list of properties that may include any of those
      ;; symbols: `background', `bold', `gray', `intense', `italic'
      modus-themes-prompts '(intense bold)

      ;; modus-themes-completions 'moderate ; {nil,'moderate,'opinionated}

      modus-themes-mail-citations nil ; {nil,'faint,'monochrome}

      ;; Options for `modus-themes-region' are either nil (the default),
      ;; or a list of properties that may include any of those symbols:
      ;; `no-extend', `bg-only', `accented'
      modus-themes-region '(bg-only no-extend)

      ;; Options for `modus-themes-diffs': nil, 'desaturated, 'bg-only
      modus-themes-diffs 'desaturated

      modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

      modus-themes-org-agenda ; this is an alist: read the manual or its doc string
      '((header-block . (variable-pitch 1.3))
        (header-date . (grayscale workaholic bold-today 1.1))
        (event . (accented varied))
        (scheduled . uniform)
        (habit . traffic-light))

      modus-themes-headings ; this is an alist: read the manual or its doc string
      '((1 . (rainbow))
        (2 . (rainbow))
        (3 . (rainbow))
        (4 . (rainbow))
        (5 . (rainbow))
        (6 . (rainbow))
        (7 . (rainbow))
        (8 . (rainbow))
        (t . (semibold))))

(load-theme 'modus-vivendi :no-confirm)
;; (load-theme 'modus-vivendi-tinted :no-confirm)
;; (modus-themes-load-vivendi) ;; OR (modus-themes-load-operandi)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq confirm-kill-emacs nil)

(setq-default tab-width 2)
(setq-default evil-shift-width tab-width)

(setq scroll-margin 3)

(setq-default indent-tabs-mode nil)

(setq doom-modeline-height 16
      doom-modeline-bar-width 6
      doom-modeline-lsp t
      doom-modeline-github t
      doom-modeline-env-version t
      doom-modeline-mu4e nil
      doom-modeline-irc nil
      doom-modeline-minor-modes nil
      doom-modeline-persp-name t
      doom-modeline-buffer-encoding t
      doom-modeline-indent-info t
      doom-modeline-buffer-file-name-style 'truncate-except-project
      doom-modeline-major-mode-icon t)

;; (nano-modeline-mode)

(setq prettify-symbols-unprettify-at-point 'right-edge)
(setq web-mode-prettify-symbols-alist
      '(
        ("&&"       . "∧")
        ("||"       . "∨")
        ("() =>"    . "▶")
        ("=>"       . "▷")
        ("const"    . "ɣ")
        ("export"   . "↗")
        ("from"     . "←")
        ("function" . "⌿")
        ("import"   . "◀")
        ("props"    . "θ")
        ("return"   . "⤾")
        ("false"    . "╳")
        ("true"     . "✓")
        ("React"     . "Ω")
        ("private"     . "ϼ")
        ("public"     . "ρ")
        ("this"     . "τ")
        ))
;; (global-prettify-symbols-mode +1)

(global-auto-revert-mode 1)

(setq
      company-backend                   'company-capf
      lsp-auto-configure                t
      lsp-completion-enable             t
      lsp-completion-provider           :capf
      lsp-completion-show-kind          t
      lsp-diagnostics-provider          :flymake
      lsp-enable-folding                t
      lsp-enable-indentation            nil
      lsp-enable-on-type-formatting     nil
      lsp-enable-snippet                t
      lsp-enable-symbol-highlighting    t
      lsp-enable-text-document-color    t
      lsp-enable-which-key-integration  t
      lsp-headerline-breadcrumb-enable  t
      lsp-keymap-prefix                 "C-c l"
      lsp-lens-enable                   t
      lsp-log-io                        nil  ;; dont log everything = speed
      lsp-restart                       'auto-restart
      lsp-typescript-format-enable      nil
      lsp-javascript-format-enable      nil
      +format-with-lsp                  nil  ;; disable auto-formatting using lsp, causing issues in lsp-mode
      lsp-eslint-enable                 t
      lsp-eslint-auto-fix-on-save       t
      )

(setq
      lsp-ui-doc-enable                 t
      lsp-ui-doc-position               'bottom
      lsp-ui-doc-show-with-cursor       nil
      lsp-ui-peek-enable                t
      lsp-ui-sideline-delay             0.1
      lsp-ui-sideline-enable            t
      lsp-ui-sideline-ignore-duplicate  t
      lsp-ui-sideline-show-code-actions t
      lsp-ui-sideline-show-diagnostics  t
      lsp-ui-sideline-show-hover        t
      lsp-ui-sideline-show-symbol       t)

(setq lsp-tailwindcss-add-on-mode t)

(add-hook 'web-mode-hook #'lsp-deferred)

(with-eval-after-load 'lsp-mode
                      (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.venv\\'")
                      (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.mypy_cache\\'")
                      (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]node_modules\\'"))

;; (add-hook 'company-mode-hook 'company-box-mode)

;; NOTE: Install prettier globally
;; `npm install -g prettier`
`(setq prettier-js-args '(
                          "--no-semi"
                          "--bracket-same-line" "false"
                          "--arrow-parens" "avoid"
                          "--trailing-comma" "es5"
                          "--bracket-spacing" "false"
                          ))
;; (add-hook 'json-mode-hook 'prettier-js-mode)
;; (add-hook 'js2-mode-hook 'prettier-js-mode)
;; (add-hook 'web-mode-hook 'prettier-js-mode)
;; (add-hook 'Typescript-TSX-mode-hook 'prettier-js-mode)

(setq yas-snippet-dirs
      '(
        "~/.emacs.snippets"                 ;; personal snippets
        ))

(global-set-key (kbd "C-c y") 'company-yasnippet)

;; Alignment macros
(fset 'arnd/align-to-colon
      (kmacro-lambda-form
       [?  ?u ?\M-x ?a ?l ?i ?g ?n ?- ?r ?e ?g ?e ?x ?p return ?: return return return ?y] 0 "%d"))
(fset 'arnd/align-to-equal
      (kmacro-lambda-form
       [?  ?u ?\M-x ?a ?l ?i ?g ?n ?- ?r ?e ?g ?e ?x ?p return ?= return return return ?y] 0 "%d"))
(fset 'arnd/align-to-period
      (kmacro-lambda-form
       [?  ?u ?\M-x ?a ?l ?i ?g ?n ?- ?r ?e ?g ?e ?x ?p return ?. return return return ?y] 0 "%d"))
(fset 'arnd/align-to-space
      (kmacro-lambda-form
       [?  ?u ?\M-x ?a ?l ?i ?g ?n ?- ?r ?e ?g ?e ?x ?p return ?  return return return ?y] 0 "%d"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/OrgNotes/")

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
  (add-to-list 'org-structure-template-alist '("mk" . "src markdown")))

(setq frame-title-format "%b \- AR&D")

(setq org-roam-directory (file-truename "~/OrgRoam"))

(use-package! org-roam
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(defun arnd/capitalize-first-char (&optional string)
  "Capitalize only the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string nil 1))
          (rest-str   (substring string 1)))
      (concat (capitalize first-char) rest-str))))
