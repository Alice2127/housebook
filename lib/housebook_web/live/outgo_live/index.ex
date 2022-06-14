defmodule HousebookWeb.OutgoLive.Index do
  use HousebookWeb, :live_view

  alias Housebook.Outgos
  alias Housebook.Outgos.Outgo

   @default_page 1
   @default_page_size 10

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:name, "")
     |> assign(:outgos, list_outgos("", 1, 5))} #次に、ここを変数化したい。
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
    # |> assign(:outgos, list_outgos(params)) #★引数の数が違くない？
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    outgo = Outgos.get_outgo!(id)
    {:ok, _} = Outgos.delete_outgo(outgo)

    {:noreply, assign(socket, :outgos, list_outgos("", "", ""))}
  end

  # @impl true
  # def handle_event("update_page", %{"page" => page}, socket) do
  #   params =
  #     socket.assigns
  #     |> Map.get(:outgos)
  #     |> Map.take([:page_number, :page_size])
  #     |> Map.merge(%{page_number: page})
  #     |> Keyword.new()

  #   {:noreply,
  #    push_redirect(socket,
  #      to: Routes.outgo_index_path(socket, :index, params)
  #    )} #★リダイレクト先はindexだと思うけど引数そのままでいいんかな？
  # end

  @impl true
  def handle_event("update_page_size", %{"page_size" => page_size}, socket) do
    params =
      socket.assigns
      |> Map.get(:outgos)
      |> Map.take([:page_number, :page_size])
      |> Map.merge(%{page_size: 5})
      |> Keyword.new()

    {:noreply,
     push_redirect(socket,
       to: Routes.outgo_index_path(socket, :index, params)
     )}
  end


  @impl true
  def handle_event("search", params, socket) do
    name = params["name"]

    {:noreply,
     socket
     |> assign(:name, name)
     |> assign(:outgos, list_outgos(name, "", ""))}
  end

  defp list_outgos(name, page, page_size) do
    Outgos.list_outgos(name, page, page_size)
  end

  # defp list_outgos(%{"page_number" => page, "page_size" => page_size}) do
  #   Outgos.list_outgos(page, page_size)
  # end

  # defp list_outgos(%{"page_number" => page}) do
  #   Outgos.list_outgos(page, @default_page_size)
  # end

  # defp list_outgos(%{"page_size" => page_size}) do
  #   Outgos.list_outgos(@default_page, page_size)
  # end

  # defp list_outgos(%{}) do
  #   Outgos.list_outgos()
  # end

  #分岐、引数の数が変な気がする...
end
