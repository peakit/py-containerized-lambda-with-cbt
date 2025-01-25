FROM public.ecr.aws/lambda/python:3.11
COPY requirements.txt ${LAMBDA_TASK_ROOT}
RUN pip3 install --user -r requirements.txt
COPY src/app.py ${LAMBDA_TASK_ROOT}
RUN dnf install -y tar gzip unzip && \
    dnf clean all
RUN mkdir -p /opt
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-504.0.0-linux-x86_64.tar.gz && \
    tar -xf google-cloud-cli-504.0.0-linux-x86_64.tar.gz && \
    ./google-cloud-sdk/install.sh --quiet && \
    rm google-cloud-cli-504.0.0-linux-x86_64.tar.gz
ENV PATH=$PATH:/opt/google-cloud-sdk/bin
RUN gcloud components install cbt --quiet

CMD ["app.handler"]