#FROM python:3.9.1
#ADD . /python-flask
#WORKDIR /python-flask
#RUN pip install -r requirements.txt

FROM ubuntu:18.04
RUN apt update && apt install -y libncurses5 libxext6 libxt6 python-pip curl wget && mkdir -p /opt/mcr
#RUN curl https://ssd.mathworks.com/supportfiles/downloads/R2021a/Release/5/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2021a_Update_5_glnxa64.zip -o matlab_2021a_runtime.zip
RUN wget wget -O matlab_2021a_runtime.zip https://ssd.mathworks.com/supportfiles/downloads/R2021a/Release/5/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2021a_Update_5_glnxa64.zip \
  && unzip matlab_2021a_runtime.zip \
  && install -mode silent -agreeToLicense yes -destinationFolder /opt/mcr \
  && rm matlab_2021a_runtime.zip

ENV LD_LIBRARY_PATH /opt/mcr/v910/runtime/glnxa64:/opt/mcr/v910/bin/glnxa64:/opt/mcr/v910/sys/os/glnxa64

RUN pip install flask
RUN pip install flask_restful
RUN pip install requests
RUN pip install uwsgi

RUN useradd --no-create-home uwsgi

EXPOSE 5000

#the scripts
WORKDIR /app

COPY . /app/

CMD [ "python", "main.py" ]