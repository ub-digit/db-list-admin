defmodule Experiment do
  alias DbListAdmin.Model
  alias DbListAdmin.Repo
  import Ecto.Query


  def test do
    sub_topics = DbListAdmin.Resource.Topic.get_sub_topics()
    |> Enum.group_by(fn item -> item[:topic_id] end)
    DbListAdmin.Resource.Topic.get_topics()
    |> Enum.map(fn item -> Map.put(item, :sub_topics, sub_topics[item[:id]]) end)
  end

end
