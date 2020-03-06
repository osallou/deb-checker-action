FROM debian:sid

RUN apt-get update && apt-get install -y build-essential devscripts git-buildpackage lintian quilt

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
