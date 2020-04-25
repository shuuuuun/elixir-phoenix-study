defmodule StudyAppWeb.TimelineChannel do
  require Logger
  use Phoenix.Channel
  # alias StudyApp.Timeline

  @stream_interval 1000

  defmodule State do
    defstruct timer: nil
  end

  def join("timeline:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("timeline:" <> _private_timeline_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("start_stream", _, socket) do
    # TODO: stopできるようにしないといけない
    # TODO: stream from file
    # Timeline.stream_each(fn datum -> push_stream(socket, Jason.encode!(datum)) end)
    {:noreply, socket}
  end

  def handle_in("start", _, socket) do
    start_stream(socket)
    {:noreply, socket}
  end

  def handle_in("stop", _, socket) do
    stop_stream(socket)
    {:noreply, socket}
  end

  defp start_stream(socket) do
    Logger.debug("start_stream")
    start_agent!(socket.id)
    Process.send_after(self(), :tick, 0)
  end

  defp stop_stream(socket) do
    Logger.debug("stop_stream")
    %State{timer: timer} = Agent.get(String.to_atom(socket.id), & &1)
    Process.cancel_timer(timer)
    :ok = Agent.update(String.to_atom(socket.id), fn _ -> %State{} end)
  end

  def handle_info(:tick, socket) do
    push_stream(socket, DateTime.utc_now())
    timer = Process.send_after(self(), :tick, @stream_interval)

    state = %State{
      timer: timer
    }

    :ok = Agent.update(String.to_atom(socket.id), fn _ -> state end)
    {:noreply, socket}
  end

  defp push_stream(socket, body) do
    Logger.debug("push_stream with #{inspect(socket)}")
    push(socket, "stream", %{body: body})
  end

  defp start_agent!(socket_id) do
    res = Agent.start_link(fn -> %State{} end, name: String.to_atom(socket_id))

    case res do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
      {:error, error} -> raise "Faild to start_link agent: #{inspect(error)}"
    end
  end
end
