defmodule Servy.Recurse do
  def loopy([head | tail]) do
    IO.puts "Head #{head} Tail: #{inspect(tail)}"
    loopy(tail)
  end

  def loopy([]), do: IO.puts "Done!"
end


Servy.Recurse.loopy([1, 2, 3, 4, 5])
