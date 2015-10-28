FROM scratch
ADD echod /tmp/
EXPOSE 23000
CMD ["/tmp/echod"]
