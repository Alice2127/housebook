defmodule HousebookWeb.OutgoLiveTest do
  use HousebookWeb.ConnCase

  import Phoenix.LiveViewTest
  import Housebook.OutgosFixtures

  @create_attrs %{group_id: 42, payment: 42}
  @update_attrs %{group_id: 43, payment: 43}
  @invalid_attrs %{group_id: nil, payment: nil}

  defp create_outgo(_) do
    outgo = outgo_fixture()
    %{outgo: outgo}
  end

  describe "Index" do
    setup [:create_outgo]

    test "lists all outgos", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.outgo_index_path(conn, :index))

      assert html =~ "Listing Outgos"
    end

    test "saves new outgo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.outgo_index_path(conn, :index))

      assert index_live |> element("a", "New Outgo") |> render_click() =~
               "New Outgo"

      assert_patch(index_live, Routes.outgo_index_path(conn, :new))

      assert index_live
             |> form("#outgo-form", outgo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#outgo-form", outgo: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.outgo_index_path(conn, :index))

      assert html =~ "Outgo created successfully"
    end

    test "updates outgo in listing", %{conn: conn, outgo: outgo} do
      {:ok, index_live, _html} = live(conn, Routes.outgo_index_path(conn, :index))

      assert index_live |> element("#outgo-#{outgo.id} a", "Edit") |> render_click() =~
               "Edit Outgo"

      assert_patch(index_live, Routes.outgo_index_path(conn, :edit, outgo))

      assert index_live
             |> form("#outgo-form", outgo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#outgo-form", outgo: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.outgo_index_path(conn, :index))

      assert html =~ "Outgo updated successfully"
    end

    test "deletes outgo in listing", %{conn: conn, outgo: outgo} do
      {:ok, index_live, _html} = live(conn, Routes.outgo_index_path(conn, :index))

      assert index_live |> element("#outgo-#{outgo.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#outgo-#{outgo.id}")
    end
  end

  describe "Show" do
    setup [:create_outgo]

    test "displays outgo", %{conn: conn, outgo: outgo} do
      {:ok, _show_live, html} = live(conn, Routes.outgo_show_path(conn, :show, outgo))

      assert html =~ "Show Outgo"
    end

    test "updates outgo within modal", %{conn: conn, outgo: outgo} do
      {:ok, show_live, _html} = live(conn, Routes.outgo_show_path(conn, :show, outgo))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Outgo"

      assert_patch(show_live, Routes.outgo_show_path(conn, :edit, outgo))

      assert show_live
             |> form("#outgo-form", outgo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#outgo-form", outgo: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.outgo_show_path(conn, :show, outgo))

      assert html =~ "Outgo updated successfully"
    end
  end
end
