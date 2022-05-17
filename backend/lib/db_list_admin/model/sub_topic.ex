defmodule DbListAdmin.Model.SubTopic do
  use Ecto.Schema
  import Ecto.Changeset
  alias DbListAdmin.Model

  schema "sub_topics" do
    field :name_en, :string
    field :name_sv, :string
    field :topic_id, :integer
    has_many :database_sub_topics, Model.DatabaseSubTopic
  end

  def remap(%Model.SubTopic{} = sub_topic) do
    %{
      id: sub_topic.id,
      topic_id: sub_topic.topic_id,
      name_en: sub_topic.name_en,
      name_sv: sub_topic.name_sv
    }
  end

  @doc false
  def changeset(%Model.SubTopic{} = sub_topic, attrs) do
    sub_topic
    |> cast(attrs, [:name_en, :name_sv])
    |> validate_required([:name_en, :name_sv])
  end
end
