defmodule DbListAdmin.Model.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias DbListAdmin.Model
  alias DbListAdmin.Repo

  schema "topics" do
    field :name_en, :string
    field :name_sv, :string
    timestamps()
    has_many :database_topics, Model.DatabaseTopic
  end

  def remap(%Model.Topic{} = topic) do
    %{
      id: topic.id,
      name_en: topic.name_en,
      name_sv: topic.name_sv,
      updated_at: topic.updated_at
    }
  end

  def remap_error(error) do
    error_list =
    error
    |> IO.inspect(label: "Error")
    |> Enum.map(fn {k, {_, reason}} ->
        {r1, r2} = List.first(reason)
        %{:field => k, :error_code => Atom.to_string(r1) <> "_" <> Atom.to_string(r2)}
      end)

    %{
      error: %{
        topic: error_list
      }
    }
  end

  def find(id) when is_nil(id), do: %Model.Topic{}
  def find(id) do
    Repo.get!(Model.Topic, id)
  end

  @doc false
  def changeset(%Model.Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:name_en, :name_sv])
    |> validate_required([:name_en, :name_sv])
    |> unique_constraint(:name_en, name: :topics_name_en_key)
    |> unique_constraint(:name_sv, name: :topics_name_sv_key)
  end
end
