defmodule MyLibrary.AdministrationTest do
  use MyLibrary.DataCase

  alias MyLibrary.Administration

  describe "admin_profiles" do
    alias MyLibrary.Administration.AdminProfile

    import MyLibrary.AdministrationFixtures

    @invalid_attrs %{status: nil, address: nil, full_name: nil, ic: nil, phone: nil, date_of_birth: nil}

    test "list_admin_profiles/0 returns all admin_profiles" do
      admin_profile = admin_profile_fixture()
      assert Administration.list_admin_profiles() == [admin_profile]
    end

    test "get_admin_profile!/1 returns the admin_profile with given id" do
      admin_profile = admin_profile_fixture()
      assert Administration.get_admin_profile!(admin_profile.id) == admin_profile
    end

    test "create_admin_profile/1 with valid data creates a admin_profile" do
      valid_attrs = %{status: "some status", address: "some address", full_name: "some full_name", ic: "some ic", phone: "some phone", date_of_birth: ~D[2025-07-20]}

      assert {:ok, %AdminProfile{} = admin_profile} = Administration.create_admin_profile(valid_attrs)
      assert admin_profile.status == "some status"
      assert admin_profile.address == "some address"
      assert admin_profile.full_name == "some full_name"
      assert admin_profile.ic == "some ic"
      assert admin_profile.phone == "some phone"
      assert admin_profile.date_of_birth == ~D[2025-07-20]
    end

    test "create_admin_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Administration.create_admin_profile(@invalid_attrs)
    end

    test "update_admin_profile/2 with valid data updates the admin_profile" do
      admin_profile = admin_profile_fixture()
      update_attrs = %{status: "some updated status", address: "some updated address", full_name: "some updated full_name", ic: "some updated ic", phone: "some updated phone", date_of_birth: ~D[2025-07-21]}

      assert {:ok, %AdminProfile{} = admin_profile} = Administration.update_admin_profile(admin_profile, update_attrs)
      assert admin_profile.status == "some updated status"
      assert admin_profile.address == "some updated address"
      assert admin_profile.full_name == "some updated full_name"
      assert admin_profile.ic == "some updated ic"
      assert admin_profile.phone == "some updated phone"
      assert admin_profile.date_of_birth == ~D[2025-07-21]
    end

    test "update_admin_profile/2 with invalid data returns error changeset" do
      admin_profile = admin_profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Administration.update_admin_profile(admin_profile, @invalid_attrs)
      assert admin_profile == Administration.get_admin_profile!(admin_profile.id)
    end

    test "delete_admin_profile/1 deletes the admin_profile" do
      admin_profile = admin_profile_fixture()
      assert {:ok, %AdminProfile{}} = Administration.delete_admin_profile(admin_profile)
      assert_raise Ecto.NoResultsError, fn -> Administration.get_admin_profile!(admin_profile.id) end
    end

    test "change_admin_profile/1 returns a admin_profile changeset" do
      admin_profile = admin_profile_fixture()
      assert %Ecto.Changeset{} = Administration.change_admin_profile(admin_profile)
    end
  end
end
