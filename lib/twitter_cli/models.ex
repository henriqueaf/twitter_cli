defmodule TwitterCli.Models.AppOnlyConfig do
  defstruct [:consumer_key, :consumer_secret, :access_token]
end

defmodule TwitterCli.Models.Geo do
  defstruct [
    :attributes, :bounding_box, :centroid, :contained_within, :country,
    :country_code, :full_name, :id, :name, :place_type, :url
  ]
end
