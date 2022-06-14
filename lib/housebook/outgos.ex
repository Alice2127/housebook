defmodule Housebook.Outgos do
  @moduledoc """
  The Outgos context.
  """

  import Ecto.Query, warn: false
  alias Housebook.Repo

  alias Housebook.Outgos.Outgo

  alias Housebook.Groups.Group

  @doc """
  Returns the list of outgos.

  ## Examples

      iex> list_outgos()
      [%Outgo{}, ...]

  """
  def list_outgos(name, page, page_size) do
   outgos =
    outgos_base_query(name)
     |> Repo.paginate(page: page, page_size: page_size)

     entries =
     outgos.entries
     |> Repo.preload(:group)

     outgos
     |> Map.put(:entries, entries)
     |> Debug.print("outgos")
  end



  # def list_outgos(name, page, page_size) do
  #   outgos_base_query(name)
  #   |> Repo.all()
  #   |> Repo.preload(:group)
  #   |> Repo.paginate(page: page, page_size: page_size)
  # end

  defp outgos_base_query(name) do
    from(outgo in Outgo,
      join: group in assoc(outgo, :group),
      where: like(group.name, ^"%#{name}%"),
      order_by: [desc: outgo.inserted_at, asc: group.id]
    )
  end

  @doc """
  Gets a single outgo.

  Raises `Ecto.NoResultsError` if the Outgo does not exist.

  ## Examples

      iex> get_outgo!(123)
      %Outgo{}

      iex> get_outgo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_outgo!(id), do: Repo.get!(Outgo, id)

  @doc """
  Creates a outgo.

  ## Examples

      iex> create_outgo(%{field: value})
      {:ok, %Outgo{}}

      iex> create_outgo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_outgo(attrs \\ %{}) do
    %Outgo{}
    |> Outgo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a outgo.

  ## Examples

      iex> update_outgo(outgo, %{field: new_value})
      {:ok, %Outgo{}}

      iex> update_outgo(outgo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_outgo(%Outgo{} = outgo, attrs) do
    outgo
    |> Outgo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a outgo.

  ## Examples

      iex> delete_outgo(outgo)
      {:ok, %Outgo{}}

      iex> delete_outgo(outgo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_outgo(%Outgo{} = outgo) do
    Repo.delete(outgo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking outgo changes.

  ## Examples

      iex> change_outgo(outgo)
      %Ecto.Changeset{data: %Outgo{}}

  """
  def change_outgo(%Outgo{} = outgo, attrs \\ %{}) do
    Outgo.changeset(outgo, attrs)
  end
end
