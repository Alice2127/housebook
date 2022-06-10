defmodule Housebook.Outgos.Outgo do
  use Ecto.Schema
  import Ecto.Changeset

  # 追加
  alias Housebook.Groups.Group

  schema "outgos" do
    # 追加
    belongs_to(:group, Group)
    # field :group_id, :integer
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
