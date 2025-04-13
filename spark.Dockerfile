FROM --platform=$BUILDPLATFORM spark:3.5.1-java17-python3

USER root

RUN pip3 install pandas==1.4 pyarrow==10.0.0 numpy==1.26.4

USER spark