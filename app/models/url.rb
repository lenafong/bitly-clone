require 'open-uri'
require 'Nokogiri'

class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates_presence_of :long_url, :message => "No URL"
	validates_format_of :long_url, :with => URI::regexp(%w(http https)), :message => "Invalid URL!No http or https"
	validate :validate_url

	before_create :shorten 

	def shorten 
		new_shortened_url = SecureRandom.hex(rand(2..5))
		
		self.shortened_url = new_shortened_url
	end 

	def validate_url
		return false if self.errors.full_messages.present?
		begin 
			# source = URI.parse(self.long_url)
			# resp = Net::HTTP.get_response(source)

		doc = Nokogiri::HTML(open(self.long_url))
		# rescue  URI::InvalidURIError
  #     		errors.add(:long_url,'Is Invalid')
  		#SocketErrors
		rescue
			errors.add(:long_url, 'Invalid URL. Missing ":" "/"? Please check your url!')
		end

	end
end
