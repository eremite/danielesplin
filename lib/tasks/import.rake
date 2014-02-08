require 'net/http'
desc 'Imports entries. FILE=file.txt'
task :import => :environment do
  SITE_URL = URI.parse('http://localhost:3000/api/entries')
  # SITE_URL = URI.parse('http://www.danielesplin.org/api/entries')
  API_KEY = 'api_key'
  REGEXP = %r{\s*#+\s+\b?(?<date>\d{1,2}/\d{1,2}/\d{2,4}(\s*.*)?)}
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
        submit_to_api(at, body)
        at = nil
        body = ''
      end
      begin
        date = match[:date].gsub(%r{/(\d{2})\Z}, '/19\1')
        at =
          if date.split.size > 1
            DateTime.strptime(date, '%m/%d/%Y %H:%M%p')
          else
            Time.strptime(date, STRPTIME)
          end
      rescue ArgumentError
        puts "!!! #{match[:date]} is invalid date."
      end
    else
      body << (line.squish.blank? ? NEWLINE : "#{line.squish} ")
    end
  end
  submit_to_api(at, body)

end

def submit_to_api(at, body)
  body = body.gsub(/\s*#{NEWLINE}/, "\n\n").strip
  puts "#{at} | #{body.first(50)} ... #{body.last(50)}".squish
  data = {
    'api_key' => API_KEY,
    'entry[at]' => at,
    'entry[body]' => body,
  }
  Net::HTTP.post_form(SITE_URL, data)
end
