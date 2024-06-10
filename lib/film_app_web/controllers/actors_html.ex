defmodule FilmAppWeb.ActorsHTML do
  use FilmAppWeb, :html

  embed_templates "actors_html/*"

  @doc """
  Renders a actors form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def actors_form(assigns)
end
