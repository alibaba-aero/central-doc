FROM rust

ARG VERSION

RUN cargo install --vers "$VERSION" mdbook --no-default-features

RUN apt update

RUN apt install nginx -y

copy . /app

# fetch docs
RUN sh /app/lib/fetch.sh

RUN mdbook build -d /var/www/html /app

CMD ["nginx", "-g", "daemon off;"]

expose 80