<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: sunrise-x-mirror.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=sunrise-x-mirror.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: sunrise-x-mirror.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=sunrise-x-mirror.el" />
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
      title="Changes for sunrise-x-mirror.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=sunrise-x-mirror.el" />
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
<br /><span class="specialdays">Uganda, Independence Day</span><h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22sunrise-x-mirror.el%22">sunrise-x-mirror.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="http://www.emacswiki.org/emacs/download/sunrise-x-mirror.el">Download</a></p><pre class="code"><span class="linecomment">;;; sunrise-x-mirror.el --- full read/write access to compressed archives for the Sunrise Commander File Manager</span>

<span class="linecomment">;; Copyright (C) 2008-2011 José Alfredo Romero Latouche.</span>

<span class="linecomment">;; Author: José Alfredo Romero L. &lt;escherdragon@gmail.com&gt;</span>
<span class="linecomment">;;	Štěpán Němec &lt;stepnem@gmail.com&gt;</span>
<span class="linecomment">;; Maintainer: José Alfredo Romero L. &lt;escherdragon@gmail.com&gt;</span>
<span class="linecomment">;; Created: 4 May 2008</span>
<span class="linecomment">;; Version: 2</span>
<span class="linecomment">;; RCS Version: $Rev: 379 $</span>
<span class="linecomment">;; Keywords: sunrise commander, archives read/write</span>
<span class="linecomment">;; URL: http://www.emacswiki.org/emacs/sunrise-x-mirror.el</span>
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

<span class="linecomment">;; This is an extension for the Sunrise Commander file manager (for more details</span>
<span class="linecomment">;; visit http://www.emacswiki.org/emacs/Sunrise_Commander), that allows browsing</span>
<span class="linecomment">;; compressed archives in full read-write mode. Sunrise does offer means for</span>
<span class="linecomment">;; transparent browsing archives (using AVFS), but they just provide read-only</span>
<span class="linecomment">;; navigation -- if you want to edit a file inside the virtual filesystem, copy,</span>
<span class="linecomment">;; remove, or rename anything, you still have to uncompress the archive, do the</span>
<span class="linecomment">;; stuff and compress it back yourself.</span>

<span class="linecomment">;; It uses one of funionfs or unionfs-fuse to create a writeable overlay on top</span>
<span class="linecomment">;; of the read-only filesystem provided by AVFS. You can freely add, remove or</span>
<span class="linecomment">;; modify anything inside the resulting union filesystem (a.k.a. the "mirror</span>
<span class="linecomment">;; area"), and then commit all modifications (or not) to the original archive</span>
<span class="linecomment">;; with a single keystroke. There is no preliminary uncompressing of the archive</span>
<span class="linecomment">;; and nothing happens if you don't make changes (or if you don't commit them).</span>
<span class="linecomment">;; On commit, the contents of the union fs are compressed to create an updated</span>
<span class="linecomment">;; archive to replace the original one (optionally after making a backup copy of</span>
<span class="linecomment">;; it, just in case).</span>

<span class="linecomment">;; Navigating outside a mirror area will automatically close it, so if you do it</span>
<span class="linecomment">;; you may be asked whether to commit or not to the archive all your changes. In</span>
<span class="linecomment">;; nested archives (e.g. a jar inside a zip inside a tgz), partial modifications</span>
<span class="linecomment">;; are committed silently on the fly if moving out from a modified archive to</span>
<span class="linecomment">;; one that contains it. Only if you leave the topmost mirror area you will be</span>
<span class="linecomment">;; asked for confirmation whether to modify the resulting archive.</span>

<span class="linecomment">;; Be warned, though, that this method may be impractical for very large or very</span>
<span class="linecomment">;; deeply nested archives with strong compression, since the uncompressing</span>
<span class="linecomment">;; happens in the final stage and requires multiple access operations through</span>
<span class="linecomment">;; AVFS. What this means is that probably you'll have to wait a looooong time if</span>
<span class="linecomment">;; you try to commit changes to a tar.bz2 file with several hundreds of</span>
<span class="linecomment">;; megabytes in size, or under five or six other layers of strong compression.</span>

<span class="linecomment">;; For this extension to work you must have:</span>

<span class="linecomment">;; 1) FUSE + AVFS support in your Sunrise Commander. If you can navigate (read-</span>
<span class="linecomment">;; only) inside compressed archives you already have this.</span>

<span class="linecomment">;; 2) One of funionfs or unionfs-fuse. Debian lenny (stable distribution) offers</span>
<span class="linecomment">;; packages for both - I've tested them and both seem to work fine, though I had</span>
<span class="linecomment">;; to use a somewhat older version of unionfs-fuse (0.21-3).</span>

<span class="linecomment">;; 3) Programs required for repacking archives -- at least zip and tar.</span>

<span class="linecomment">;; 4) Your AVFS mount point (and the value of variable `sr-avfs-root') must be</span>
<span class="linecomment">;; in a directory where you have writing access.</span>

<span class="linecomment">;; All this means is that most probably this extension will work out-of-the-box</span>
<span class="linecomment">;; on Linux (or MacOS, or other unices), but you'll have a hard time to make it</span>
<span class="linecomment">;; work on Windows. It was written on GNU Emacs 23 on Linux and tested on GNU</span>
<span class="linecomment">;; Emacs 22 and 23 for Linux.</span>

<span class="linecomment">;;; Installation and Usage:</span>

<span class="linecomment">;; 1) Put this file somewhere in your Emacs `load-path'.</span>

<span class="linecomment">;; 2) Add a (require 'sunrise-x-mirror) to your .emacs file, anywhere after the</span>
<span class="linecomment">;; (require 'sunrise-commander) sexp.</span>

<span class="linecomment">;; 3) Evaluate the new expression, or reload your .emacs file, or restart Emacs.</span>

<span class="linecomment">;; 4) Customize the variable `sr-mirror-unionfs-impl' and select your preferred</span>
<span class="linecomment">;; unionfs implementation (either funionfs or unionfs-fuse).</span>

<span class="linecomment">;; 5) Run the Sunrise Commander (M-x sunrise), select (or navigate inside) any</span>
<span class="linecomment">;; compressed directory in the active pane and press C-c C-b. This will</span>
<span class="linecomment">;; automatically take you to the mirror area for the selected archive. You can</span>
<span class="linecomment">;; make any modifications you want to the contents of the archive, or navigate</span>
<span class="linecomment">;; inside directories or other compressed archives inside it. When you're done,</span>
<span class="linecomment">;; press again C-c C-b anywhere inside the mirror area, or simply navigate out</span>
<span class="linecomment">;; of it. If there are any changes to commit (*and* if you confirm) the original</span>
<span class="linecomment">;; archive will be replaced with a new one with the contents of the mirror area</span>
<span class="linecomment">;; you've just been working on. If you don't change the defaults, the original</span>
<span class="linecomment">;; will be renamed with a ".bak" extension added.</span>

<span class="linecomment">;; 6) You can add support for new archive formats by adding new entries to the</span>
<span class="linecomment">;; `sr-mirror-pack-commands-alist' custom variable, which contains a regular</span>
<span class="linecomment">;; expression to match against the name of the archive and a string containing</span>
<span class="linecomment">;; the shell command to execute for packing back the mirror area into a</span>
<span class="linecomment">;; compressed archive.</span>

<span class="linecomment">;; 7) Once you've gained enough confidence using this extension you can reset</span>
<span class="linecomment">;; the `sr-mirror-keep-backups' flag to get rid of all the backup copies</span>
<span class="linecomment">;; produced by it.</span>

<span class="linecomment">;; 8) Enjoy ;)</span>

<span class="linecomment">;;; Code:</span>

(require 'sunrise-commander)
(eval-when-compile (require 'cl))

(defcustom sr-mirror-keep-backups t
  "<span class="quote">If non-nil, keep backup files when committing changes to read-only archives.</span>"
  :group 'sunrise
  :type 'boolean)

(defcustom sr-mirror-pack-commands-alist
  '(
    ("<span class="quote">\\.zip$</span>" .                    "<span class="quote">zip -r   %f *</span>")
    ("<span class="quote">\\.[jwesh]ar$</span>" .              "<span class="quote">zip -r   %f *</span>")
    ("<span class="quote">\\.\\(?:tar\\.gz\\|tgz\\)$</span>" . "<span class="quote">tar cvzf %f *</span>")
    ("<span class="quote">\\.tar\\.bz2$</span>" .              "<span class="quote">tar cvjf %f *</span>")
   )
  "<span class="quote">List of shell commands to repack particular archive contents.
Used when repacking contents from a mirror area into a compressed
archive of the appropriate type. Use %f as a placeholder for the
name of the resulting archive. If no repacking command has been
registered here for a file (usually a file extension), Sunrise
will refuse to create a mirror area for it even if it is normally
browseable through AVFS.</span>"
  :group 'sunrise
  :type 'alist)

(defcustom sr-mirror-unionfs-impl 'funionfs
  "<span class="quote">Implementation of unionfs to use for creating mirror areas.</span>"
  :group 'sunrise
  :type '(choice (const :tag "<span class="quote">funionfs</span>" funionfs)
         (const :tag "<span class="quote">unionfs-fuse</span>" unionfs-fuse)))

(defface sr-mirror-path-face
  '((t (:background "<span class="quote">blue</span>" :foreground "<span class="quote">yellow</span>" :bold t :height 120)))
  "<span class="quote">Face of the directory path inside mirror areas.</span>"
  :group 'sunrise)

(defvar sr-mirror-home nil
  "<span class="quote">Root directory of all mirror areas.
Set automatically by the function `sr-mirror-enable' and reset by
`sr-mirror-disable' to keep the mirror home path, as well as to
indicate mirroring support is on/off. Do not mess with it
directly - if you need to change the name of your mirror home
dir, modify `sr-mirror-enable'.</span>")

(defvar sr-mirror-divert-goto-dir t
  "<span class="quote">Internal variable used to avoid infinite recursion.
Used when diverting `sr-goto-dir' calls to `sr-mirror-goto-dir'.
Do not touch, or else.</span>")

(if (boundp 'sr-mode-map)
    (define-key sr-mode-map "<span class="quote">\C-c\C-b</span>" 'sr-mirror-toggle))

(defun sr-mirror-enable ()
  "<span class="quote">Enable Sunrise mirror support.
Sets the variable `sr-mirror-home' to a non-nil value and
activates all advice necessary for mirror operations. This method
is called every time a new mirror area is created.</span>"
  (unless sr-mirror-home
    (setq sr-mirror-home (concat sr-avfs-root "<span class="quote">#mirror#/</span>"))
    (ad-activate 'make-directory)
    (ad-activate 'save-buffer)
    (ad-activate 'sr-goto-dir)))

(defun sr-mirror-disable ()
  "<span class="quote">Disable Sunrise mirror support.
Resets `sr-mirror-home' and deactivates all advice used in mirror
operations. This method is called after the last mirror area in
the current mirror home is closed.</span>"
  (when sr-mirror-home
    (setq sr-mirror-home nil)
    (ad-deactivate 'make-directory)
    (ad-deactivate 'save-buffer)
    (ad-deactivate 'sr-goto-dir)))

(defun sr-mirror-open ()
  "<span class="quote">Set up a mirror area in the current pane.
Uses funionfs to create a writeable filesystem overlay over the
AVFS virtual filesystem of the selected compressed archive and
displays it in the current pane. The result is a mirror of the
contents of the original archive that is fully writeable.</span>"
  (interactive)
  (let ((path (or (dired-get-filename nil t)
                  (concat (expand-file-name (dired-current-directory)) "<span class="quote">/.</span>")))
        (sr-mirror-divert-goto-dir nil)
		(sr-avfs-root (expand-file-name sr-avfs-root))
        fname vpaths)
    (if (sr-overlapping-paths-p sr-avfs-root path)
        (unless (and sr-mirror-home (sr-overlapping-paths-p sr-mirror-home path))
          (setq path (substring path (length sr-avfs-root))
                vpaths (split-string path "<span class="quote">#[^/]*/</span>")
                path (car vpaths)
                vpaths (cdr vpaths))))
    (setq fname (file-name-nondirectory path))
    (if (null (assoc-default fname sr-mirror-pack-commands-alist 'string-match))
        (error (concat "<span class="quote">Sunrise: sorry, no packer was registered for </span>" fname)))
    (unless (local-variable-p 'sr-current-path-face)
      (make-local-variable 'sr-current-path-face))
    (setq sr-current-path-face 'sr-mirror-path-face)
    (sr-mirror-enable)
    (unless (file-exists-p sr-mirror-home)
      (make-directory sr-mirror-home))
    (if vpaths
        (mapc (lambda (x)
                (let ((sr-mirror-divert-goto-dir nil))
                  (sr-goto-dir (sr-mirror-mount path))
                  (sr-follow-file x)
                  (setq path (dired-get-filename))))
              vpaths)
      (sr-goto-dir (sr-mirror-mount path)))
    (add-hook 'kill-buffer-hook 'sr-mirror-on-kill-buffer)
    t ))

(defun sr-mirror-mount (path)
  "<span class="quote">Create and mount (if necessary) all the directories needed to mirror PATH.
PATH identifies the compressed archive. Returns the path to the
corresponding mirror area.</span>"
  (let* ((base (sr-mirror-mangle path))
         (virtual (sr-mirror-full-demangle path))
         (mirror (concat sr-mirror-home base))
         (overlay (concat sr-mirror-home "<span class="quote">.</span>" base))
         (command
          (case sr-mirror-unionfs-impl
            (funionfs
             (concat "<span class="quote">cd ~; funionfs </span>" overlay "<span class="quote"> </span>" mirror
                     "<span class="quote"> -o dirs=</span>" virtual "<span class="quote">=ro</span>"))

            (unionfs-fuse
             (concat "<span class="quote">cd ~; unionfs-fuse -o cow,kernel_cache -o allow_other </span>"
                     overlay "<span class="quote">=RW:</span>" virtual "<span class="quote">=RO </span>" mirror)))))
    (if (null virtual)
        (error (concat "<span class="quote">Sunrise: sorry, don't know how to mirror </span>" path)))
    (unless (file-directory-p mirror)
      (make-directory mirror)
      (make-directory overlay)
      (shell-command-to-string command))
    mirror))

(defun sr-mirror-close (&optional do-commit local-commit moving)
  "<span class="quote">Destroy the current mirror area.
Unmounts and deletes the directories it was built upon. Tries to
automatically repack the mirror and substitute the original archive
with a new one containing the modifications made to the mirror.

If optional argument DO-COMMIT is set, then all changes made to the
mirror are unconditionally committed to the archive. If
LOCAL-COMMIT is set, then the commit is considered local (changes
effect a mirror nested inside another mirror). MOVING means that
this operation was triggered by the user moving outside of the
current mirror area (the current buffer will be killed soon).</span>"
  (interactive)
  (unless sr-mirror-home
    (error (concat "<span class="quote">Sunrise: sorry, can't mirror </span>" (dired-get-filename))))

  (let ((here (dired-current-directory))
        (sr-mirror-divert-goto-dir nil)
        (pos) (mirror) (overlay) (vroot) (vpath) (committed))

    (unless (sr-overlapping-paths-p sr-mirror-home here)
      (error (concat "<span class="quote">Sunrise: sorry, that's not a mirror area: </span>" here)))

    (setq pos (string-match "<span class="quote">\\(?:/\\|$\\)</span>" here (length sr-mirror-home))
          mirror (substring here (length sr-mirror-home) pos)
          overlay (concat "<span class="quote">.</span>" mirror )
          vpath (substring here (1+ pos))
          do-commit (and (sr-mirror-files (concat sr-mirror-home overlay))
                         (or do-commit
                             (y-or-n-p "<span class="quote">Sunrise: commit changes in mirror? </span>"))))

    (unless local-commit
      (kill-local-variable 'sr-current-path-face))

    (remove-hook 'kill-buffer-hook 'sr-mirror-on-kill-buffer)
    (sr-follow-file (sr-mirror-demangle mirror))
    (setq vroot (dired-get-filename 'no-dir))

    (if do-commit (setq committed (sr-mirror-commit mirror overlay)))
    (sr-mirror-unmount mirror overlay)

    (unless local-commit
      (if (sr-overlapping-paths-p sr-mirror-home (dired-current-directory))
          (sr-mirror-close committed))
      (unless moving
        (sr-find-file (expand-file-name (concat default-directory vroot)))
        (if (&lt; 0 (length vpath)) (sr-goto-dir vpath)))))

  (sr-highlight)
  (if (and sr-mirror-home
           (null (directory-files sr-mirror-home nil "<span class="quote">^[^.]</span>")))
      (sr-mirror-disable))
  t)

(defun sr-mirror-commit (mirror overlay)
  "<span class="quote">Commit all modifications made to MIRROR in directory OVERLAY.
Replaces the mirrored archive with a new one built with the
current contents of the mirror. Keeps a backup of the original
archive if the variable `sr-mirror-backup' is non-nil (the
default).</span>"
  (condition-case err
      (let ((repacked (sr-mirror-repack mirror))
            (target (dired-get-filename)))
        (if (and sr-mirror-keep-backups
                 (not (sr-overlapping-paths-p sr-mirror-home target)))
            (rename-file target (concat target "<span class="quote">.bak</span>") 1)
          (delete-file target))
        (copy-file repacked (dired-current-directory) t nil nil)
        (delete-file repacked)
        t)
    (error (progn
             (setq err (cadr err))
             (if (not (yes-or-no-p (concat err "<span class="quote">. OK to continue? </span>")))
                 (error err))))))

(defun sr-mirror-unmount (mirror overlay)
  "<span class="quote">Unmount and delete all directories used for mirroring a compressed archive.
MIRROR is the union of the AVFS directory that holds the contents
of the archive (read-only) with OVERLAY, which contains all the
modifications made to the union in the current session.</span>"
  (let* ((command (concat "<span class="quote">cd ~; fusermount -u </span>" sr-mirror-home mirror))
         (err (shell-command-to-string command)))
    (if (or (null err) (string= err "<span class="quote"></span>"))
        (progn
          (dired-delete-file (concat sr-mirror-home mirror) 'always)
          (dired-delete-file (concat sr-mirror-home overlay) 'always)
          (revert-buffer))
      (error (concat "<span class="quote">Sunrise: error unmounting mirror: </span>" err)))))

(defun sr-mirror-toggle ()
  "<span class="quote">Open new or destroy the current mirror area, depending on context.</span>"
  (interactive)
  (let ((open-ok) (close-ok) (err-msg))
    (condition-case err1
        (setq open-ok (sr-mirror-open))
      (error (condition-case err2
                 (progn
                   (setq close-ok (sr-mirror-close))
                   (setq err-msg (cadr err1)))
               (error
                  (setq err-msg (cadr err2))) )) )
    (if (and (not open-ok) (not close-ok))
        (error err-msg)
      (sr-highlight))))

(defun sr-mirror-repack (mirror)
  "<span class="quote">Try to repack the given MIRROR.
On success, returns a string containing the full path to the newly
packed archive, otherwise throws an error.</span>"
  (message "<span class="quote">Sunrise: repacking mirror, please wait...</span>")
  (let* ((target-home (concat sr-mirror-home "<span class="quote">.repacked/</span>"))
         (archive (replace-regexp-in-string "<span class="quote">#[a-z0-9]*$</span>" "<span class="quote"></span>" mirror))
         (target (replace-regexp-in-string
                  "<span class="quote">/?$</span>" "<span class="quote"></span>"
                  (car (last (split-string archive "<span class="quote">+</span>")))))
         (files (directory-files (concat sr-mirror-home mirror)))
         (command (assoc-default archive sr-mirror-pack-commands-alist 'string-match)))

    (if (null command)
        (error (concat "<span class="quote">Sunrise: sorry, don't know how to repack </span>" mirror)))

    (if (not (file-exists-p target-home))
        (make-directory target-home))
    (setq target (concat target-home target))
    (setq command (replace-regexp-in-string "<span class="quote">%f</span>" target command))
    (setq command (concat "<span class="quote">cd </span>" sr-mirror-home mirror "<span class="quote">; </span>" command))
    (shell-command-to-string command)
    target))

(defun sr-mirror-mangle (path)
  "<span class="quote">Transform PATH into a string naming a new mirror area.</span>"
  (let ((handler (assoc-default path sr-avfs-handlers-alist 'string-match)))
    (if (eq ?/ (string-to-char path))
        (setq path (substring path 1)))
    (concat (replace-regexp-in-string
             "<span class="quote">/</span>" "<span class="quote">+</span>"
             (replace-regexp-in-string "<span class="quote">\\+</span>" "<span class="quote">{+}</span>" path)) handler)))

(defun sr-mirror-demangle (path)
  "<span class="quote">Transform the given mirror area name into a regular filesystem path.
Opposite of `sr-mirror-mangle'.</span>"
  (concat "<span class="quote">/</span>"
          (replace-regexp-in-string
           "<span class="quote">{\\+}</span>" "<span class="quote">+</span>" (replace-regexp-in-string
                        "<span class="quote">\\+\\([^}]\\)</span>" "<span class="quote">/\\1</span>" (replace-regexp-in-string
                                                "<span class="quote">#[a-z0-9]*$</span>" "<span class="quote"></span>" path)))))

(defun sr-mirror-full-demangle (path)
  "<span class="quote">Demangle PATH recursively to obtain the current path of the original archive.
This is necessary because reflecting an archive that is itself a
reflection causes deadlocks in FUSE.</span>"
  (let ((reflected path)
        (home-len (length sr-mirror-home))
        (handler (assoc-default path sr-avfs-handlers-alist 'string-match))
        (prev-path))
    (while (and (not (string= reflected prev-path))
                (sr-overlapping-paths-p sr-mirror-home reflected))
      (setq prev-path reflected)
      (setq reflected (substring reflected home-len)
            reflected (sr-mirror-demangle reflected)))
    (setq reflected (concat sr-avfs-root reflected handler))
    reflected))

(defun sr-mirror-files (directory)
  "<span class="quote">Return list of pathnames constituting mirror modifications inside overlay DIRECTORY.</span>"
  (if (not (file-directory-p directory))
      (ignore)
    (let ((files (directory-files directory)))
      (mapc (lambda (x) (setq files (delete x files)))
              '("<span class="quote">.</span>" "<span class="quote">..</span>" "<span class="quote">._funionfs_control~</span>"))
      files)))

(defun sr-mirror-overlay-redir (dirname &optional force-root)
  "<span class="quote">Adjust DIRNAME for use with a mirror filesystem.
Analyses the given directory path and rewrites it (if necessary)
to play nicely with the mirror fs the given path belongs to. If
the path is not inside any mirror fs, it is returned unmodified.</span>"
  (if (null sr-avfs-root)
      dirname
    (let ((xpdir (expand-file-name dirname))
          (mirror) (pos) (target))
      (if (sr-overlapping-paths-p sr-mirror-home xpdir)
          (progn
            (setq mirror (substring xpdir (length sr-mirror-home)))
            (setq pos (string-match "<span class="quote">/\\|$</span>" mirror))
            (if pos
                (progn
                  (setq target (replace-regexp-in-string "<span class="quote">^/</span>" "<span class="quote"></span>" (substring mirror pos)))
                  (setq mirror (substring mirror 0 pos))))
            (if (and target
                     (or (&gt; (length target) 0) force-root)
                     (not (eq ?. (string-to-char mirror))))
                (concat sr-mirror-home "<span class="quote">.</span>" mirror "<span class="quote">/</span>" target)
              dirname))
        dirname))))

(defun sr-mirror-surface (dir)
  "<span class="quote">Return the topmost parent of DIR under `sr-mirror-home', if any.</span>"
  (if (and sr-mirror-home
           (sr-overlapping-paths-p sr-mirror-home dir)
           (not (sr-equal-dirs sr-mirror-home dir)))
      (let ((local-dir (dired-make-relative dir sr-mirror-home)))
        (string-match "<span class="quote">^\\([^/]*\\)</span>" local-dir)
        (match-string 1 local-dir))))

(defun sr-mirror-overlapping-p (mirror1 mirror2)
  "<span class="quote">Return non-nil if the surface of MIRROR2 maps an archive nested
inside the archive mapped by the surface of MIRROR1.</span>"
  (let ((surface1 (sr-mirror-surface mirror1))
        (surface2 (sr-mirror-surface mirror2))
        top)
    (when (and surface1 surface2)
      (setq top (sr-mirror-demangle surface1))
      (sr-overlapping-paths-p top (sr-mirror-demangle surface2)))))

(defun sr-mirror-goto-dir (target)
  "<span class="quote">Enhance `sr-goto-dir' with transparent navigation inside mirror areas.
All calls to `sr-goto-dir' are diverted to this function.</span>"
  (let* ((here (expand-file-name default-directory))
         (target (expand-file-name (or target "<span class="quote">.</span>")))
         (surface-here (sr-mirror-surface here))
         (sr-mirror-divert-goto-dir nil)
         surface-target)
    (cond
     ((null surface-here) (sr-goto-dir target))
     ((sr-overlapping-paths-p sr-avfs-root target) (sr-mirror-open))
     (t
      (progn
        (if (sr-equal-dirs target sr-mirror-home)
            (setq target (expand-file-name
                          (concat (sr-mirror-demangle surface-here) "<span class="quote">/..</span>"))
                  surface-target (sr-mirror-surface (sr-mirror-mangle target)))
          (setq surface-target (sr-mirror-surface target)))
        (unless (equal surface-here surface-target)
          (if (and surface-target
                   (sr-overlapping-paths-p sr-mirror-home target)
                   (sr-mirror-overlapping-p surface-target surface-here))
              (sr-mirror-close t t)
            (sr-mirror-close nil nil t)))
        (unless (or (not (file-directory-p target))
                    (sr-equal-dirs target (dired-current-directory)))
          (sr-goto-dir target)))))
    (sr-highlight)))

(defun sr-mirror-on-kill-buffer ()
  "<span class="quote">Handle navigation out of a mirror area other than through `sr-goto-dir'.
This includes e.g. bookmark jumps and pane synchronizations.</span>"
  (when (and sr-mirror-home (eq major-mode 'sr-mode)
           (null (sr-mirror-surface sr-this-directory))
           (sr-mirror-surface (dired-current-directory)))
      (sr-mirror-goto-dir sr-this-directory)
      (kill-local-variable 'sr-current-path-face)))

(defadvice sr-goto-dir
  (around sr-mirror-advice-sr-goto-dir (dir))
  "<span class="quote">Divert all `sr-goto-dir' calls to `sr-mirror-goto-dir'.</span>"
  (if sr-mirror-divert-goto-dir
      (sr-mirror-goto-dir dir)
    ad-do-it))

(defadvice sr-clone-files
  (around sr-mirror-advice-sr-clone-files
          (file-path-list target-dir clone-op progress &optional do-overwrite))
"<span class="quote">Redirect all `sr-copy' operations to the right path under the
overlay directory.</span>"
  (if (null sr-mirror-home)
      ad-do-it
    (let ((orig target-dir))
      (setq target-dir (sr-mirror-overlay-redir target-dir t))
      (if (&gt; (length target-dir) (length orig))
          (make-directory target-dir))
      ad-do-it)))
(ad-activate 'sr-clone-files)

(defadvice make-directory
  (around sr-mirror-advice-make-directory (dirname &optional parents))
  "<span class="quote">Redirect directory creation operations to the right path under
the overlay directory.</span>"
  (setq dirname (sr-mirror-overlay-redir dirname))
  (setq parents t)
  ad-do-it)

(defadvice save-buffer
  (around sr-mirror-advice-save-buffer (&optional args))
  "<span class="quote">Create all the subdirectories (and set their permissions)
needed for enabling the redirection of buffer saving operations
to the right path under the overlay directory.</span>"
  (let* ((orig (buffer-file-name))
         (target (sr-mirror-overlay-redir orig)))
    (if (&gt; (length target) (length orig))
        (let ((default-directory "<span class="quote">~/</span>")
              (target-dir (file-name-directory target)))
          (make-directory target-dir)
          (shell-command-to-string (concat dired-chmod-program "<span class="quote"> a+x </span>" target-dir))
          (write-file target nil))
      ad-do-it)))

(defun sr-mirror-toggle-read-only ()
  "<span class="quote">Toggle the read-only flag in all buffers opened inside a mirror area,
so they are always writeable by default.</span>"
  (if sr-mirror-home
      (let* ((orig (buffer-file-name))
             (target (sr-mirror-overlay-redir orig)))
        (if (&gt; (length target) (length orig))
            (toggle-read-only -1)))))
(add-hook 'find-file-hook 'sr-mirror-toggle-read-only)

(defun sunrise-x-mirror-unload-function ()
  (sr-ad-disable "<span class="quote">^sr-mirror-</span>"))

(provide 'sunrise-x-mirror)

<span class="linecomment">;;;###autoload (require 'sunrise-x-mirror)</span>

<span class="linecomment">;;; sunrise-x-mirror.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/Glossary">Glossary</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=sunrise-x-mirror.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=sunrise-x-mirror.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=sunrise-x-mirror.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=sunrise-x-mirror.el">Administration</a></span><span class="time"><br /> Last edited 2011-07-02 12:21 UTC by <a class="author" title="from 87-207-42-123.dynamic.chello.pl" href="http://www.emacswiki.org/emacs/Jos%c3%a9_Alfredo_Romero_L.">José Alfredo Romero L.</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=sunrise-x-mirror.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
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
