require 'open-uri'
require 'net/http'
desc 'Imports entries. FILE=file.txt'
task :import => :environment do
  SITE_URL = URI.parse('http://de.10.0.1.2.xip.io/api/entries')
  # API_KEY = 'EAT_YOUR_VEGGIES'
  API_KEY = 'CHEESE_IS_TASTY'
  # REGEXP = %r{\s*#+\s+\b?(?<date>\d{1,2}/\d{1,2}/\d{2,4})}
  # STRPTIME = '%m/%d/%Y'
  REGEXP = %r{\s*#+\s+\b?(?<date>\w+\s+\d{1,2},\s+\d{2,4})}
  STRPTIME = '%B %d, %Y'
  file_name = ENV['FILE']
  if file_name.blank?
    raise ArgumentError, 'Please supply a file to import: `rake import FILE=file.txt`'
  elsif !File.exists?(file_name)
    raise ArgumentError, "#{file_name}: No such file or directory."
  end
  puts "Importing #{file_name}"
  entry_lines = []
  at = nil

  File.readlines(file_name).each do |line|
    if (match = REGEXP.match(line))
      if at.present? && entry_lines.present?
        puts "New entry for #{I18n.l(at)} with #{entry_lines.size} lines."
        data = {
          'api_key' => API_KEY,
          'entry[at]' => at,
          'entry[body]' => entry_lines.join(' ').strip,
        }
        Net::HTTP.post_form(SITE_URL, data)
        at = nil
        entry_lines = []
      end
      begin
        at = Time.strptime(match[:date], STRPTIME)
      rescue ArgumentError
        puts "#{match[:date]} is invalid date."
      end
    else
      entry_lines << (line.squish.blank? ? "\n\n" : line.chomp)
    end
  end
end
