defmodule ScAgent do
  alias PhoenixClient.{Socket, Channel, Message}
  @moduledoc """
  Documentation for ScAgent.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ScAgent.hello()
      :world

  """
  def wait_for_socket(socket) do
    unless Socket.connected?(socket) do
      wait_for_socket(socket)
    end
  end

  def hello do
    socket_opts = [
      url: "ws://192.168.1.103:4000/socket/websocket",
      reconnect_interval: 5000
    ]
    {:ok, socket} = PhoenixClient.Socket.start_link(socket_opts)
    wait_for_socket(socket)
    {:ok, _response, channel} = PhoenixClient.Channel.join(socket, "room:lobby")
    message = %{body: "Ok run some kind of command."}
    PhoenixClient.Channel.push_async(channel, "new_msg", message)
  end

  def handle_info(%Message{event: "incoming:msg", payload: payload}, state) do
    IO.puts "Incoming Message: #{inspect payload}"
    {:noreply, state}
  end


end