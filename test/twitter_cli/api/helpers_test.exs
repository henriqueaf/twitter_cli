defmodule TwitterCli.API.HelpersTest do
  use ExUnit.Case
  alias TwitterCli.API.Helpers

  test "handle_response with status_code 200" do
    data = %HTTPoison.Response{
      body: "{\"result\":{\"places\":[{\"id\":\"5712a7f2b67b7ff3\",\"url\":\"https:\\/\\/api.twitter.com\\/1.1\\/geo\\/id\\/5712a7f2b67b7ff3.json\",\"place_type\":\"neighborhood\",\"name\":\"Jacarecanga\",\"full_name\":\"Jacarecanga, Fortaleza\",\"country_code\":\"BR\",\"country\":\"Brazil\",\"contained_within\":[{\"id\":\"d16815010421ff73\",\"url\":\"https:\\/\\/api.twitter.com\\/1.1\\/geo\\/id\\/d16815010421ff73.json\",\"place_type\":\"city\",\"name\":\"Fortaleza\",\"full_name\":\"Fortaleza, Brazil\",\"country_code\":\"BR\",\"country\":\"Brazil\",\"centroid\":[-38.528130187205946,-3.789768],\"bounding_box\":{\"type\":\"Polygon\",\"coordinates\":[[[-38.638212,-3.88818],[-38.638212,-3.691356],[-38.401568,-3.691356],[-38.401568,-3.88818],[-38.638212,-3.88818]]]},\"attributes\":{}}],\"centroid\":[-38.54558018001512,-3.71963],\"bounding_box\":{\"type\":\"Polygon\",\"coordinates\":[[[-38.550562,-3.728382],[-38.550562,-3.710878],[-38.540255,-3.710878],[-38.540255,-3.728382],[-38.550562,-3.728382]]]},\"attributes\":{}}]},\"query\":{\"url\":\"https:\\/\\/api.twitter.com\\/1.1\\/geo\\/search.json?query=jacarecanga\",\"type\":\"search\",\"params\":{\"accuracy\":0.0,\"granularity\":\"neighborhood\",\"query\":\"jacarecanga\",\"autocomplete\":false,\"trim_place\":false}}}",
      headers: [],
      request: %{},
      request_url: "https://api.twitter.com/1.1/geo/search.json?query=jacarecanga",
      status_code: 200
    }

    assert Helpers.handle_response(data) === %{
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
    }
  end

  test "handle_response with status_code not 200" do
    data = %HTTPoison.Response{
      body: "{\"errors\":[{\"code\":32,\"message\":\"Could not authenticate you.\"}]}",
      headers: [],
      request: %{},
      request_url: "https://api.twitter.com/1.1/geo/search.json?query=",
      status_code: 401
    }

    assert_raise TwitterCli.Error, "Could not authenticate you.", fn ->
      Helpers.handle_response(data)
    end
  end

  test "handle_response with status_code not 200 and no specific error" do
    data = %HTTPoison.Response{
      body: "{}",
      headers: [],
      request: %{},
      request_url: "https://api.twitter.com/1.1/geo/search.json?query=",
      status_code: 404
    }

    assert_raise TwitterCli.Error, "Unkown response error.", fn ->
      Helpers.handle_response(data)
    end
  end
end
