(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (helm evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Default to evil mode
(require 'evil)
(evil-mode t)

(require 'org)

;; Function for going to the org agenda
(defun pop-to-org-agenda (split)
  "Visit the org agenda, in the current window or a SPLIT."
  (interactive "P")
  (org-agenda-list)
  (when (not split)
    (delete-other-windows)))

;; Bind function for going to org agenda
(define-key global-map (kbd "C-c t a") 'pop-to-org-agenda)

;; Add additional org keywords
(setq org-todo-keywords
      '((sequence "TODO" "WAITING" "SOMEDAY" "|" "DONE" "CANCELED")))

;; Set directory for writing agenda files
(setq org-agenda-files '("~/org/"))

;; Set custom todo template
(setq org-capture-templates
`(("t" "An incoming GTD item." entry
           (file "inbox.org")
           ,(concat "* TODO %?\n"
                    ":PROPERTIES:\n"
                    ":ORDERED:  t\n"
                    ":CREATED:  %u\n"
                    ":END:\n")
           :empty-lines 1)))

;; Don't let parent todo to be closed until all children are closed
(setq org-enforce-todo-dependencies t)

;; Log time when task is marked done
(setq org-log-done (quote time))

;; Log time when task deadline is changed
(setq org-log-redeadline (quote time))

;; Log time when task schedule is changed
(setq org-log-reschedule (quote time))

;; Custom agenda
(setq org-agenda-custom-commands
'(("d" "GTD immediate tasks"
           ((todo "TODO"
                  ((org-agenda-overriding-header "Immediate tasks")))
            (todo "WAITING"
                  ((org-agenda-overriding-header "Waiting for")))
            (agenda ""
                    ((org-agenda-span 1)
                     (org-agenda-use-time-grid nil))))
           ((org-agenda-compact-blocks t)))))

;; Function for capturing a task with my custom template
(defun org-task-capture ()
  "Capture a task with my default template."
  (interactive)
  (org-capture nil "t")) 

;; Key binding for custom template function
(define-key global-map (kbd "C-c c") 'org-task-capture)
