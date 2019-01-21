class PLanguageRemoveWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform
		PLanguage.delete_all
	end
end