# Nginx source Docker image

    $ git clone https://github.com/nevstokes/docker-nginx-src.git
    $ cd docker-nginx-src

In order to build the `mainline` or `stable` nginx source:

    $ make mainline
    $ make stable

The resulting Docker image will be tagged accordingly (i.e. `nevstokes/nginx-src:mainline` or `nevstokes/nginx-src:stable`).

Building directly with the `Dockerfile` will default to the `mainline` version.

These images are intended to be used in a multistage Docker build:

    FROM nevstokes/nginx-src:mainline AS src
    
    FROM alpine
    COPY --from=src nginx.tar.gz .
    
    # untar, configure and build as required 
