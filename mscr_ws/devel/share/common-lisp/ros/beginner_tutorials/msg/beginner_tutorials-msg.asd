
(cl:in-package :asdf)

(defsystem "beginner_tutorials-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Simple" :depends-on ("_package_Simple"))
    (:file "_package_Simple" :depends-on ("_package"))
  ))