ARG DOCKER_IMAGE=alpine:latest
FROM $DOCKER_IMAGE

RUN apk add --no-cache python3 py3-setuptools make binutils git \
	&& git clone --recurse-submodules https://github.com/ShivamSarodia/ShivyC.git \
	&& cd ShivyC && python3 setup.py install && python3 -m unittest discover

LABEL author="Bensuperpc <bensuperpc@gmail.com>"
LABEL mantainer="Bensuperpc <bensuperpc@gmail.com>"

ARG VERSION="1.0.0"
ENV VERSION=$VERSION

#RUN shivyc -h

ENV CC=/usr/bin/shivyc
WORKDIR /usr/src/myapp

CMD ["shivyc", "-h"]

LABEL org.label-schema.schema-version="1.0" \
	  org.label-schema.build-date=$BUILD_DATE \
	  org.label-schema.name="bensuperpc/docker-shivyc" \
	  org.label-schema.description="build shivyc compiler" \
	  org.label-schema.version=$VERSION \
	  org.label-schema.vendor="Bensuperpc" \
	  org.label-schema.url="http://bensuperpc.com/" \
	  org.label-schema.vcs-url="https://github.com/Bensuperpc/docker-shivyc" \
	  org.label-schema.vcs-ref=$VCS_REF \
	  org.label-schema.docker.cmd="docker build -t bensuperpc/docker-shivyc -f Dockerfile ."
