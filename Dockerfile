FROM registry.fedoraproject.org/fedora-minimal:34

SHELL ["/bin/bash", "-c"]

ARG JDK_VERSION=11
RUN microdnf install -y \
  gettext \
  java-${JDK_VERSION}-openjdk \
  postgresql \
  mariadb \
  tar \
  tzdata \
  wget && \
  microdnf update -y && \
  microdnf clean all


ONBUILD ARG UID=1000
ONBUILD RUN useradd -d /java -l -m -Uu ${UID} -r -s /bin/bash java && \
  chown -R ${UID}:${UID} /java

ONBUILD USER ${UID}:${UID}
ONBUILD ENV JAVA_OPTS="-Djava.net.preferIPv4Stack=true -Xmx1024m -Xms1024m"
