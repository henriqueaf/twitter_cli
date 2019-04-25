defmodule TwitterCli.API.Helpers do
  def handle_response(data) do
    body = Poison.decode!(data.body, keys: :atoms)

    case data do
      %{status_code: 200} ->
        body
      %{status_code: _} ->
        case body do
          %{errors: [error | _]} ->
            raise(TwitterCli.Error, [code: error.code, message: "#{error.message}"])
          _ ->
            raise(TwitterCli.Error, [code: "000", message: "Unkown response error."])
        end
    end
  end
end
