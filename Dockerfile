FROM centos:7

ENV LC_ALL=en_US.utf-8
ENV LANG=en_US.utf-8


RUN yum update -y \
  && yum install -y git \
  && yum install -y python3 python3-pip

RUN git clone https://github.com/ArtemyRadostev/student-exam2.git \
                && cd student-exam2 \
                && pip3 install -e .

ENV FLASK_APP=js_example

ENTRYPOINT ["flask","run","-h","0.0.0.0","-p","5000"]
EXPOSE 5000
