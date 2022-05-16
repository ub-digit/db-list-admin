defmodule DbListAdmin.Model.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias DbListAdmin.Model

  schema "topics" do
    field :name_en, :string
    field :name_sv, :string
    timestamps()
    #has_many :database_topics, Model.DatabaseTopic
  end

  def remap(%{} = topic) do
    %{
      id: topic.id,
      name_en: topic.name_en,
      name_sv: topic.name_sv,
      updated_at: topic.updated_at
    }
  end

  @doc false
  def changeset(%Model.Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:name_en, :name_sv])
    |> validate_required([:name_en, :name_sv])
  end
end
