defmodule DoofinderBooksWeb.PruebaControllerTest do
  use DoofinderBooksWeb.ConnCase

  import DoofinderBooks.DPruebasFixtures

  @create_attrs %{holaquetal: []}
  @update_attrs %{holaquetal: []}
  @invalid_attrs %{holaquetal: nil}

  describe "index" do
    test "lists all pruebas", %{conn: conn} do
      conn = get(conn, Routes.prueba_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pruebas"
    end
  end

  describe "new prueba" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.prueba_path(conn, :new))
      assert html_response(conn, 200) =~ "New Prueba"
    end
  end

  describe "create prueba" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.prueba_path(conn, :create), prueba: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.prueba_path(conn, :show, id)

      conn = get(conn, Routes.prueba_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Prueba"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.prueba_path(conn, :create), prueba: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Prueba"
    end
  end

  describe "edit prueba" do
    setup [:create_prueba]

    test "renders form for editing chosen prueba", %{conn: conn, prueba: prueba} do
      conn = get(conn, Routes.prueba_path(conn, :edit, prueba))
      assert html_response(conn, 200) =~ "Edit Prueba"
    end
  end

  describe "update prueba" do
    setup [:create_prueba]

    test "redirects when data is valid", %{conn: conn, prueba: prueba} do
      conn = put(conn, Routes.prueba_path(conn, :update, prueba), prueba: @update_attrs)
      assert redirected_to(conn) == Routes.prueba_path(conn, :show, prueba)

      conn = get(conn, Routes.prueba_path(conn, :show, prueba))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, prueba: prueba} do
      conn = put(conn, Routes.prueba_path(conn, :update, prueba), prueba: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Prueba"
    end
  end

  describe "delete prueba" do
    setup [:create_prueba]

    test "deletes chosen prueba", %{conn: conn, prueba: prueba} do
      conn = delete(conn, Routes.prueba_path(conn, :delete, prueba))
      assert redirected_to(conn) == Routes.prueba_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.prueba_path(conn, :show, prueba))
      end
    end
  end

  defp create_prueba(_) do
    prueba = prueba_fixture()
    %{prueba: prueba}
  end
end
