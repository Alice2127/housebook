defmodule HousebookWeb.OutgoLive.FormComponent do
  use HousebookWeb, :live_component

  alias Housebook.Outgos

  @impl true
  def update(%{outgo: outgo} = assigns, socket) do
    changeset = Outgos.change_outgo(outgo)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"outgo" => outgo_params}, socket) do
    changeset =
      socket.assigns.outgo
      |> Outgos.change_outgo(outgo_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"outgo" => outgo_params}, socket) do
    save_outgo(socket, socket.assigns.action, outgo_params)
  end

  defp save_outgo(socket, :edit, outgo_params) do
    case Outgos.update_outgo(socket.assigns.outgo, outgo_params) do
      {:ok, _outgo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Outgo updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_outgo(socket, :new, outgo_params) do
    case Outgos.create_outgo(outgo_params) do
      {:ok, _outgo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Outgo created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
