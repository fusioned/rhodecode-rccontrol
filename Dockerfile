FROM centos:7
LABEL maintainer="cyrill.kulka@gmail.com"

ENV RC_INSTALLER    RhodeCode-installer-linux-build20180517_1100
ENV RC_CHECKSUM     36d45b569511b7373e408a1c804c7140bcfb3f8c75f1d22eb7ee4e9c2103bd16

# Create the RhodeCode user
RUN useradd rhodecode -u 1000 -s /sbin/nologin				\
		&& mkdir -m 0755 -p /opt/rhodecode /data			\
		&& chown rhodecode:rhodecode /opt/rhodecode /data	\
		&& yum install -y bzip2 postgresql					\
		&& curl -so /usr/local/bin/crudini https://raw.githubusercontent.com/pixelb/crudini/0.9/crudini \
		&& chmod +x /usr/local/bin/crudini

USER rhodecode
WORKDIR /home/rhodecode

# Install RhodeCode Control
RUN curl -so $RC_INSTALLER https://dls-eu.rhodecode.com/dls/NzA2MjdhN2E2ODYxNzY2NzZjNDA2NTc1NjI3MTcyNzA2MjcxNzIyZTcwNjI3YQ==/rhodecode-control/latest-linux-ce \
		&& echo "$RC_CHECKSUM *$RC_INSTALLER" |  sha256sum -c -	\
		&& chmod 755 $RC_INSTALLER								\
		&& ./$RC_INSTALLER --accept-license						\
		&& rm $RC_INSTALLER

# Add additional tools
COPY --chown=rhodecode:rhodecode files .
RUN  chmod 755 *.sh
