defmodule Theme01.AcountTest do
  use Theme01.DataCase

  alias Theme01.Acount

  describe "users" do
    alias Theme01.Acount.User

    @valid_attrs %{"": "some ", email: "some email", username: "some username"}
    @update_attrs %{"": "some updated ", email: "some updated email", username: "some updated username"}
    @invalid_attrs %{"": nil, email: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Acount.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Acount.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Acount.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Acount.create_user(@valid_attrs)
      assert user. == "some "
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Acount.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Acount.update_user(user, @update_attrs)
      assert user. == "some updated "
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Acount.update_user(user, @invalid_attrs)
      assert user == Acount.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Acount.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Acount.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Acount.change_user(user)
    end
  end
end
