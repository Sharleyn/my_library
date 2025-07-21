defmodule MyLibraryWeb.AdminProfileLive.Show do
  use MyLibraryWeb, :live_view

  alias MyLibrary.Administration

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:admin_profile, Administration.get_admin_profile!(id))}
  end

  defp page_title(:show), do: "Show Admin profile"
  defp page_title(:edit), do: "Edit Admin profile"
end
