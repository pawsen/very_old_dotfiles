;; Compilation
(setq compilation-ask-about-save nil) ;; dont ask about save - just do it
(setq compilation-scroll-output 1) ;; automatically scroll the compilation window
(setq compilation-window-height 10) ;; Set the compilation window height...
(setq compilation-finish-function ;; Auto-dismiss compilation buffer...
      (lambda (buf str)
        (if (string-match "exited abnormally" str)
	    (message "compilation errors, press F8 to visit")
	  (progn
	    ;;(run-at-time 2.5 nil 'delete-windows-on buf) ; no errors, delete the compilation window
	    (run-at-time 2.5 nil 'winner-undo); set windows back to configuration before compilation
	    (message "No compilation errors!")))
	))

;; (setq compilation-finish-function ;; Auto-dismiss compilation buffer...
;;       (lambda (buf str)
;;         (if (string-match "exited abnormally" str)
;;             (message "compilation errors, press F6 to visit"
;; 	    ; no errors, make the compilation window go away after 10 sec
;; 	   (run-at-time 2.5 nil 'delete-windows-on buf))
     
;;           (message "No compilation errors!")))

(require 'cl) ; If you don't have it already
(defun* get-closest-pathname (&optional (file "Makefile"))
  "This function walks up the current path until it finds Makefile and then retu
rns the path to it."
  (let ((root (expand-file-name "/")))
    (expand-file-name file
              (loop
            for d = default-directory then (expand-file-name ".." d)
            if (file-exists-p (expand-file-name file d))
            return d
            if (equal d root)
           return nil))))

(defun my-compile-func ()
  "This function does a compile."
  (interactive)
  (compile (format "make -C %s" (file-name-directory (get-closest-pathname)))))

(defun my-compile-clean-func ()
  "This function does a clean compile."
  (interactive)
  (compile (format "make -C %s clean" (file-name-directory (get-closest-pathname)))))

(defun my-compile-upload-func ()
  "This function does a clean compile."
  (interactive)
  (compile (format "make -C %s upload" (file-name-directory (get-closest-pathname)))))

(defun my-compile-package-func ()
  "This function builds an Endura package."
  (interactive)
  (compile (format "make -C %s package" (file-name-directory (get-closest-pathname)))))

