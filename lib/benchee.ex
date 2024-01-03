defmodule Benchee do
  def start do
    map = Map.new(1..10_000, &{&1, &1})
    all_keys = Map.keys(map)

    Benchee.run(
      %{
        "fetch (for)" => fn keys -> for key <- keys, do: Map.fetch(map, key) end,
        "fetch (Enum.map)" => fn keys -> Enum.map(keys, &Map.fetch(map, &1)) end,
        "fetch! (for)" => fn keys -> for key <- keys, do: Map.fetch!(map, key) end,
        "fetch! (Enum.map)" => fn keys -> Enum.map(keys, &Map.fetch!(map, &1)) end,
        "get (for)" => fn keys -> for key <- keys, do: Map.get(map, key) end,
        "get (Enum.map)" => fn keys -> Enum.map(keys, &Map.get(map, &1)) end,
        "take" => fn keys -> Map.take(map, keys) end
      },
      inputs: %{
        "1" => Enum.take_random(all_keys, 1),
        "10" => Enum.take_random(all_keys, 10),
        "100" => Enum.take_random(all_keys, 100),
        "1000" => Enum.take_random(all_keys, 1000)
      }
    )
  end
end
