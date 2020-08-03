FROM nodeshift/centos7-s2i-nodejs:10.x
LABEL "io.openshift.s2i.build.image"="docker://docker.io/centos/nodejs-10-centos7" \
      "io.openshift.s2i.scripts-url"="image:///usr/libexec/s2i"

USER root
# Copying in source code
COPY . /tmp/src
# Change file ownership to the assemble user. Builder image must support chown command.
RUN chown -R 1001:0 /tmp/src
USER 1001
# Assemble script sourced from builder image based on user input or image metadata.
# If this file does not exist in the image, the build will fail.
RUN /usr/libexec/s2i/assemble
# Run script sourced from builder image based on user input or image metadata.
# If this file does not exist in the image, the build will fail.
CMD /usr/libexec/s2i/run
