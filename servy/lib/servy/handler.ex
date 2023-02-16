defmodule Servy.Handler do
  def handle(request) do
    # conv = parse(request)
    # conv = route(conv)
    # format_response(conv)

    request
    |> parse
    |> log
    |> route
    |> format_response
  end

  def log(conv), do: IO.inspect conv

  @spec parse(binary) :: %{method: binary, path: binary, resp_body: <<>>}
  def parse(request) do
    # TODO: Parse the request string into a map:
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    conv = %{ method: method, path: path, resp_body: "" }
  end

  def route(conv) do
    # TODO: Create a new map that also has the response body:
    if conv.path == "/wildthings" do
      %{ conv | resp_body: "Bears, Lions, Tigers" }
    else
      %{ conv | resp_body: "Teddy, Smokey, Paddington" }
    end

  end

  def format_response(conv) do
    # TODO: Use values in the map to create a HTTP response string:
    # For proper UTF-8 string length: Content-Length: #{byte_size(conv.resp_body)}
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end

end


request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response
