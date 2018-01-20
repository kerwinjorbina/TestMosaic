class Test
	def self.process(data, merge_key)
		data = data.sort_by { |k| k[merge_key] }

		outcoming = Array.new
		obj = Hash.new(0)
		key_tracker = nil

		data.each do |x|
			if key_tracker.nil?
				key_tracker = x[merge_key]
			end
			if x[merge_key] != key_tracker
				outcoming.push(obj)
				obj = Hash.new(0)
				key_tracker = x[merge_key]
			end
			x.each do |key, value|
				obj[key] = value
			end

		end
		outcoming.push(obj)
	end
end