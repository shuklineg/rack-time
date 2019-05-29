class DateFormat
  def initialize(app)
    @app = app
    @format = App::FORMAT
  end

  def call(env)
    status, headers, body = @app.call(env)
    body = [DateTime.now.strftime(format_to_string)] if status == 200
    [status, headers, body]
  end

  private

  def format_to_string
    format_array = []
    @app.format_array.each do |format|
      last = format_array.last
      type = @format[:date].key?(format) ? :date : :time
      format_str = @format[type][format]
      last && last[type] ? last[type] << format_str : format_array << { type => [format_str] }
    end
    format_array.map { |format| format[:date] ? format.values.join('-') : format.values.join(':') }.join(' ')
  end
end
