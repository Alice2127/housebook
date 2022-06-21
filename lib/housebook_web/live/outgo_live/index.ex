defmodule HousebookWeb.OutgoLive.Index do
  use HousebookWeb, :live_view

  alias Housebook.Outgos
  alias Housebook.Outgos.Outgo


  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:name, "")
     |> assign(:page_size, 10)
     |> assign(:outgos, list_outgos(params))}
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
    |> assign(:payment,  sum_payments())
  end

  @impl true
  def handle_event("delete", params = %{"id" => id}, socket) do
    outgo = Outgos.get_outgo!(id)
    {:ok, _} = Outgos.delete_outgo(outgo)

    {:noreply, assign(socket, :outgos, list_outgos(params))}
  end

  @impl true
  def handle_event("update_page_size", params, socket) do
   page_size =
   params
   |> Map.get("page_size")

   params =
    params
    |> Map.put("name", socket.assigns.name)

  socket =
   socket
   |> assign(:page_size, String.to_integer(page_size))
   |> assign(:outgos, list_outgos(params))

    {:noreply, socket}

  end

  @impl true
  def handle_event("update_page", params, socket) do
    page =
    params
   |> Map.get("page")

   params =
    params
    |> Map.put("name", socket.assigns.name)

   socket =
    socket
    |> assign(:page,  page)
    |> assign(:outgos, list_outgos(params))

      {:noreply, socket}
  end


  @impl true
  def handle_event("search", params, socket) do
    name = params["name"]

    {:noreply,
     socket
     |> assign(:name, name)
     |> assign(:outgos, list_outgos(params))}
  end

  defp list_outgos(params) do
    name = Map.get(params, "name") || ""
    page = Map.get(params, "page") || "1"
    page_size = Map.get(params, "page_size") || "10"

   Outgos.list_outgos(name, page, page_size)
  end


  def sum_payments() do
   Outgos.sum_payments()
  end
end
