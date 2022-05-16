defmodule DbListAdminWeb.TopicsController do
  use DbListAdminWeb, :controller

  def index(conn, _params) do
    json conn, DbListAdmin.Resource.Topic.get_topics
  end
end
