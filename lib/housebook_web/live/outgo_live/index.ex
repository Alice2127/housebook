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
     |> assign(:page_size, 10)
     |> assign(:outgos, list_outgos("", "", ""))}
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

  @impl true
  def handle_event("update_page_size", params, socket) do
   page_size =
   params
   |> Map.get("page_size")

  socket =
   socket
   |> assign(:page_size, page_size)
   |> assign(:outgos, list_outgos("", 1, page_size))

    {:noreply, socket}

  end

  @impl true
  def handle_event("update_page", params, socket) do
    page =
    params
   |> Map.get("page")

   socket =
    socket
    |> assign(:page,  page)
    |> assign(:outgos, list_outgos("", page, ""))

      {:noreply, socket}
  end
       #ただし今のままだとページサイズを変えたあとページネーションで次へを押下するとページサイズがデフォルトの10件表示に戻ってしまう。


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

  #検索ボックスとページネーションの合体が必要
end
