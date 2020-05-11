FROM balenalib/raspberrypi3-alpine

RUN install_packages wget git apt-utils

# Install Elixir
RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
RUN apt-get update
RUN install_packages esl-erlang elixir

CMD ["bash", "start.sh"]