defmodule MyLibrary.CredentialsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyLibrary.Credentials` context.
  """

  @doc """
  Generate a credential_profile.
  """
  def credential_profile_fixture(attrs \\ %{}) do
    {:ok, credential_profile} =
      attrs
      |> Enum.into(%{
        address: "some address",
        date_of_birth: ~D[2025-07-20],
        full_name: "some full_name",
        ic: "some ic",
        phone: "some phone",
        status: "some status"
      })
      |> MyLibrary.Credentials.create_credential_profile()

    credential_profile
  end
end
