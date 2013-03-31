defprotocol Nested.Associate do
  def assoc(structure, index, value)
  def get(structure, index)
  #def update(structure, index, value)
end

defimpl Nested.Associate, for: Tuple do
  # for Records
  def assoc(record, attribute, value) when is_record(record) do
    module = elem(record,0)
    apply(module, attribute, [value, record])  
  end

  # for arbitrary tuples
  def assoc(tuple, index, value) when is_integer(index) do
    setelem(tuple, index, value)
  end

  # for Records
  def get(record, attribute) when is_record(record) do
    module = elem(record,0)
    apply(module, attribute, [record])
  end

  # for arbitrary tuples
  def get(tuple, index) when is_integer(index) do
    elem(tuple,index)
  end
end

defimpl Nested.Associate, for: List do
  # for Keywords list
  def assoc(words, key, value) when is_atom(key) do
    Keyword.put(words, key, value)
  end

  def get(words, key) when is_atom(key) do
    Keyword.get(words,key)
  end
end
