
defmodule DbListAdmin.Resource.Topic.Create do
  alias DbListAdmin.Model
  alias DbListAdmin.Repo

  def create(data) do
    Model.Topic.changeset(%Model.Topic{}, data)
    |> Repo.insert()
    |> handle_response()
  end

  def handle_response({:error, reason}) do
    Model.Topic.remap_error(reason.errors)
  end

  def handle_response({:ok, result}) do
    Model.Topic.remap(result)
  end
end
