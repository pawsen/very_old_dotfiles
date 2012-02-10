<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: sunrise-x-buttons.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=sunrise-x-buttons.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: sunrise-x-buttons.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=sunrise-x-buttons.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for sunrise-x-buttons.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=sunrise-x-buttons.el" />
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-2101513-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/></head><body class="http://www.emacswiki.org/emacs"><div class="header"><a class="logo" href="http://www.emacswiki.org/emacs/SiteMap"><img class="logo" src="/emacs_logo.png" alt="[Home]" /></a><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/Glossary">Glossary</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span>
<!-- Google CSE Search Box Begins  -->
<form class="tiny" action="http://www.google.com/cse" id="searchbox_004774160799092323420:6-ff2s0o6yi"><p>
<input type="hidden" name="cx" value="004774160799092323420:6-ff2s0o6yi" />
<input type="text" name="q" size="25" />
<input type="submit" name="sa" value="Search" />
</p></form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=searchbox_004774160799092323420%3A6-ff2s0o6yi"></script>
<!-- Google CSE Search Box Ends -->
<br /><span class="specialdays">Uganda, Independence Day</span><h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22sunrise-x-buttons.el%22">sunrise-x-buttons.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="http://www.emacswiki.org/emacs/download/sunrise-x-buttons.el">Download</a></p><pre class="code"><span class="linecomment">;;; sunrise-x-buttons.el --- mouse-clickable shortcut buttons for the Sunrise Commander File Manager</span>

<span class="linecomment">;; Copyright (C) 2008-2010 José Alfredo Romero Latouche.</span>

<span class="linecomment">;; Author: José Alfredo Romero L. &lt;escherdragon@gmail.com&gt;</span>
<span class="linecomment">;;	Štěpán Němec &lt;stepnem@gmail.com&gt;</span>
<span class="linecomment">;; Maintainer: José Alfredo Romero L. &lt;escherdragon@gmail.com&gt;</span>
<span class="linecomment">;; Created: 11 Jun 2008</span>
<span class="linecomment">;; Version: 1</span>
<span class="linecomment">;; RCS Version: $Rev: 374 $</span>
<span class="linecomment">;; Keywords: sunrise commander, shortcut buttons</span>
<span class="linecomment">;; URL: http://www.emacswiki.org/emacs/sunrise-x-buttons.el</span>
<span class="linecomment">;; Compatibility: GNU Emacs 22+</span>

<span class="linecomment">;; This file is *NOT* part of GNU Emacs.</span>

<span class="linecomment">;; This program is free software: you can redistribute it and/or modify it under</span>
<span class="linecomment">;; the terms of the GNU General Public License as published by the Free Software</span>
<span class="linecomment">;; Foundation,  either  version  3 of the License, or (at your option) any later</span>
<span class="linecomment">;; version.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; This  program  is distributed in the hope that it will be useful, but WITHOUT</span>
<span class="linecomment">;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS</span>
<span class="linecomment">;; FOR  A  PARTICULAR  PURPOSE.  See the GNU General Public License for more de-</span>
<span class="linecomment">;; tails.</span>

<span class="linecomment">;; You  should have received a copy of the GNU General Public License along with</span>
<span class="linecomment">;; this program. If not, see &lt;http://www.gnu.org/licenses/&gt;.</span>

<span class="linecomment">;;; Commentary:</span>

<span class="linecomment">;; Here is a small extension that may be of help to new users who want to get</span>
<span class="linecomment">;; acquainted fast with the most frequent functions found in the Sunrise</span>
<span class="linecomment">;; Commander and their keybindings. Once installed, it displays a panel with</span>
<span class="linecomment">;; mouse clickable buttons that show some of the most useful actions performed</span>
<span class="linecomment">;; by Sunrise and their respective bindings in the bottom window (a.k.a. viewer</span>
<span class="linecomment">;; window here) every time the main panels are invoked. You can execute any of</span>
<span class="linecomment">;; these functions by clicking the appropriate button, but the extension was</span>
<span class="linecomment">;; conceived more as a simple cheat sheet (a very, very limited one, as you can</span>
<span class="linecomment">;; easily learn by pressing the last button, labeled "More...") than as a real</span>
<span class="linecomment">;; interface to Sunrise and Dired functions. Eventually, if you like this kind</span>
<span class="linecomment">;; of interaction with the program you can add your own commands to the list and</span>
<span class="linecomment">;; let this extension manage the creation and layout of the buttons for you.</span>

<span class="linecomment">;; This is version 1 $Rev: 374 $ of the Sunrise Commander Buttons Extension.</span>

<span class="linecomment">;; It was written on GNU Emacs 23 on Linux, and tested on GNU Emacs 22 and 23</span>
<span class="linecomment">;; for Linux and on EmacsW32 (version 22) for Windows.</span>

<span class="linecomment">;;; Installation and Usage:</span>

<span class="linecomment">;; 1) Put this file somewhere in your Emacs `load-path'.</span>

<span class="linecomment">;; 2) Add a (require 'sunrise-x-buttons) to your .emacs file, preferably right</span>
<span class="linecomment">;; after (require 'sunrise-commander).</span>

<span class="linecomment">;; 3) Evaluate the new expression, or reload your .emacs file, or restart Emacs.</span>

<span class="linecomment">;; That's it - the next time you activate Sunrise you'll see a nice button panel</span>
<span class="linecomment">;; in the viewer window.</span>

<span class="linecomment">;;; Code:</span>

(require 'sunrise-commander)
(eval-when-compile (require 'cl))
(eval-when-compile (require 'cus-edit))

(defvar sr-buttons-buffer-name "<span class="quote">*Sunrise Buttons*</span>"
  "<span class="quote">Name of the Sunrise buttons buffer</span>")

(defvar sr-buttons-command-adapter nil
  "<span class="quote">Function to use to execute button commands, or nil to do the default.</span>")

(defvar sr-buttons-list
  '(
    ("<span class="quote">GotoDir([F2,]j,/)</span>" 'sr-goto-dir                "<span class="quote">Go to any directory in active pane</span>")
    ("<span class="quote">View([F3,]v,o)</span>"    'sr-quick-view              "<span class="quote">View selected file or directory in this window</span>")
    ("<span class="quote">Open([F4,]Enter)</span>"  'sr-advertised-find-file    "<span class="quote">Visit selected file or directory</span>")
    ("<span class="quote">Copy([F5,]C)</span>"      'sr-do-copy                 "<span class="quote">Copy selected files to passive pane</span>")
    ("<span class="quote">Rename([F6,]R)</span>"    'sr-do-rename               "<span class="quote">Move selected files to passive pane</span>")
    ("<span class="quote">Clone(K)</span>"          'sr-do-clone                "<span class="quote">Clone selected files to passive pane</span>")
    ("<span class="quote">NewDir([F7,]+)</span>"    'dired-create-directory     "<span class="quote">Create new directory in active pane</span>")
    ("<span class="quote">Delete([F8,]D)</span>"    'sr-do-delete               "<span class="quote">Delete selected files from active pane</span>")
    nil
    ("<span class="quote">DirUp([C-PgUp,]J)</span>" 'sr-dired-prev-subdir       "<span class="quote">Go to parent directory in active pane</span>")
    ("<span class="quote">DirBack(M-y)</span>"      'sr-history-prev            "<span class="quote">Go to previous directory in history</span>")
    ("<span class="quote">DirFrwd(M-u)</span>"      'sr-history-next            "<span class="quote">Go to next directory in history</span>")
    ("<span class="quote">HardLink(H)</span>"       'sr-do-hardlink             "<span class="quote">Make hard link of selected file in passive pane</span>")
    ("<span class="quote">SymLink(S)</span>"        'sr-do-symlink              "<span class="quote">Make absolute symlink of selected entry in passive pane</span>")
    ("<span class="quote">RelSymLink(Y)</span>"     'sr-do-relsymlink           "<span class="quote">Make relative symlink of selected entry in passive pane</span>")
    ("<span class="quote">Hidden(C-o)</span>"       'sr-omit-mode               "<span class="quote">Hide/Show hidden files in active pane</span>")
    ("<span class="quote">Attrs(C-Bksp)</span>"     'sr-toggle-attributes       "<span class="quote">Hide/Show file attributes in active pane</span>")
    nil
    ("<span class="quote">Other(Tab)</span>"        'sr-change-window           "<span class="quote">Switch to passive pane</span>")
    ("<span class="quote">ClonePane(M-o)</span>"    'sr-synchronize-panes       "<span class="quote">Make both panes contain the same directory</span>")
    ("<span class="quote">Swap(M-t)</span>"         'sr-transpose-panes         "<span class="quote">Transpose panes</span>")
    ("<span class="quote">Refresh(g)</span>"        'revert-buffer              "<span class="quote">Rescan directory in active pane</span>")
    ("<span class="quote">Align(C-cC-s)</span>"     'sr-split-toggle            "<span class="quote">Change panes alignment (vertical/horizontal/top)</span>")
    ("<span class="quote">Sort(s)</span>"           'sr-interactive-sort        "<span class="quote">Sort interactively entries in active pane</span>")
    ("<span class="quote">Mark([Ins,]m)</span>"     'dired-mark                 "<span class="quote">Mark selected entry in active pane</span>")
    ("<span class="quote">Unmark(Bksp)</span>"      'dired-unmark-backward      "<span class="quote">Unmark last selected entry inactive pane</span>")
    nil
    ("<span class="quote">History(C-cC-d)</span>"   'sr-recent-directories      "<span class="quote">Display listing of recently visited directories</span>")
    ("<span class="quote">Recent(C-cC-r)</span>"    'sr-recent-files            "<span class="quote">Display listing of recently visited files</span>")
    ("<span class="quote">Restore(C-cC-c)</span>"   'sr-buttons-restore-mode    "<span class="quote">Dismiss VIRTUAL or WDired mode</span>")
    ("<span class="quote">Find(C-cC-f)</span>"      'sr-find                    "<span class="quote">Find files and directories interactively</span>")
    ("<span class="quote">FName(C-cC-n)</span>"     'sr-find-name               "<span class="quote">Find files and directories by name pattern</span>")
    ("<span class="quote">FGrep(C-cC-g)</span>"     'sr-find-grep               "<span class="quote">Find files containing some expression</span>")
    ("<span class="quote">Follow(;)</span>"         'sr-follow-file             "<span class="quote">Follow file (go to same directory as file)</span>")
    ("<span class="quote">Locate(C-cC-l)</span>"    'sr-locate                  "<span class="quote">Find files and directories using locate database</span>")
    nil
    ("<span class="quote">Search(A)</span>"         'sr-do-search               "<span class="quote">Search for string/regexp in all marked entries</span>")
    ("<span class="quote">Compare(C-M-=)</span>"    'sr-compare-dirs            "<span class="quote">Compare directories in panes</span>")
    ("<span class="quote">Diff(=)</span>"           'sr-diff                    "<span class="quote">Compare selected entries using diff</span>")
    ("<span class="quote">Ediff(C-=)</span>"        'sr-ediff                   "<span class="quote">Compare selected entries using ediff</span>")
    ("<span class="quote">Store(C-c&gt;)</span>"       'sr-checkpoint-save         "<span class="quote">Remember current position of panes as name</span>")
    ("<span class="quote">Recall(C-c.)</span>"      'sr-checkpoint-restore      "<span class="quote">Set panes to a previously remembered position</span>")
    ("<span class="quote">Home(M-a)</span>"         'sr-beginning-of-buffer     "<span class="quote">Go to first entry in active pane</span>")
    ("<span class="quote">End(M-e)</span>"          'sr-end-of-buffer           "<span class="quote">Go to last entry in active pane</span>")
    nil
    ("<span class="quote">FindReplace(Q)</span>"    'sr-do-query-replace-regexp "<span class="quote">Find and replace in all selected entries</span>")
    ("<span class="quote">Fuzzy(C-c/)</span>"       'sr-fuzzy-narrow            "<span class="quote">Narrow pane contents with fuzzy matching</span>")
    ("<span class="quote">CmdLine(C-ct)</span>"     'sr-term                    "<span class="quote">Open Command line in this window</span>")
    ("<span class="quote">WDired(C-xC-q)</span>"    'sr-buttons-editable-pane   "<span class="quote">Edit active pane using wdired</span>")
    ("<span class="quote">SyncNav(C-cC-z)</span>"   'sr-sync                    "<span class="quote">Toggle on/off synchronized navigation mode</span>")
    ("<span class="quote">LongLines(M-l)</span>"    'sr-toggle-truncate-lines   "<span class="quote">Truncate/Restore long lines in active pane</span>")
    ("<span class="quote">More...(h)</span>"        'sr-describe-mode           "<span class="quote">More commands and keybindings</span>")
    ("<span class="quote">Quit([F10,]q)</span>"     'keyboard-escape-quit       "<span class="quote">Dismiss Sunrise Commander</span>")
    )
  "<span class="quote">Sunrise button definitions.</span>")


(define-derived-mode sr-buttons-mode custom-mode "<span class="quote">Sunrise Buttons</span>"
  "<span class="quote">Sunrise Commander Buttons panel mode.</span>"
  :group 'sunrise
  (set-keymap-parent sr-buttons-mode-map custom-mode-map)

  (make-local-variable 'double-click-time)
  (setq double-click-time nil)
  (make-local-variable 'double-click-fuzz)
  (setq double-click-fuzz 0)

  (defun sr-buttons-click ()
    "<span class="quote">Handle all click events that take place in the buttons buffer.</span>"
    (interactive)
    (unwind-protect
        (call-interactively 'widget-button-click)
      (sr-select-window sr-selected-window)))

  (mapc (lambda (x) (define-key sr-buttons-mode-map x 'sr-buttons-click))
        '([down-mouse-1] [down-mouse-2] [down-mouse-3]))

  (mapc (lambda (x) (define-key sr-buttons-mode-map x
                      (lambda () (interactive)
                        (sr-select-window sr-selected-window))))
        '([(control tab)] "<span class="quote">\C-c\t</span>"
          [mouse-1]             [mouse-2]             [mouse-3]
          [drag-mouse-1]        [drag-mouse-2]        [drag-mouse-3]
          [double-mouse-1]      [double-mouse-2]      [double-mouse-3]
          [triple-mouse-1]      [triple-mouse-2]      [triple-mouse-3]
          [double-drag-mouse-1] [double-drag-mouse-2] [double-drag-mouse-3]
          [triple-drag-mouse-1] [triple-drag-mouse-2] [triple-drag-mouse-3]
          [double-down-mouse-1] [double-down-mouse-2] [double-down-mouse-3]
          [triple-down-mouse-1] [triple-down-mouse-2] [triple-down-mouse-3])))

(add-hook 'sr-start-hook 'sr-buttons-display)
(add-hook 'sr-quit-hook (lambda ()
                          (bury-buffer (get-buffer sr-buttons-buffer-name))))
(add-hook 'kill-buffer-hook
          (lambda ()
            (if (and sr-running
                     (eq (current-buffer) other-window-scroll-buffer))
                (sr-buttons-display))))

(defun sr-buttons-display ()
  "<span class="quote">Display the buttons buffer in the viewer window.
If no buttons buffer exists yet, creates one.</span>"
  (apply 'require '(cus-edit))
  (sr-select-viewer-window t)
  (cond ((buffer-live-p other-window-scroll-buffer) <span class="linecomment">;;&lt;-- don't nuke quick views!</span>
         (switch-to-buffer other-window-scroll-buffer))
        ((get-buffer "<span class="quote">*terminal*</span>")                  <span class="linecomment">;;&lt;-- prefer terminals</span>
         (switch-to-buffer "<span class="quote">*terminal*</span>"))
        (t
         (switch-to-buffer sr-buttons-buffer-name)
         (setq truncate-lines t)
         (setq line-spacing 5)
         (setq cursor-in-non-selected-windows nil)
         (if (not (eq major-mode 'sr-buttons-mode))
             (let ((line-spacing 2)
                   (cursor-in-non-selected-windows nil))
               (sr-buttons-render)
               (toggle-read-only)))))
  (sr-select-window sr-selected-window))

(defun sr-buttons-render ()
  "<span class="quote">Populate current buffer with all widgets described in `sr-buttons-list'.</span>"
  (sr-buttons-mode)
  (let ((mc-keys-on (sr-buttons-mc-keys-p))
        (maxlen (sr-buttons-maxtaglen)))
    (mapc (lambda (x) (sr-buttons-build x mc-keys-on maxlen)) sr-buttons-list))
  (sr-buttons-eol)
  (goto-char (point-min)))

(defun sr-buttons-build (spec mc-keys-on maxlen)
  "<span class="quote">Build and render a new widget in the buttons buffer.
The first argument is an element of `sr-buttons-list' (list
containing tag, action and hint), the second one is a flag that
indicates whether mc style keybindings have been activated in
Sunrise, and the last one is the length of the longest tag in the
list.</span>"
  (if (or (null spec)
          (&gt; (+ (current-column) maxlen) (- (window-width) (/ maxlen 2))))
      (sr-buttons-eol)
    (let ((tag (first spec))
          (action (second spec))
          (hint (third spec)))
      (if mc-keys-on
          (setq tag (replace-regexp-in-string "<span class="quote">\\[\\|\\]</span>" "<span class="quote"></span>" tag))
        (setq tag (replace-regexp-in-string "<span class="quote">\\[.*\\]</span>" "<span class="quote"></span>" tag)))
      (setq tag (sr-buttons-normalize-tag tag maxlen ? ))
      (widget-create 'push-button :tag tag
                                  :action (sr-buttons-action action)
                                  :help-echo hint)
      (insert-char ?  1)
      (put-text-property
       (1- (point)) (point) 'display (list 'space :width 0.15)))))

(defun sr-buttons-eol ()
  "<span class="quote">Terminate the current row of buttons while building the buttons buffer.
Centers it if necessary.</span>"
  (let* ((gap (- (window-width) (current-column) 2))
         (margin (/ gap 2)))
    (if (&gt; margin 0)
        (save-excursion (beginning-of-line) (insert-char ?  margin)))
    (unless (eq ?\n (char-before)) (insert "<span class="quote">\n</span>"))))

(defun sr-buttons-mc-keys-p ()
  "<span class="quote">Determine whether mc-style keybindings have been activated in Sunrise.</span>"
  (eq 'sr-goto-dir (cdr (assq 'f2 sr-mode-map))))

(defun sr-buttons-maxtaglen ()
  "<span class="quote">Calculate the length of the longest tag in `sr-buttons-list'.</span>"
  (let* ((regexp (if (sr-buttons-mc-keys-p) "<span class="quote">\\[\\|\\]</span>" "<span class="quote">\\[.*\\]</span>"))
         (lenfun (lambda (x)
                   (if x
                       (length (replace-regexp-in-string regexp "<span class="quote"></span>" (car x)))
                     0))))
    (apply 'max (mapcar lenfun sr-buttons-list))))

(defun sr-buttons-normalize-tag (tag total-length fill-char)
  "<span class="quote">Lengthen the given tag to TOTAL-LENGTH.
Works by prepending and appending the appropriate number of fill
characters, so the text appears approximately centered on its
button.</span>"
  (let* ((fill-length (- total-length (length tag)))
         (before (/ fill-length 2))
         (after (- fill-length before)))
    (concat (make-string before fill-char)
            tag
            (make-string after fill-char))))

(defun sr-buttons-action (action)
  "<span class="quote">Return a button command to perform ACTION inside the currently active pane.</span>"
  `(lambda (&rest ignore)
     (interactive)
     (sr-select-window sr-selected-window)
     (if sr-buttons-command-adapter
         (run-with-timer 0.01 nil (funcall sr-buttons-command-adapter ,action))
       (run-with-timer 0.01 nil 'call-interactively ,action))))

(defun sr-buttons-editable-pane ()
  "<span class="quote">Call `sr-editable-pane' and display an informative message.
Used inside the Sunrise Buttons buffer.</span>"
  (interactive)
  (sr-editable-pane)
  (message "<span class="quote">Push [Restore] button or C-c C-c when done, ESC C-c C-c to cancel</span>"))

(defun sr-buttons-restore-mode ()
  "<span class="quote">Implement the [Restore] action in the Sunrise buttons panel.</span>"
  (interactive)
  (case major-mode
    (sr-virtual-mode (sr-virtual-dismiss))
    (wdired-mode (eval '(wdired-finish-edit)))
    (t (message "<span class="quote">Already in regular mode</span>"))))

(provide 'sunrise-x-buttons)

<span class="linecomment">;;;###autoload (require 'sunrise-x-buttons)</span>

<span class="linecomment">;;; sunrise-x-buttons.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/Glossary">Glossary</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=sunrise-x-buttons.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=sunrise-x-buttons.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=sunrise-x-buttons.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=sunrise-x-buttons.el">Administration</a></span><span class="time"><br /> Last edited 2011-06-18 09:23 UTC by <a class="author" title="from 87-207-42-123.dynamic.chello.pl" href="http://www.emacswiki.org/emacs/Jos%c3%a9_Alfredo_Romero_L.">José Alfredo Romero L.</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=sunrise-x-buttons.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
