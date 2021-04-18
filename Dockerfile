FROM centos:7

ENV LC_ALL=en_US.utf-8 # Докер ругался на локализацию, пришлось сменить
ENV LANG=en_US.utf-8


RUN yum update -y \
  && yum install -y git \
  && yum install -y python3 python3-pip

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 5000
