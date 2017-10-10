require "base64"
require "net/http"

class PasswordChecker
  PASSWORD_PART1_DATA = "b2tvcw=="
  PASSWORD_PART2_LOCATION = "https://sublimia.nl/~crome/password_part2.txt"
  PASSWORD_PART3_DATA = [13924, 9409, 10609, 14641, 12321, 11449].freeze

  def initialize(password)
    @pw = password
  end

  def accepted?
    return @pw == correctpassword
  end

  private

  def correctpassword
    part1 + part2 + part3
  end

  def part1
    Base64.decode64(PASSWORD_PART1_DATA)
  end

  def part2
    uri = URI(PASSWORD_PART2_LOCATION)
    request = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    case response
    when Net::HTTPSuccess
      return response.body
    else
      raise "Could not retrieve password chunk"
    end
  end

  def part3
    decoder_algorithms = [
      -> (e) { Integer(Math.sqrt(e)) },
      -> (e) { e^999^999 },
      -> (e) { e.send(:chr) }
    ]

    data = PASSWORD_PART3_DATA.dup

    decoder_algorithms.each do |decoder|
      data.map!(&decoder)
    end

    data.join
  end
end

