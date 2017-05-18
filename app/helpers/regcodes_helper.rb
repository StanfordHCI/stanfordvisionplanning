module RegcodesHelper
	def regcode_for (code_token)
		if code_token == nil || code_token == ""
			return nil
		end
		Regcode.where(used: false).each do |rg|
			if rg.authenticated? (code_token)
				return rg
			end
		end
		nil
	end
end
