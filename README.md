# FilmApp

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`. For this app, the server will throw errors unless you set up DB like below.

## Database

In order to get your local DB running, you will have to do a few things:

- `mix ecto.create`
- `mix ecto.migrate`
- Get docker running locally with:
- `docker run --name film_app_dev -e POSTGRES_PASSWORD=password -d -p 5432:5432 postgres`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Environment setup

In order for the API keys to work locally, you need to create a `.env` file in the root of this app. There are currently three API keys needed and they are outlined in `.env.example`.

## OMDB API

For you to see a response when you search movies, you need an API key from OMDB. You can sign up for one for free at the site below. Replace `OMDB_API_KEY` with the one that OMDB emails you when you sign up.

- https://www.omdbapi.com/

## Mailjet API

For you to get password reset working locally, sign up for a Mailjet account at the site below and replace the key `MAILJET_API_KEY` and secret `MAILJET_API_SECRET`, with the one you get in your `.env` file.

- https://dev.mailjet.com/email/guides/

Add these to your shell permanently if using .zsh (or bash etc.):
`echo 'export OMDB_API_KEY=<MY KEY>' >> ~/.zshenv` and same for the Mailjet secrets.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

# film_app
