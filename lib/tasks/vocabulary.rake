namespace :cedar do

  desc 'Generates vocabulary concepts data to vocuabulary.ttl rdf file'
  task :vocabulary => :environment do
    export = VocabularyExport.new
    export.token = srand

    if export.save
      job = VocabularyJob.new(export, Iqvoc.config["site_url"])
      Delayed::Job.enqueue(job)
    end
  end
end