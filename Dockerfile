FROM public.ecr.aws/lambda/python:3.11
COPY requirements.txt ${LAMBDA_TASK_ROOT}
RUN pip3 install --user -r requirements.txt
COPY src/ ${LAMBDA_TASK_ROOT}
ENV GOOGLE_APPLICATION_CREDENTIALS=${LAMBDA_TASK_ROOT}/service-account-key.json
COPY .cbtrc /tmp
RUN yum install -y tar gzip unzip && \
    yum clean all
RUN mkdir -p /opt
WORKDIR /opt
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-504.0.0-linux-x86_64.tar.gz && \
    tar -xf google-cloud-cli-504.0.0-linux-x86_64.tar.gz && \
    ./google-cloud-sdk/install.sh --quiet && \
    rm google-cloud-cli-504.0.0-linux-x86_64.tar.gz
ENV PATH=$PATH:/opt/google-cloud-sdk/bin
RUN gcloud components install cbt --quiet

CMD ["app.handler"]