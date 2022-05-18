defmodule DbListAdmin.Resource.Topic.SubTopic.Create do
  alias DbListAdmin.Model

  def create(repo, topic_id, data) do
    data = Map.put(data, "topic_id", topic_id)
    repo.insert_or_update(Model.SubTopic.changeset(Model.SubTopic.find(data["id"]), data))
    |> case do
      {:ok, res} -> {:ok, Model.SubTopic.remap(res)}
      {:error, error} -> {:error, Model.SubTopic.remap_error(error.errors)}
    end
  end
end
