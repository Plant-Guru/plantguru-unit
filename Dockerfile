FROM balenalib/raspberrypi3-debian

LABEL maintainer="sebigrebe@gmail.com"

RUN install_packages apt-utils wget git

# Install Elixir
RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
RUN rm erlang-solutions_2.0_all.deb
RUN apt-get update
RUN install_packages esl-erlang elixir build-essential
RUN mix local.hex --force && mix local.rebar --force

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN mix deps.get

EXPOSE 80
CMD ["mix", "run", "--no-halt"]