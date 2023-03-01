defmodule Servy.Recurse do
  def loopy([head | tail]) do
    IO.puts "Head #{head} Tail: #{inspect(tail)}"
    loopy(tail)
  end

  def loopy([]), do: IO.puts "Done!"

  def sum([head | tail], sum) do
    sum = sum + head
    sum(tail, sum)
  end

  def sum([], sum), do: sum

  def triple([head | tail]) do
    [ head * 3 | triple(tail)]
  end

  def triple([]), do: []
end


Servy.Recurse.loopy([1, 2, 3, 4, 5])

IO.puts Servy.Recurse.sum([1, 2, 3, 4, 5], 0)

IO.inspect Servy.Recurse.triple([1, 2, 3, 4, 5])
