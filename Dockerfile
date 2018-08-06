FROM alpine:3.6

RUN apk --no-cache add docker jq

COPY entry_point.sh .

ENTRYPOINT [ "./entry_point.sh" ]
