defmodule HousebookWeb.OutgoLive.Index do
  use HousebookWeb, :live_view

  alias Housebook.Outgos
  alias Housebook.Outgos.Outgo

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
    socket
    |> assign(:name, "")
    |> assign(:outgos, list_outgos("光熱費"))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Outgo")
    |> assign(:outgo, Outgos.get_outgo!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Outgo")
    |> assign(:outgo, %Outgo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Outgos")
    |> assign(:outgo, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    outgo = Outgos.get_outgo!(id)
    {:ok, _} = Outgos.delete_outgo(outgo)

    {:noreply, assign(socket, :outgos, list_outgos(""))}
  end

  defp list_outgos(name) do
    Outgos.list_outgos(name)
  end
end
