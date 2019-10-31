(ql:quickload :clack)

(clack:clackup
 (lambda (env)
   (declare (ignore env))
   '(200 (:content-type "text/plain") ("Hello, World")))
 :server :woo
 :address "*"
 :use-default-middlewares nil)

