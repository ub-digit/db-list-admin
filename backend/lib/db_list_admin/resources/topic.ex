
defmodule DbListAdmin.Resource.Topic do
  alias DbListAdmin.Model
  alias DbListAdmin.Repo
  import Ecto.Query

  def get_topics() do
      (from topic in Model.Topic)
      |> Repo.all
      |> Enum.map(fn item -> DbListAdmin.Model.Topic.remap(item) end)
      #|> Enum.map(fn item -> Databases.Resource.Topic.add_child_topics(item, lang) end)
  end

  #def add_child_topics(%{} = topic, lang) do
  #    children = Repo.all(from sub_topic in Model.SubTopic,
  #    where: sub_topic.topic_id == ^topic.id)
  #    |> Enum.map(fn item -> Databases.Model.SubTopic.remap(item, lang) end)
  #    %{
  #        name: topic.name,
  #        id: topic.id,
  #        sub_topics: children
  #    }
  #end
end
