defmodule Nested do
  alias Nested.Accessors, as: NA

  # passing a [where: func] in fields will find_index
  def update_in(structure, [head | tail], value) 
    when is_list(head) and is_tuple(hd(head)) and elem(hd(head),0) == :where do
    index = Enum.find_index(structure, head[:where])
    indices = [index] ++ tail
    update_in(structure, indices, value )
  end

  # passing [] as last field means prepend to list
  def update_in(list, [[]], value) when is_list(list), do: [value] ++ list

  @doc """
  Updates a hierarchy of heterogenous record/collection types
  """
  def update_in(structure, [head | tail], value) do
    NA.put(structure, head, 
      update_in(NA.get(structure,head), tail, value))
  end

  def update_in(_, [], value), do: value
end
