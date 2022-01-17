defmodule ArvoreRepli.Repo do
  use Ecto.Repo,
    otp_app: :arvore_repli,
    adapter: Ecto.Adapters.MyXQL
end
