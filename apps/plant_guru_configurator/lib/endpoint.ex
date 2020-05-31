defmodule PlantGuruConfigurator.Endpoint do
    @moduledoc """
    A Plug responsible for logging request info, parsing request body's as JSON,
    matching routes, and dispatching responses.
    """

    use Plug.Router
    require Logger

    # This module is a Plug, that also implements it's own plug pipeline, below:

    # Using Plug.Logger for logging request information
    plug(Plug.Logger)
    # responsible for matching routes
    plug(:match)
    # Using Poison for JSON decoding
    # Note, order of plugs is important, by placing this _after_ the 'match' plug,
    # we will only parse the request AFTER there is a route match.
    plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
    # responsible for dispatching responses
    plug(:dispatch)

    # A simple route to test that the server is up
    # Note, all routes must return a connection as per the Plug spec.
    get "/ping" do
      send_resp(conn, 200, System.get_env("BALENA_DEVICE_UUID"))
    end

    # Handle incoming events, if the payload is the right shape, process the
    # events, otherwise return an error.
    post "/events" do
      {status, body} =
        case conn.body_params do
          %{"events" => events} -> {200, process_events(events)}
          _ -> {422, missing_events()}
        end

      send_resp(conn, status, body)
    end

    defp process_events(events) when is_list(events) do
      # Do some processing on a list of events
      Jason.encode!(%{response: "Received Events!"})
    end

    defp process_events(_) do
      # If we can't process anything, let them know :)
      Jason.encode!(%{response: "Please Send Some Events!"})
    end

    defp missing_events do
        Jason.encode!(%{error: "Expected Payload: { 'events': [...] }"})
    end

    # A catchall route, 'match' will match no matter the request method,
    # so a response is always returned, even if there is no route to match.
    match _ do
      send_resp(conn, 404, "oops... Nothing here :(")
    end
  end