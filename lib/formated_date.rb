class FormatedDate
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
  UNKNOWN = 'Unknown time format [%s]'.freeze

  attr_reader :date_str, :unknown_format

  def initialize(date, format_str)
    @date = date
    @format_array = format_str ? format_str.split(',') : []
    @unknown_format = []
    @date_str = @date.strftime(convert_format)
  end

  def valid?
    @unknown_format.empty?
  end

  def error_str
    UNKNOWN % @unknown_format.join(',') unless valid?
  end

  def to_s
    @date_str if valid?
  end

  private

  def convert_format
    @format_array.inject([]) { |array, str| append_format(array, *type_and_format(str)) }
                 .map { |format| format[:date] ? format.values.join('-') : format.values.join(':') }
                 .join(' ')
  end

  def type_and_format(format)
    date_time_format = FORMAT[:date][format] || FORMAT[:time][format]
    @unknown_format << format unless date_time_format

    [FORMAT[:date].key?(format) ? :date : :time, date_time_format]
  end

  def append_format(array, type, format)
    return array unless format

    last = array.last
    last && last[type] ? last[type] << format : array << { type => [format] }
    array
  end
end
