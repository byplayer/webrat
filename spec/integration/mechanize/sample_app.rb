require "sinatra/base"

class SampleApp < Sinatra::Base
  get "/" do
    "Hello World"
  end

  get "/internal_redirect" do
    redirect URI.join(request.url, "redirected").to_s
  end

  get "/external_redirect" do
    redirect "http://example.test/"
  end

  get "/redirected" do
    "Redirected"
  end

  get "/form" do
    <<-EOS
    <html>
      <form action="/form" method="post">
        <input type="hidden" name="_method" value="put" />
        <label for="email">Email:</label> <input type="text" id="email" name="email" /></label>
        <input type="submit" value="Add" />
      </form>
    </html>
    EOS
  end

  post "/form" do
    "Welcome #{params[:email]}"
  end

  put "/put_test" do
    "putted: #{request.body.read}"
  end

  delete "/delete_test" do
    "deleted"
  end
end
