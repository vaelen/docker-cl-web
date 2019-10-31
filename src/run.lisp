(ql:quickload :clack)

(clack:clackup
 (lambda (env)
   (declare (ignore env))
   '(200 (:content-type "text/plain") ("Hello, World")))
 :server :woo
 :address "*"
 :port (parse-integer (uiop:getenv "PORT"))
 :use-default-middlewares nil)

