defmodule Housebook.Outgos.Outgo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "outgos" do
    field :group_id, :integer
    field :payment, :integer

    timestamps()
  end

  @doc false
  def changeset(outgo, attrs) do
    outgo
    |> cast(attrs, [:group_id, :payment])
    |> validate_required([:group_id, :payment])
  end
end
