class EmojiValidator < ActiveModel::Validator
	# 文字列カラムに絵文字が使用できない文字が含まれていないか確認
	def validate(record)
			# レコードの全カラムを走査
			record.attributes.each do |attr_name, value|
				if String === value
					unavailable_chars = value.scan(/[^\u0000-\uFFFF]/)
					record.errors.add(attr_name, "に使用できない文字が含まれています", chars: unavailable_chars.uniq.join(', ')) if unavailable_chars.present?
				end
			end
	end
end