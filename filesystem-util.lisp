(defpackage #:filesystem-util
  (:use :cl
	:utility)
  (:export save myload save2 myload2))
(in-package #:filesystem-util)

(defun save (path things)
  (with-open-file (stream path :direction :output :if-does-not-exist :create :if-exists :supersede)
    (dolist (thing things)
      (print thing stream))))

(defun myload (path)
  (let ((things nil))
    (with-open-file (stream path :direction :input :if-does-not-exist nil)
      (tagbody rep
	 (let ((thing (read stream nil nil)))
	   (when thing
	     (push thing things)
	     (go rep)))))
    (nreverse things)))

(defun save2 (path thingfilename &rest things)
  (save (merge-pathnames (format nil "~s" thingfilename) path) things))
(defun myload2 (path thingfilename)
  (myload (merge-pathnames (format nil "~s" thingfilename) path)))
