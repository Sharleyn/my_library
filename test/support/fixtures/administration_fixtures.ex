defmodule MyLibrary.AdministrationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyLibrary.Administration` context.
  """

  def unique_admin_email, do: "admin#{System.unique_integer()}@example.com"
  def valid_admin_password, do: "hello world!"

  def valid_admin_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_admin_email(),
      password: valid_admin_password()
    })
  end

  def admin_fixture(attrs \\ %{}) do
    {:ok, admin} =
      attrs
      |> valid_admin_attributes()
      |> MyLibrary.Administration.register_admin()

    admin
  end

  def extract_admin_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

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
      |> MyLibrary.Administration.create_profile()

    profile
  end

  @doc """
  Generate a admin_profile.
  """
  def admin_profile_fixture(attrs \\ %{}) do
    {:ok, admin_profile} =
      attrs
      |> Enum.into(%{
        address: "some address",
        date_of_birth: ~D[2025-07-20],
        full_name: "some full_name",
        ic: "some ic",
        phone: "some phone",
        status: "some status"
      })
      |> MyLibrary.Administration.create_admin_profile()

    admin_profile
  end
end
