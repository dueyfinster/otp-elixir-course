defmodule Servy.Handler do
  @moduledoc """
  Handles HTTP Requests
  """

  @pages_path Path.expand("../../pages", __DIR__)

  import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Servy.Parser, only: [parse: 1]
  import Servy.FileHandler, only: [handle_file: 2]

  alias Servy.Conv

  @doc """
  Transforms a request into a response
  """
  def handle(request) do
    # conv = parse(request)
    # conv = route(conv)
    # format_response(conv)

    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    #|> emojify
    |> format_response
  end

  def route(%Conv{ method: "GET", path: "/wildthings" } = conv) do
    # TODO: Create a new map that also has the response body:
    %{ conv | status: 200, resp_body: "Bears, Lions, Tigers" }
  end

  def route(%Conv{ method: "GET", path: "/bears" } = conv) do
    # TODO: Create a new map that also has the response body:
    %{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
  end

  def route(%Conv{ method: "GET", path: "/about" } = conv) do
    # TODO: Create a new map that also has the response body:
    file =
      @pages_path
      |> Path.join("about.html")
      |> File.read
      |> handle_file(conv)
  end

  def route(%Conv{ method: "GET", path: "/pages/" <> file } = conv) do
    # TODO: Create a new map that also has the response body:

    file =
      @pages_path
      |> Path.join(file <> ".html")
      |> File.read
      |> handle_file(conv)
  end

  def route(%Conv{ method: "GET", path: "/bears" <> id } = conv) do
    %{ conv | status: 200, resp_body: "Bear #{id}" }
  end

  def route(%Conv{ method: "DELETE", path: "/bears" <> _id } = conv) do
    %{ conv | status: 403, resp_body: "Deleting a bear is forbidden!"}
  end

  # Default error response
  def route(%{ path: path } = conv) do
    %{ conv | status: 404, resp_body: "No #{path} here!" }
  end

  # def route(conv) do
  #   route(conv, conv[:method], conv[:path])
  # end

  def emojify(%Conv{ resp_body: resp_body, status: 200 } = conv) do
    %{ conv | resp_body: "😘#{resp_body}😘" }
  end

  def emojify(%Conv{} = conv), do: conv

  def format_response(%Conv{} = conv) do
    # TODO: Use values in the map to create a HTTP response string:
    # For proper UTF-8 string length: Content-Length: #{byte_size(conv.resp_body)}
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}

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


request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
DELETE /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response


request = """
GET /bears?id=1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response

request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response


request = """
GET /pages/contact HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts response
