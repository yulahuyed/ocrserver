FROM golang:1.9
ENV PORT 8080
MAINTAINER otiai10 <otiai10@gmail.com>

RUN apt-get -qq update
RUN apt-get install -y libleptonica-dev libtesseract-dev tesseract-ocr

# Load languages
RUN apt-get install -y \
  tesseract-ocr-chi-sim

ADD . $GOPATH/src/github.com/otiai10/ocrserver
WORKDIR $GOPATH/src/github.com/otiai10/ocrserver
RUN go get ./...
RUN go get -t github.com/otiai10/gosseract
RUN go test -v github.com/otiai10/gosseract
RUN chmod -R 777 $GOPATH
EXPOSE $PORT
CMD $GOPATH/bin/ocrserver
