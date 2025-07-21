defmodule MyLibrary.SettingsTest do
  use MyLibrary.DataCase

  alias MyLibrary.Settings

  describe "profiles" do
    alias MyLibrary.Settings.Profile

    import MyLibrary.SettingsFixtures

    @invalid_attrs %{name: nil, last_name: nil, no_tel: nil, ic_number: nil}

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Settings.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Settings.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      valid_attrs = %{name: "some name", last_name: "some last_name", no_tel: "some no_tel", ic_number: "some ic_number"}

      assert {:ok, %Profile{} = profile} = Settings.create_profile(valid_attrs)
      assert profile.name == "some name"
      assert profile.last_name == "some last_name"
      assert profile.no_tel == "some no_tel"
      assert profile.ic_number == "some ic_number"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      update_attrs = %{name: "some updated name", last_name: "some updated last_name", no_tel: "some updated no_tel", ic_number: "some updated ic_number"}

      assert {:ok, %Profile{} = profile} = Settings.update_profile(profile, update_attrs)
      assert profile.name == "some updated name"
      assert profile.last_name == "some updated last_name"
      assert profile.no_tel == "some updated no_tel"
      assert profile.ic_number == "some updated ic_number"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_profile(profile, @invalid_attrs)
      assert profile == Settings.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Settings.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Settings.change_profile(profile)
    end
  end
end
