defmodule FilmAppWeb.TitlesHTML do
  use FilmAppWeb, :html

  embed_templates "titles_html/*"

  @doc """
  Renders a titles form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def titles_form(assigns)
end
