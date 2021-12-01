defmodule DoofinderBooks.DPruebasTest do
  use DoofinderBooks.DataCase

  alias DoofinderBooks.DPruebas

  describe "pruebas" do
    alias DoofinderBooks.DPruebas.Prueba

    import DoofinderBooks.DPruebasFixtures

    @invalid_attrs %{holaquetal: nil}

    test "list_pruebas/0 returns all pruebas" do
      prueba = prueba_fixture()
      assert DPruebas.list_pruebas() == [prueba]
    end

    test "get_prueba!/1 returns the prueba with given id" do
      prueba = prueba_fixture()
      assert DPruebas.get_prueba!(prueba.id) == prueba
    end

    test "create_prueba/1 with valid data creates a prueba" do
      valid_attrs = %{holaquetal: []}

      assert {:ok, %Prueba{} = prueba} = DPruebas.create_prueba(valid_attrs)
      assert prueba.holaquetal == []
    end

    test "create_prueba/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DPruebas.create_prueba(@invalid_attrs)
    end

    test "update_prueba/2 with valid data updates the prueba" do
      prueba = prueba_fixture()
      update_attrs = %{holaquetal: []}

      assert {:ok, %Prueba{} = prueba} = DPruebas.update_prueba(prueba, update_attrs)
      assert prueba.holaquetal == []
    end

    test "update_prueba/2 with invalid data returns error changeset" do
      prueba = prueba_fixture()
      assert {:error, %Ecto.Changeset{}} = DPruebas.update_prueba(prueba, @invalid_attrs)
      assert prueba == DPruebas.get_prueba!(prueba.id)
    end

    test "delete_prueba/1 deletes the prueba" do
      prueba = prueba_fixture()
      assert {:ok, %Prueba{}} = DPruebas.delete_prueba(prueba)
      assert_raise Ecto.NoResultsError, fn -> DPruebas.get_prueba!(prueba.id) end
    end

    test "change_prueba/1 returns a prueba changeset" do
      prueba = prueba_fixture()
      assert %Ecto.Changeset{} = DPruebas.change_prueba(prueba)
    end
  end
end
