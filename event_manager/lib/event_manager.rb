require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number(phone)
  # Remove non-digit characters
  cleaned_number = phone.to_s.gsub(/\D/, '')

  # Validate and format the phone number
  case cleaned_number.length
  when 10
    cleaned_number
  when 11
    cleaned_number[0] == '1' ? cleaned_number[1..-1] : 'Bad Number'
  else
    'Bad Number'
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

hour_counts = Hash.new(0)
day_counts = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  # Assignments
  phone = clean_phone_number(row[:homephone])
  registration_time = DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')
  registration_hour = registration_time.hour
  registration_day = registration_time.wday

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end
