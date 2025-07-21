defmodule MyLibraryWeb.AdminProfileLive.Index do
  use MyLibraryWeb, :live_view

  alias MyLibrary.Administration
  alias MyLibrary.Administration.AdminProfile

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :admin_profiles, Administration.list_admin_profiles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Admin profile")
    |> assign(:admin_profile, Administration.get_admin_profile!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Admin profile")
    |> assign(:admin_profile, %AdminProfile{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Admin profiles")
    |> assign(:admin_profile, nil)
  end

  @impl true
  def handle_info({MyLibraryWeb.AdminProfileLive.FormComponent, {:saved, admin_profile}}, socket) do
    {:noreply, stream_insert(socket, :admin_profiles, admin_profile)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    admin_profile = Administration.get_admin_profile!(id)
    {:ok, _} = Administration.delete_admin_profile(admin_profile)

    {:noreply, stream_delete(socket, :admin_profiles, admin_profile)}
  end
end
