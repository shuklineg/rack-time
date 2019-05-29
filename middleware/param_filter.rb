class ParamFilter
  attr_reader :format_array

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    return [404, headers, []] unless @app.method == 'GET' && @app.path == '/time'

    @format_array = @app.format.split(',')
    uncknown_format = unknown
    return [400, headers, ["Unknown time format [#{uncknown_format.join(',')}]"]] unless uncknown_format.empty?

    [status, headers, body]
  end

  private

  def unknown
    format_array.filter { |param| !App::FORMAT.values.map(&:keys).flatten.include? param }
  end
end
