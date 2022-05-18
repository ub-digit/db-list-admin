
defmodule DbListAdmin.Resource.Topic.Create do
  alias DbListAdmin.Model
  alias DbListAdmin.Repo
  alias Ecto.Multi
  alias DbListAdmin.Resource.Topic.SubTopic

  def create(data) do
    Multi.new()
    |> Multi.run(:topic, fn repo, _ ->
      Model.Topic.changeset(Model.Topic.find(data["id"]), data)
      |> repo.insert_or_update()
      |> case do
        {:ok, res} -> {:ok, Model.Topic.remap(res)}
        {:error, reason} -> {:error, Model.Topic.remap_error(reason.errors)}
      end
    end)
    |> Multi.run(:sub_topics, fn repo, %{topic: %{id: topic_id}} ->
      results = Enum.map(data["sub_topics"], fn sub_topic -> SubTopic.Create.create(repo, topic_id, sub_topic) end)
      |> IO.inspect()
      results
      |> Enum.any?(fn result -> elem(result, 0) == :error end)
      |> case do
        true -> {:error, results}
        false -> {:ok, results}
      end
    end)
    |> Multi.run(:rollback, fn repo, seq ->
      IO.inspect(seq)
      repo.rollback({:error, :deliberate}) end)
    |> Repo.transaction()
  end
end
