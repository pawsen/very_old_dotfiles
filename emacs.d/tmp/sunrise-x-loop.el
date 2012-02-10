<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: sunrise-x-loop.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=sunrise-x-loop.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: sunrise-x-loop.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=sunrise-x-loop.el" />
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
      title="Changes for sunrise-x-loop.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=sunrise-x-loop.el" />
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
<br /><span class="specialdays">Uganda, Independence Day</span><h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22sunrise-x-loop.el%22">sunrise-x-loop.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="http://www.emacswiki.org/emacs/download/sunrise-x-loop.el">Download</a></p><pre class="code"><span class="linecomment">;;; sunrise-x-loop.el --- asynchronous execution of filesystem operations for the Sunrise Commander File Manager</span>

<span class="linecomment">;; Copyright (C) 2008-2010 José Alfredo Romero Latouche.</span>

<span class="linecomment">;; Author: José Alfredo Romero L. &lt;escherdragon@gmail.com&gt;</span>
<span class="linecomment">;;	Štěpán Němec &lt;stepnem@gmail.com&gt;</span>
<span class="linecomment">;; Maintainer: José Alfredo Romero L. &lt;escherdragon@gmail.com&gt;</span>
<span class="linecomment">;; Created: 27 Jun 2008</span>
<span class="linecomment">;; Version: 3</span>
<span class="linecomment">;; RCS Version: $Rev: 382 $</span>
<span class="linecomment">;; Keywords: sunrise commander, background copy rename move</span>
<span class="linecomment">;; URL: http://www.emacswiki.org/emacs/sunrise-x-loop.el</span>
<span class="linecomment">;; Compatibility: GNU Emacs 22+</span>

<span class="linecomment">;; This file is *NOT* part of GNU Emacs.</span>

<span class="linecomment">;; This program is free software: you can redistribute it and/or modify it under</span>
<span class="linecomment">;; the terms of the GNU General Public License as published by the Free Software</span>
<span class="linecomment">;; Foundation, either version 3 of the License, or (at your option) any later</span>
<span class="linecomment">;; version.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; This program is distributed in the hope that it will be useful, but WITHOUT</span>
<span class="linecomment">;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS</span>
<span class="linecomment">;; FOR A PARTICULAR PURPOSE. See the GNU General Public License for more de-</span>
<span class="linecomment">;; tails.</span>

<span class="linecomment">;; You should have received a copy of the GNU General Public License along with</span>
<span class="linecomment">;; this program. If not, see &lt;http://www.gnu.org/licenses/&gt;.</span>

<span class="linecomment">;;; Commentary:</span>

<span class="linecomment">;; This extension adds to the Sunrise Commander the capability of performing</span>
<span class="linecomment">;; copy and rename operations in the background. It provides prefixable drop-in</span>
<span class="linecomment">;; replacements for the `sr-do-copy' and `sr-do-rename' commands and uses them</span>
<span class="linecomment">;; to redefine their bindings in the `sr-mode-map' keymap. When invoked the</span>
<span class="linecomment">;; usual way (by pressing C or R), these new functions work exactly as the old</span>
<span class="linecomment">;; ones, i.e. they simply pass the control flow to the logic already provided by</span>
<span class="linecomment">;; Sunrise, but when prefixed (e.g. by pressing C-u C or C-u R) they launch a</span>
<span class="linecomment">;; separate Elisp intepreter in the background, delegate to it the execution of</span>
<span class="linecomment">;; all further operations and return immediately, so the Emacs UI remains fully</span>
<span class="linecomment">;; responsive while any potentially long-running copy or move tasks can be let</span>
<span class="linecomment">;; alone to eventually reach their completion in the background.</span>

<span class="linecomment">;; After all requested actions have been performed, the background interpreter</span>
<span class="linecomment">;; remains active for a short period of time (30 seconds by default, but it can</span>
<span class="linecomment">;; be customized), after which it shuts down automatically.</span>

<span class="linecomment">;; At any moment you can abort all tasks scheduled and under execution and force</span>
<span class="linecomment">;; the background interpreter to shut down by invoking the `sr-loop-stop'</span>
<span class="linecomment">;; command (M-x sr-loop-stop).</span>

<span class="linecomment">;; If you need to debug something or are just curious about how this extension</span>
<span class="linecomment">;; works, you can set the variable `sr-loop-debug' to t to have the interpreter</span>
<span class="linecomment">;; launched in debug mode. In this mode all input and output of background</span>
<span class="linecomment">;; operations are sent to a buffer named *SUNRISE-LOOP*. To return to normal</span>
<span class="linecomment">;; mode set `sr-loop-debug' back to nil and use `sr-loop-stop' to kill the</span>
<span class="linecomment">;; currently running interpreter.</span>

<span class="linecomment">;; The extension disables itself and tries to do its best to keep out of the way</span>
<span class="linecomment">;; when working with remote directories through FTP (e.g. when using ange-ftp),</span>
<span class="linecomment">;; since in these cases the execution of file transfers in the background should</span>
<span class="linecomment">;; be managed directly by the FTP client.</span>

<span class="linecomment">;; It was written on GNU Emacs 23 on Linux, and tested on GNU Emacs 22 and 23</span>
<span class="linecomment">;; for Linux and on EmacsW32 (version 22) for Windows.</span>

<span class="linecomment">;;; Installation and Usage:</span>

<span class="linecomment">;; 1) Put this file somewhere in your Emacs `load-path'.</span>

<span class="linecomment">;; 2) Add a (require 'sunrise-x-loop) expression to your .emacs file somewhere</span>
<span class="linecomment">;; after the (require 'sunrise-commander) one.</span>

<span class="linecomment">;; 3) Evaluate the new expression, or reload your .emacs file, or restart Emacs.</span>

<span class="linecomment">;; 4) The next time you need to copy of move any big files, just prefix the</span>
<span class="linecomment">;; appropriate command with C-u.</span>

<span class="linecomment">;; 5) Enjoy ;-)</span>

<span class="linecomment">;; 6) You can use `unload-feature' to get rid of the provided functionality</span>
<span class="linecomment">;; completely.</span>

<span class="linecomment">;;; Code:</span>

(require 'sunrise-commander)

(defcustom sr-loop-debug nil
  "<span class="quote">Activate debug mode in the Sunrise Loop extension.
When set, the background elisp interpreter is launched in such a
way that all background input and output are sent to a buffer
named *SUNRISE LOOP* and automatic lifecycle management is
disabled (i.e. you have to kill the interpreter manually using
sr-loop-stop to get rid of it).</span>"
  :group 'sunrise
  :type 'boolean)

(defcustom sr-loop-timeout 30
  "<span class="quote">Number of seconds to wait while idle before shutting down the interpreter.
After executing one or more operations in the background, the
Sunrise Loop Elisp interpreter will be killed automatically after
this amount of time.</span>"
  :group 'sunrise)

(defcustom sr-loop-use-popups t
  "<span class="quote">When non-nil, display pop‐up notification when execution queue is emptied.</span>"
  :group 'sunrise
  :type 'boolean)

(defvar sr-loop-process nil)
(defvar sr-loop-timer nil)
(defvar sr-loop-scope nil)
(defvar sr-loop-queue nil)

(defun sr-loop-start ()
  "<span class="quote">Launch and initiate a new background Elisp interpreter.
The new interpreter runs in batch mode and inherits all functions
from the Sunrise Commander (sunrise-commander.el) and from this
file.</span>"
  (let ((process-connection-type nil)
        (sr-main (symbol-file 'sr-mode))
        (sr-loop (symbol-file 'sr-loop-cmd-loop))
        (emacs (concat invocation-directory invocation-name)))
    (setq sr-loop-process (start-process
                         "<span class="quote">Sunrise-Loop</span>"
                         (if sr-loop-debug "<span class="quote">*SUNRISE-LOOP*</span>" nil)
                         emacs
                         "<span class="quote">-batch</span>" "<span class="quote">-q</span>" "<span class="quote">-no-site-file</span>"
                         "<span class="quote">-l</span>" sr-main "<span class="quote">-l</span>" sr-loop
                         "<span class="quote">-eval</span>" "<span class="quote">(sr-loop-cmd-loop)</span>"))
    (sr-loop-enqueue `(setq load-path (quote ,load-path)))
    (sr-loop-enqueue '(require 'sunrise-commander))
    (if sr-loop-debug
        (sr-loop-enqueue '(setq sr-loop-debug t))
      (set-process-filter sr-loop-process 'sr-loop-filter))
    (setq sr-loop-queue nil)))

(defun sr-loop-disable-timer ()
  "<span class="quote">Disable the automatic shutdown timer.
This is done every time we send a new task to the background
interpreter, lest it gets nuked before completing its queue.</span>"
  (if sr-loop-timer
      (progn
        (cancel-timer sr-loop-timer)
        (setq sr-loop-timer nil))))

(defun sr-loop-enable-timer ()
  "<span class="quote">Enable the automatic shutdown timer.
This is done every time we receive confirmation from the
background interpreter that all the tasks delegated to it have
been completed. Once this function is executed, if no new tasks
are enqueued before `sr-loop-timeout' seconds, the interpreter is
killed.</span>"
  (sr-loop-disable-timer)
  (setq sr-loop-timer (run-with-timer sr-loop-timeout nil 'sr-loop-stop)))

(defun sr-loop-stop (&optional interrupt)
  "<span class="quote">Shut down the background Elisp interpreter and clean up after it.</span>"
  (interactive "<span class="quote">p</span>")
  (sr-loop-disable-timer)
  (if sr-loop-queue
      (if interrupt
          (progn
            (sr-loop-notify "<span class="quote">Aborted. Some operations may remain unfinished.</span>")
            (setq sr-loop-queue nil))
        (sr-loop-enable-timer)))
  (unless sr-loop-queue
    (delete-process sr-loop-process)
    (setq sr-loop-process nil)))

(defun sr-loop-notify (msg)
  "<span class="quote">Notify the user about an event.</span>"
  (if (and window-system sr-loop-use-popups)
      (x-popup-dialog t (list msg '("<span class="quote">OK</span>")) t)
    (message (concat "<span class="quote">[[</span>" msg "<span class="quote">]]</span>"))))

(defun sr-loop-filter (process output)
  "<span class="quote">Process filter for the background interpreter.</span>"
  (mapc (lambda (line)
          (cond ((string-match "<span class="quote">^\\[\\[\\*\\([^\]\*]+\\)\\*\\]\\]$</span>" line)
                 (sr-loop-notify (match-string 1 line)))

                ((and (or (string-match "<span class="quote">^\\[\\[</span>" line)
                          (string-match "<span class="quote">^Sunrise Loop: </span>" line))
                      (&lt; 0 (length line)))
                 (message "<span class="quote">%s</span>" line))

                ((eq ?^ (string-to-char line))
                 (let ((command (substring line 1)))
                   (when (string= command (car sr-loop-queue))
                     (pop sr-loop-queue)
                     (sr-loop-enable-timer)
                     (unless sr-loop-queue
                       (sr-loop-notify "<span class="quote">Background job finished!</span>")))))
                (t nil)))
        (split-string output "<span class="quote">\n</span>")))

(defun sr-loop-enqueue (form)
  "<span class="quote">Delegate evaluation of FORM to the background interpreter.
If no such interpreter is currently running, launches a new one.</span>"
  (sr-loop-disable-timer)
  (unless sr-loop-process
    (sr-loop-start))
  (let ((command (prin1-to-string form)))
    (setq sr-loop-queue (append sr-loop-queue (list (md5 command))))
    (process-send-string sr-loop-process command)
    (process-send-string sr-loop-process "<span class="quote">\n</span>")))

(defun sr-loop-cmd-loop ()
  "<span class="quote">Main execution loop for the background Elisp interpreter.</span>"
  (sr-ad-disable "<span class="quote">^sr-loop-</span>")
  (defun read-char nil ?y) <span class="linecomment">;; Always answer "yes" to any prompt</span>
  (let ((command) (signature))
    (while t
      (setq command (read))
      (setq signature (md5 (prin1-to-string command)))
      (condition-case description
          (progn
            (if sr-loop-debug
                (message "<span class="quote">%s</span>" (concat "<span class="quote">[[Executing in background: </span>"
                                      (prin1-to-string command) "<span class="quote">]]</span>")))
            (eval command)
            (message "<span class="quote">[[Command successfully invoked in background]]</span>"))
        (error (message "<span class="quote">%s</span>" (concat "<span class="quote">[[*ERROR IN BACKGROUND JOB: </span>"
                                     (prin1-to-string description) "<span class="quote">*]]</span>"))))
        (message "<span class="quote">^%s</span>" signature))))

(defun sr-loop-applicable-p ()
  "<span class="quote">Return non-nil if an operation is suitable for the background interpreter.</span>"
  (and (null (string-match "<span class="quote">^/ftp:</span>" dired-directory))
       (null (string-match "<span class="quote">^/ftp:</span>" sr-other-directory))))

(defun sr-loop-do-copy (&optional arg)
  "<span class="quote">Drop-in prefixable replacement for the `sr-do-copy' command.
When invoked with a prefix argument, sets a flag that is used
later by advice to decide whether to delegate further copy
operations to the background interpreter.</span>"
  (interactive "<span class="quote">P</span>")
  (if (and arg (sr-loop-applicable-p))
      (let ((sr-loop-scope t))
        (sr-do-copy))
    (sr-do-copy)))

(defun sr-loop-do-clone (&optional arg)
  "<span class="quote">Drop-in prefixable replacement for the `sr-do-clone' command.
When invoked with a prefix argument, sets a flag that is used
later by advice to decide whether to delegate further copy
operations to the background interpreter.</span>"
  (interactive "<span class="quote">P</span>")
  (if (and arg (sr-loop-applicable-p))
      (let ((sr-loop-scope t))
        (call-interactively 'sr-do-clone))
    (call-interactively 'sr-do-clone)))

(defun sr-loop-do-rename (&optional arg)
  "<span class="quote">Drop-in  prefixable  replacement  for  the `sr-do-rename' command.
When invoked with a prefix argument, sets a flag that is used
later by advice to decide whether to delegate further rename
operations to the background interpreter.</span>"
  (interactive "<span class="quote">P</span>")
  (if (and arg (sr-loop-applicable-p))
      (let ((sr-loop-scope t))
        (sr-do-rename))
    (sr-do-rename)))

(defadvice sr-progress-prompt (around sr-loop-advice-sr-progress-prompt
                                      activate)
  "<span class="quote">Display \"Sunrise Loop\" instead of \"Sunrise\" in the prompt.</span>"
  (setq ad-return-value
        (concat (if sr-loop-scope "<span class="quote">Sunrise Loop: </span>" "<span class="quote">Sunrise: </span>")
                (ad-get-arg 0)
                "<span class="quote">...</span>")))

(defadvice y-or-n-p (before sr-loop-advice-y-or-n-p activate)
  "<span class="quote">Modify all confirmation request messages inside a loop scope.</span>"
  (when sr-loop-scope
    (setq (ad-get-arg 0)
          (replace-regexp-in-string
           "<span class="quote">\?</span>" "<span class="quote"> in the background? (overwrites ALWAYS!)</span>" (ad-get-arg 0)))))

(defadvice dired-mark-read-file-name
  (before sr-loop-advice-dired-mark-read-file-name
          (prompt dir op-symbol arg files &optional default)
          activate)
  "<span class="quote">Modify all queries from Dired inside a loop scope.</span>"
  (if sr-loop-scope
      (setq prompt (replace-regexp-in-string
                    "<span class="quote">^\\([^ ]+\\) ?\\(.*\\)</span>"
                    "<span class="quote">\\1 (in background - overwrites ALWAYS!) \\2</span>" prompt))))

(defadvice dired-create-files
  (around sr-loop-advice-dired-create-files
          (file-creator operation fn-list name-constructor
                        &optional marker-char)
          activate)
  "<span class="quote">Delegate to the background interpreter all copy and rename operations
triggered by `dired-do-copy' inside a loop scope.</span>"
  (if sr-loop-scope
      (with-no-warnings
        (sr-loop-enqueue
         `(let ((target ,target))       <span class="linecomment">; cf. `dired-do-create-files'</span>
            (dired-create-files (function ,file-creator)
                                ,operation
                                (quote ,fn-list)
                                ,name-constructor nil))))
    ad-do-it))

(defadvice sr-clone-files
  (around sr-loop-advice-sr-clone-files
          (file-path-list target-dir clone-op progress &optional do-overwrite)
          activate)
  "<span class="quote">Delegate to the background interpreter all copy operations
triggered by `sr-do-copy' inside a loop scope.</span>"
  (if sr-loop-scope
      (sr-loop-enqueue
       `(sr-clone-files
         (quote ,file-path-list) ,target-dir #',clone-op ',progress 'ALWAYS))
    ad-do-it))

(defadvice sr-move-files
  (around sr-loop-advice-sr-move-files
          (file-path-list target-dir progress &optional do-overwrite)
          activate)
  "<span class="quote">Delegate to the background interpreter all rename operations
triggered by `sr-do-rename' inside a loop scope.</span>"
  (if sr-loop-scope
      (sr-loop-enqueue
       `(sr-move-files (quote ,file-path-list) ,target-dir ',progress 'ALWAYS))
    ad-do-it))

(define-key sr-mode-map "<span class="quote">C</span>" 'sr-loop-do-copy)
(define-key sr-mode-map "<span class="quote">K</span>" 'sr-loop-do-clone)
(define-key sr-mode-map "<span class="quote">R</span>" 'sr-loop-do-rename)

(defun sunrise-x-loop-unload-function ()
  (sr-ad-disable "<span class="quote">^sr-loop-</span>")
  (define-key sr-mode-map "<span class="quote">C</span>" 'sr-do-copy)
  (define-key sr-mode-map "<span class="quote">K</span>" 'sr-do-clone)
  (define-key sr-mode-map "<span class="quote">R</span>" 'sr-do-rename))

(provide 'sunrise-x-loop)

<span class="linecomment">;;;###autoload (require 'sunrise-x-loop)</span>

<span class="linecomment">;;; sunrise-x-loop.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/Glossary">Glossary</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=sunrise-x-loop.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=sunrise-x-loop.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=sunrise-x-loop.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=sunrise-x-loop.el">Administration</a></span><span class="time"><br /> Last edited 2011-08-01 10:38 UTC by <a class="author" title="from 87-207-186-231.dynamic.chello.pl" href="http://www.emacswiki.org/emacs/Jos%c3%a9_Alfredo_Romero_L.">José Alfredo Romero L.</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=sunrise-x-loop.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
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
