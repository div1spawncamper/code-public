require 'nokogiri'
require 'open-uri'

last_value = ''
last_value1 = ''

def fetch_value(user_id, last_value)
  # Escapar el guión bajo en el nombre de usuario
  encoded_user_id = URI.encode_www_form_component(user_id)
  url = "https://www.mediavida.com/id/#{encoded_user_id}"

  # Especificar la codificación utf-8 al abrir la URL
  page = Nokogiri::HTML(URI.open(url, 'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', 'Content-Type' => 'text/html; charset=utf-8'))

  value_element = page.at("//ul[@class = 'user-meta']/li[3]")

  if value_element.nil?
    puts "No se pudo encontrar el elemento en la página."
    return nil
  end

  value = value_element.text.gsub(/\s+/, "")

  if value != last_value && last_value != value
    open("#{encoded_user_id}.csv", 'a') do |f|
      f.puts "#{Time.now.strftime("%d %b %Y - %H:%M:%S")},#{value}"
    end
  end

  value
end

while true
  value = fetch_value("TRON", last_value)
  last_value = value
  sleep(5)
  value1 = fetch_value("doogie780", last_value1)
  last_value1 = value1
  sleep(5)
end
