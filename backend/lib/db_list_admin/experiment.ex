defmodule Experiment do
  alias DbListAdmin.Model
  alias DbListAdmin.Repo
  import Ecto.Query


  def test() do
    data = %{
      "id" => 353,
      "name_sv" => "Namn topic",
      "name_en" => "Namn topic en",
      "sub_topics" => [
        %{"name_sv" => "sub topic 1 sv", "name_en" => "sub topic 1 en"},
        %{"name_sv" => "sub topic 2 sv", "name_en" => "sub topic 2 en"},
        %{"name_sv" => "sub topic 3 sv", "name_en" => "sub topic 3 en"}
      ]
    }
    DbListAdmin.Resource.Topic.Create.create(data)
  end

end
