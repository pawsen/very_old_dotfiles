 ;; cedet
(require 'semantic)
(require 'semantic/sb)
(require 'srecode)

;;(global-ede-mode 1)
;;(global-ede-mode 'nil)

;; setup minor mode
(global-semanticdb-minor-mode 1)
(global-semantic-idle-summary-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-idle-completions-mode 1)
(global-semantic-decoration-mode 1)
(global-semantic-highlight-func-mode 1)
(global-semantic-stickyfunc-mode -1)
(global-semantic-mru-bookmark-mode 1)
(semantic-mode 1)


(global-semantic-highlight-edits-mode (if window-system 1 -1))
(global-semantic-show-unmatched-syntax-mode 1)
(global-semantic-show-parser-state-mode 1)

(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
(set-default 'semantic-case-fold t)

(defun semantic-ia-fast-jump-or-back (&optional back)
 (interactive "P")
 (if back
     (semantic-ia-fast-jump-back)
   (semantic-ia-fast-jump (point))))
(define-key semantic-mode-map [C-f12] 'semantic-ia-fast-jump-or-back)
(define-key semantic-mode-map [M-S-f12] 'semantic-analyze-proto-impl-toggle)


(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  ;; code folding virker ikke
  ;;(local-set-key "\C-c+" 'semantic-tag-folding-show-block)
  ;;(local-set-key "\C-c-" 'semantic-tag-folding-fold-block)
  ;;(local-set-key "\C-c\C-c+" 'semantic-tag-folding-show-all)
  ;;(local-set-key "\C-c\C-c-" 'semantic-tag-folding-fold-all)
  )
(add-hook 'c-mode-common-hook 'my-cedet-hook)
