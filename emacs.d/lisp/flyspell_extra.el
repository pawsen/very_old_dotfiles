
;; Make a symbol when a word is spelled wrong.

(defcustom flyspell-before-incorrect-word-string nil
   "String used to indicate an incorrect word."
   ;; If this is set to a string, the string persists in the buffer if
   ;; flyspell-auto-correct-word is called. It persists until
   ;; flyspell-delete-overlays is called.
   :group 'flyspell
   :type 'string)
 (defcustom flyspell-after-incorrect-word-string "<-"
   "String used to indicate an incorrect word."
   :group 'flyspell
   :type 'string)
 (defun make-flyspell-overlay (beg end face mouse-face)
   "Allocate an overlay to highlight an incorrect word.
 BEG and END specify the range in the buffer of that word.
 FACE and MOUSE-FACE specify the `face' and `mouse-face' properties
 for the overlay."
   (let ((flyspell-overlay (make-overlay beg end nil t nil)))
     (overlay-put flyspell-overlay 'face face)
     (overlay-put flyspell-overlay 'mouse-face mouse-face)
     (overlay-put flyspell-overlay 'flyspell-overlay t)
     (if flyspell-use-local-map
         (overlay-put flyspell-overlay
                      flyspell-overlay-keymap-property-name
                      flyspell-mouse-map))
     (when (eq face 'flyspell-incorrect-face)
       (and (stringp flyspell-before-incorrect-word-string)
            (overlay-put flyspell-overlay 'before-string
                         flyspell-before-incorrect-word-string))
       (and (stringp flyspell-after-incorrect-word-string)
            (overlay-put flyspell-overlay 'after-string
                         flyspell-after-incorrect-word-string)))
     flyspell-overlay))

(provide 'flyspell_extra)
