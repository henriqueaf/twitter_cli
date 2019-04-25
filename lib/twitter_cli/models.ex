defmodule TwitterCli.Models.AppOnlyConfig do
  defstruct [:consumer_key, :consumer_secret, :access_token]
  @type t :: %__MODULE__{
    consumer_key: String.t(),
    consumer_secret: String.t(),
    access_token: nil | String.t()
  }
end

defmodule TwitterCli.Models.Geo do
  defstruct [
    :attributes, :bounding_box, :centroid, :contained_within, :country,
    :country_code, :full_name, :id, :name, :place_type, :url
  ]
end
