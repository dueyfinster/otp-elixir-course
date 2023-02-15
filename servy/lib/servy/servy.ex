defmodule Servy do
  @spec hello(any) :: <<_::56, _::_*8>>
  def hello(name) do
    "Howdy, #{name}!"
  end
end


#IO.puts Servy.hello("Elixir")
