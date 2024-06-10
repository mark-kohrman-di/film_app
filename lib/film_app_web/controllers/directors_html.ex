defmodule FilmAppWeb.DirectorsHTML do
  use FilmAppWeb, :html

  embed_templates "directors_html/*"

  @doc """
  Renders a directors form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def directors_form(assigns)
end
