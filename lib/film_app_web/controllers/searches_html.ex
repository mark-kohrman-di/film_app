defmodule FilmAppWeb.SearchesHTML do
  use FilmAppWeb, :html

  embed_templates "searches_html/*"

  @doc """
  Renders a searches form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def searches_form(assigns)
end
