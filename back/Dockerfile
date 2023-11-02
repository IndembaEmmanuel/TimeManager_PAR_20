FROM elixir:latest

WORKDIR /app

COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY . .
RUN mix compile

EXPOSE 4000

