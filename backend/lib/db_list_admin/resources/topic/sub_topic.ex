defmodule DbListAdmin.Resource.Topic.SubTopic do
  alias DbListAdmin.Model
  alias DbListAdmin.Repo
  import Ecto.Query

  def get_sub_topics do
    (from sub_topic in Model.SubTopic)
    |> Repo.all()
    |> Enum.map(fn item -> Model.SubTopic.remap(item) end)
    |> sub_topic_can_be_deleted()
  end

  def sub_topic_can_be_deleted(sub_topics) do
    connections = (from database_sub_topics in Model.DatabaseSubTopic,
    preload: [:sub_topic])
    |> Repo.all()
    |> Enum.map(fn item -> Map.get(Map.get(item, :sub_topic), :id) end)
    |> Enum.uniq()

    sub_topics
    |> Enum.map(fn sub_topic ->
      Map.put(sub_topic, :can_be_deleted, Enum.member?(connections, sub_topic[:id]) == false)
    end)
  end
end
