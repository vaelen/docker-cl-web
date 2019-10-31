FROM debian:stable

MAINTAINER Andrew Young <andrew@vaelen.org>

RUN apt-get update && apt-get upgrade -y && apt-get autoremove
RUN apt-get install -y build-essential
RUN apt-get install -y curl libcurl4-openssl-dev
RUN apt-get install -y libev-dev
RUN apt-get install -y sbcl
RUN apt-get install -y ecl

WORKDIR /lisp

RUN curl -o /tmp/quicklisp.lisp 'https://beta.quicklisp.org/quicklisp.lisp' && \
        sbcl --noinform --non-interactive --load /tmp/quicklisp.lisp --eval \
        "(quicklisp-quickstart:install)" && \
        sbcl --noinform --non-interactive --load ~/quicklisp/setup.lisp --eval \
        '(ql-util:without-prompting (ql:add-to-init-file))' && \
        echo '#+quicklisp(push "/src" ql:*local-project-directories*)' >> ~/.sbclrc && \
        rm -f /tmp/quicklisp.lisp

RUN sbcl --eval '(ql:quickload :woo)' --quit
RUN sbcl --eval '(ql:quickload :clack)' --quit

COPY src/* /lisp/

ENV PORT 5000
EXPOSE 5000

CMD ["--noinform", "--noprint", "--disable-debugger", "--load", "run.lisp"]
ENTRYPOINT ["sbcl"]
