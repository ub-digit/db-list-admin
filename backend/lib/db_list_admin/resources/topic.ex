
defmodule DbListAdmin.Resource.Topic do
  alias DbListAdmin.Model
  alias DbListAdmin.Repo
  alias DbListAdmin.Resource.Topic.SubTopic
  import Ecto.Query

  def get_topics() do
      (from topic in Model.Topic)
      |> Repo.all()
      |> Enum.map(fn item -> DbListAdmin.Model.Topic.remap(item) end)
      |> topic_can_be_deleted()
  end

  def get_topics_with_sub_topics do
    sub_topics = SubTopic.get_sub_topics()
    |> Enum.group_by(fn item -> item[:topic_id] end)
    get_topics()
    |> Enum.map(fn item -> Map.put(item, :sub_topics, sub_topics[item[:id]]) end)
  end

  @spec topic_can_be_deleted(any) :: list
  def topic_can_be_deleted(topics) do
    connections = (from database_topics in Model.DatabaseTopic,
    preload: [:topic])
    |> Repo.all()
    |> Enum.map(fn item -> Map.get(Map.get(item, :topic), :id) end)
    |> Enum.uniq()

    topics
    |> Enum.map(fn topic ->
      Map.put(topic, :can_be_deleted, Enum.member?(connections, topic[:id]) == false)
    end)
  end


end
