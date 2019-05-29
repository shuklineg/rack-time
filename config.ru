require_relative 'app'
require_relative 'middleware/param_filter'
require_relative 'middleware/date_format'

use DateFormat
use ParamFilter
run App.new

