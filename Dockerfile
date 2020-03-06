FROM debian:sid

RUN apt-get update && apt-get install -y build-essential devscripts git-buildpackage lintian quilt equivs

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
