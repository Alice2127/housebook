defmodule Housebook.Components.Paginator do
  @moduledoc """
  Paginator.

  # Example
  <Housebook.Components.Paginator.render total_entries={@total_entries} page_size={@page_size} page={@page} total_pages={@total_pages} />

  # Events
  Emit events is here and parent components must implement handle_event.
    - update_page_size
    - update_page
  """
  use Phoenix.Component #★LiveComponentとの違いが分かっていない

  def render(assigns) do
    ~H"""
    <div>
      <div>
        <p>表示件数：</p>
        <div>
          <form phx-change="update_page_size">
            <select name="page_size">
              <option value="5" selected={@page_size == 5}>5</option>
              <option value="10" selected={@page_size == 10}>10</option>
              <option value="15" selected={@page_size == 15}>15</option>
              <option value="20" selected={@page_size == 20}>20</option>
              <option value="25" selected={@page_size == 25}>25</option>
            </select>
          </form>
        </div>
      </div>
    </div>
    """
  end
end
