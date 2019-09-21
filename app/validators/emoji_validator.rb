class EmojiValidator < ActiveModel::Validator
	def validate(record)
			puts "hhheeeeeeeeeeeeeeeeeeeeeeee"
			puts record.attributes
			record.attributes.each do |attr_name, value|
				puts attr_name
				if String === value
					unavailable_chars = value.scan(/[^\u0000-\uFFFF]/)
					record.errors.add(attr_name, "に使用できない文字が含まれています", chars: unavailable_chars.uniq.join(', ')) if unavailable_chars.present?
				end
			end
	end
end