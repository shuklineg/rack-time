class App
  FORMAT = {
    date: {
      'year' => '%Y',
      'month' => '%m',
      'day' => '%d'
    },
    time: {
      'hour' => '%H',
      'minute' => '%M',
      'second' => '%S'
    }
  }.freeze

  attr_accessor :params, :method, :path, :format

  def call(env)
    request = Rack::Request.new(env)
    @method = request.request_method
    @path = request.path
    @format = request.params['format'] || ''
    [200, { 'Content-type' => 'text/plan' }, []]
  end
end
