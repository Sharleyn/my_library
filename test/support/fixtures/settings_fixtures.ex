defmodule MyLibrary.SettingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyLibrary.Settings` context.
  """

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> Enum.into(%{
        ic_number: "some ic_number",
        last_name: "some last_name",
        name: "some name",
        no_tel: "some no_tel"
      })
      |> MyLibrary.Settings.create_profile()

    profile
  end
end
