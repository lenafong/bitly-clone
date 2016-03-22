require 'securerandom'	

	def shorten 
		p shortened_url = "bit.ly/" + SecureRandom.hex(rand(2..4))
	end 

	shorten