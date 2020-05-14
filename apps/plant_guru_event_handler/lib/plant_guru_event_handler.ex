defmodule PlantGuruEventHandler do
  @moduledoc """
  Documentation for `PlantGuruEventHandler`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> PlantGuruEventHandler.hello()
      :world

  """
  use Tortoise.Handler
  require Logger
  def init(args) do
    Logger.info("JKnakds")
    {:ok, args}
  end

  def connection(status, state) do
    # `status` will be either `:up` or `:down`; you can use this to
    # inform the rest of your system if the connection is currently
    # open or closed; tortoise should be busy reconnecting if you get
    # a `:down`
    Logger.info("jasd")
    {:ok, state}
  end

  #  topic filter room/+/temp
  def handle_message(["room", room, "temp"], payload, state) do
    # :ok = Temperature.record(room, payload)
    Logger.info("jasd")

    {:ok, state}
  end
  def handle_message(topic, payload, state) do
    # unhandled message! You will crash if you subscribe to something
    # and you don't have a 'catch all' matcher; crashing on unexpected
    # messages could be a strategy though.
    Logger.info("jasd")

    {:ok, state}
  end

  def subscription(status, topic_filter, state) do
    Logger.info("jasd")

    {:ok, state}
  end

  def terminate(reason, state) do
    # tortoise doesn't care about what you return from terminate/2,
    # that is in alignment with other behaviours that implement a
    # terminate-callback
    Logger.info("jasd")

    :ok
  end
end
