class PLanguageAddWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	require 'csv'

	def perform(csv_path)
		CSV.foreach((csv_path), headers: true) do |language|
			PLanguage.create(
				name: language[0],
				wiki_link: language[1]	
			)
		end
	end
end
