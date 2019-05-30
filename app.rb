class App
  def call(env)
    @request = Rack::Request.new(env)
    if @request.path == '/time' && @request.request_method == 'GET'
      handle_time
    else
      not_found
    end
  end

  private

  def not_found
    [404, headers, []]
  end

  def handle_time
    date = FormatedDate.new(DateTime.now, @request.params['format'])
    [date.valid? ? 200 : 400, headers, [date.to_s || date.error_str]]
  end

  def headers
    { 'Content-type' => 'text/plan' }
  end
end
