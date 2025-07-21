defmodule MyLibraryWeb.AdminProfileLive.FormComponent do
  use MyLibraryWeb, :live_component

  alias MyLibrary.Administration

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage admin_profile records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="admin_profile-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:full_name]} type="text" label="Full name" />
        <.input field={@form[:ic]} type="text" label="Ic" />
        <.input field={@form[:status]} type="text" label="Status" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:date_of_birth]} type="date" label="Date of birth" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Admin profile</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{admin_profile: admin_profile} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Administration.change_admin_profile(admin_profile))
     end)}
  end

  @impl true
  def handle_event("validate", %{"admin_profile" => admin_profile_params}, socket) do
    changeset = Administration.change_admin_profile(socket.assigns.admin_profile, admin_profile_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"admin_profile" => admin_profile_params}, socket) do
    save_admin_profile(socket, socket.assigns.action, admin_profile_params)
  end

  defp save_admin_profile(socket, :edit, admin_profile_params) do
    case Administration.update_admin_profile(socket.assigns.admin_profile, admin_profile_params) do
      {:ok, admin_profile} ->
        notify_parent({:saved, admin_profile})

        {:noreply,
         socket
         |> put_flash(:info, "Admin profile updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_admin_profile(socket, :new, admin_profile_params) do
    case Administration.create_admin_profile(admin_profile_params) do
      {:ok, admin_profile} ->
        notify_parent({:saved, admin_profile})

        {:noreply,
         socket
         |> put_flash(:info, "Admin profile created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
