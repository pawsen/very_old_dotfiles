;; Load auxtex og preview-latex el-filer. Det er kun nødvendigt når disse ikke ligger "site-start.d/". Filerne skal satdig ligge i load-path. Fx "site-start".
					;(load "auctex.el" nil t t)
					;(load "preview-latex.el" nil t t)

;; Dette er for at være helt sikker på at der bruges et dansk tegnsæt.
(set-language-environment "latin-1")

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

;; make RefTex faster
(setq reftex-enable-partial-scans t) 
(setq reftex-save-parse-info t) 
(setq reftex-use-multiple-selection-buffers t) 
(setq reftex-plug-into-AUCTeX t)

;; math-mode in LaTeX 
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode) ;; Slår auctex til i emacs

;; AUCTeX multi file handling 
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
(setq TeX-save-query nil)  ;; autosave before compiling
(setq-default TeX-master nil) ;; Spørg efter master 
(setq reftex-label-alist '(AMSTeX));; Tving reftex til at bruge \eqref ved ligninger.
(setq-default TeX-PDF-mode t) ;; Use PDF mode by default
(setq TeX-electric-sub-and-superscript t);;Inserts {} automaticly on _ and ^
(setq reftex-cite-format (quote natbib))

;; ændre dictionary automatisk. Tvivlsomt om virker
;;(add-hook 'TeX-language-dk-hook
;;          (function (lambda () (ispell-change-dictionary "da_DK_hunspell"))))


;; For inverse search
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-source-correlate-method 'synctex)

;; Brug autocomplete sammen med LaTex. http://code.google.com/p/ac-math/
(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of {{{latex-mode}}}
(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
	(append '(ac-source-math-latex ac-source-latex-commands  ac-source-math-unicode)
		ac-sources)))
(add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)

;; path to pdf-reader ; se http://www.bleedingmind.com/index.php/2010/06/17/synctex-on-linux-and-mac-os-x-with-emacs/ og http://mathieu.3maisons.org/wordpress/how-to-configure-emacs-and-auctex-to-work-with-a-pdf-viewer
(setq TeX-view-program-list '(
			      ;("SumatraPDF" "x:\\emacs\\SumatraPDF\\SumatraPDF.exe %o")  ; for dtu-maskine
			      ("SumatraPDF" "%HOME%\\emacs\\SumatraPDF\\SumatraPDF.exe %o") ; for hjemme-windows maskine
			      ("Evince" "evince --page-index=%(outpage) %o"))
      )

(when (windows-p)
  ;; inverse search - http://william.famille-blum.org/blog/index.php?entry=entry080515-065447
  (require 'sumatra-forward)
  (setq TeX-view-program-selection '((output-pdf "SumatraPDF")))
  ;; %HOME%\emacs\emacs\bin\emacsclientw.exe +%l "%f"
  )

(when (linux-p)
 
 ;; Okularokular --unique %o#src:%n%b
(setq TeX-view-program-list '(("okular --unique %o#src:%n%b")))
(add-hook 'LaTeX-mode-hook '(lambda ()
                   (add-to-list 'TeX-expand-list
                        '("%u" Okular-make-url))))
(defun Okular-make-url () (concat
                "file://"
                (expand-file-name (funcall file (TeX-output-extension) t)
                          (file-name-directory (TeX-master-file)))
                "#src:"
                (TeX-current-line)
                (expand-file-name (TeX-master-directory))
                "./"
                (TeX-current-file-name-master-relative)))
(setq TeX-view-program-selection '((output-pdf "Okular")))
)


;; (when (and (= emacs-major-version 21) (= emacs-minor-version 1) (equal window-system 'w32))
;; ;; Forward/inverse search with evince using D-bus.
;; (if (require 'dbus "dbus" t)
;;     (progn
;;       ;; Forward search.
;;       ;; Adapted from http://dud.inf.tu-dresden.de/~ben/evince_synctex.tar.gz
;;       (defun auctex-evince-forward-sync (pdffile texfile line)
;; 	(let* ((dbus-name
;; 		(dbus-call-method :session
;; 				  "org.gnome.evince.Daemon"  ; service
;; 				  "/org/gnome/evince/Daemon" ; path
;; 				  "org.gnome.evince.Daemon"  ; interface
;; 				  "FindDocument"
;; 				  (concat "file://" pdffile)
;; 				  t         ; Open a new window if the file is not opened.
;; 				  ))
;; 	       (time (current-time))
;; 	       (high (car time))
;; 	       (low (cadr time))
;; 	       (timestamp (+ (* high (expt 2 16)) low)))

;;           (dbus-call-method :session
;;                 dbus-name
;;                 "/org/gnome/evince/Window/0"
;;                 "org.gnome.evince.Window"
;;                 "SyncView"
;;                 texfile
;;                                (list :struct :int32 line :int32 1)
;;                                timestamp)))
 

;;       (defun auctex-evince-view ()
;;         (let ((pdf (file-truename (concat default-directory
;;                           (TeX-master-file (TeX-output-extension)))))
;;           (tex (buffer-file-name))
;;           (line (line-number-at-pos)))
;;           (auctex-evince-forward-sync pdf tex line)))

;;       ;; New view entry: Evince via D-bus.
;;       (add-to-list 'TeX-view-program-list
;;                '("EvinceDbus" auctex-evince-view))

;;       ;; Prepend Evince via D-bus to program selection list
;;       ;; overriding other settings for PDF viewing.
;;       (add-to-list 'TeX-view-program-selection
;;                '(output-pdf "EvinceDbus"))

;;       ;; Inverse search.
;;       ;; Adapted from: http://www.mail-archive.com/auctex@gnu.org/msg04175.html 
;; 	(defun auctex-evince-inverse-sync (file linecol timestamp)
;;         (let ((buf (get-buffer (file-name-nondirectory file)))
;;           (line (car linecol))
;;           (col (cadr linecol)))
;;           (if (null buf)
;;           (message "Sorry, %s is not opened..." file)
;;         (switch-to-buffer buf)
;;         (goto-line (car linecol))
;;         (unless (= col -1)
;;           (move-to-column col)))))

;;       (dbus-register-signal
;;        :session nil "/org/gnome/evince/Window/0"
;;        "org.gnome.evince.Window" "SyncSource"
;;        'auctex-evince-inverse-sync)))

;;   )

(custom-set-variables
 '(LaTeX-command "latex -synctex=1")
 '(LaTeX-float "htb")
 )
