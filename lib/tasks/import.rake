require 'net/http'
desc 'Imports entries. FILE=file.txt'
task :import => :environment do
  # SITE_URL = URI.parse('http://0.0.0.0:3000/api/entries')
  SITE_URL = URI.parse('http://www.danielesplin.org/api/entries')
  # API_KEY = 'EAT_YOUR_VEGGIES'
  API_KEY = 'CHEESE_IS_TASTY'
  REGEXP = %r{\s*#+\s+\b?(?<date>\d{1,2}/\d{1,2}/\d{2,4})}
  STRPTIME = '%m/%d/%Y'
  # REGEXP = %r{\s*#+\s+\b?(?<date>\w+\s+\d{1,2},\s+\d{2,4})}
  # STRPTIME = '%B %d, %Y'
  NEWLINE = '{{NEWLINE}}'
  file_name = ENV['FILE']
  if file_name.blank?
    raise ArgumentError, 'Please supply a file to import: `rake import FILE=file.txt`'
  elsif !File.exists?(file_name)
    raise ArgumentError, "#{file_name}: No such file or directory."
  end
  puts "Importing #{file_name}"
  body = ''
  at = nil

  File.readlines(file_name).each do |line|
    if (match = REGEXP.match(line))
      if at.present? && body.present?
        puts "New entry for #{I18n.l(at)}."
        data = {
          'api_key' => API_KEY,
          'entry[at]' => at,
          'entry[body]' => body.gsub(/\s*#{NEWLINE}/, "\n\n").strip,
        }
        Net::HTTP.post_form(SITE_URL, data)
        at = nil
        body = ''
      end
      begin
        date = match[:date].gsub(%r{/(\d{2})\Z}, '/20\1')
        at = Time.strptime(date, STRPTIME)
      rescue ArgumentError
        puts "#{match[:date]} is invalid date."
      end
    else
      body << (line.squish.blank? ? NEWLINE : "#{line.squish} ")
    end
  end
end
