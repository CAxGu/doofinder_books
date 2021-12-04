FROM elixir:1.12.3-alpine as build

# install build dependencies
RUN apk add --update git build-base nodejs npm yarn python3 libstdc++
# --no-cache

RUN mkdir /doofinder_books
WORKDIR /doofinder_books

# install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

# set build ENV
ENV MIX_ENV=prod


# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

# build assets
COPY assets assets
RUN mix assets.deploy $MIX_ENV
RUN mix hex.build
RUN mix phx.digest

# build project
COPY priv priv
COPY lib lib
RUN mix compile $MIX_ENV

# build release
# at this point we should copy the rel directory but
# we are not using it so we can omit it
# COPY rel rel
RUN mix release

# prepare release image
FROM alpine:3.14.2 AS doofinder_books
#RUN groupadd -r doocker_books && useradd -r -g doocker_books doocker_books
# addgroup [-g GID] [-S] [USER] GROUP
# adduser [OPTIONS] USER [GROUP]
#RUN addgroup --system doofinder_books && adduser --system doofinder_books doofinder_books
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --no-create-home \
    --system \
    doofinder_books

# install runtime dependencies
RUN apk add --update bash openssl postgresql-client libstdc++

EXPOSE 4000
ENV MIX_ENV=prod

# prepare doofinder_books directory
RUN mkdir /doofinder_books
WORKDIR /doofinder_books

# copy release to doofinder_books container
COPY --from=build /doofinder_books/_build/prod/rel/doofinder_books .
COPY doofinderbooks_entry.sh .
RUN chown -R doofinder_books: /doofinder_books
USER doofinder_books 

ENV HOME=/doofinder_books
CMD ["bash", "/doofinder_books/doofinderbooks_entry.sh"]