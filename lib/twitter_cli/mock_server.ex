defmodule TwitterCli.MockServer do
  use Plug.Router # this implements 'init' and 'start_link' functions
  plug Plug.Parsers, parsers: [:json],
                    pass:  ["text/*"],
                    json_decoder: Poison

  plug :match
  plug :dispatch

  get "/geo/search.json" do
    case conn.params do
      %{"query" => _} ->
        success(conn, %{
          query: %{
            params: %{
              accuracy: 0.0,
              autocomplete: false,
              granularity: "neighborhood",
              query: "jacarecanga",
              trim_place: false
            },
            type: "search",
            url: "https://api.twitter.com/1.1/geo/search.json?query=jacarecanga"
          },
          result: %{
            places: [%{
              attributes: %{},
              bounding_box: %{
                coordinates: [[[-38.550562, -3.728382], [-38.550562, -3.710878], [-38.540255, -3.710878], [-38.540255, -3.728382], [-38.550562, -3.728382]]],
                type: "Polygon"
              },
              centroid: [-38.54558018001512, -3.71963], contained_within: [%{
                attributes: %{},
                bounding_box: %{
                  coordinates: [[[-38.638212, -3.88818], [-38.638212, -3.691356], [-38.401568, -3.691356], [-38.401568, -3.88818], [-38.638212, -3.88818]]],
                  type: "Polygon"
                },
                centroid: [-38.528130187205946, -3.789768],
                country: "Brazil",
                country_code: "BR",
                full_name: "Fortaleza, Brazil",
                id: "d16815010421ff73",
                name: "Fortaleza",
                place_type: "city",
                url: "https://api.twitter.com/1.1/geo/id/d16815010421ff73.json"
              }],
              country: "Brazil",
              country_code: "BR",
              full_name: "Jacarecanga, Fortaleza",
              id: "5712a7f2b67b7ff3",
              name: "Jacarecanga",
              place_type: "neighborhood",
              url: "https://api.twitter.com/1.1/geo/id/5712a7f2b67b7ff3.json"
            }]
          }
        })
      %{"name" => "failure-repo"} ->
        failure(conn)
    end
  end

  defp success(conn, body) do
    conn
    |> Plug.Conn.send_resp(200, Poison.encode!(body))
  end

  defp failure(conn) do
    conn
    |> Plug.Conn.send_resp(422, Poison.encode!(%{message: "error message"}))
  end
end
