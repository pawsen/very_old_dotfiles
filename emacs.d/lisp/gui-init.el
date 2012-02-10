;;  File to set up the GUI of emacs. Paw

(setq frame-title-format '(buffer-file-name "%f" ("%b")))
;; set frame title - http://emacs-fu.blogspot.com/2011/01/setting-frame-title.html
; SHow both system-name and full path of file
;(setq frame-title-format
;      (list (format "%s %%S: %%j " (system-name))
;        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

(tooltip-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

(defun paw-font-small ()
  (interactive)
;; put ting der har med small-font at gøre her. Fx:
   ;(setq default-frame-alist '((font-backend . "xft")(font . "Inconsolata-08") 
   ;       (vertical-scroll-bars . 0) (menu-bar-lines . 0) (tool-bar-lines . 0)
   ;       (left-fringe . 1) (right-fringe . 1)
   ;       (alpha 86 84)))
   ; (tool-bar-mode -1)
   ; (scroll-bar-mode -1)
)

; så kan funktionen loades med fx.(i init.el)
;(if (string-match "laptop" system-name)
;      (paw-font-small))


(provide 'gui-init)
