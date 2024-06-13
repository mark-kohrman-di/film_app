defmodule FilmAppWeb.FilmsHTML do
  use FilmAppWeb, :html

  embed_templates "films_html/*"

  @doc """
  Renders a films form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def films_form(assigns)
end
