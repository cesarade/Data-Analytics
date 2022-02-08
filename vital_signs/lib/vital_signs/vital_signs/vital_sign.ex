defmodule VitalSigns.VitalSigns.VitalSign do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "vital_signs" do
    field :name, :string, null: false
    field :value_type, :string, null: false
    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :value_type])
    |> validate_required([:name, :value_type])
  end

end
