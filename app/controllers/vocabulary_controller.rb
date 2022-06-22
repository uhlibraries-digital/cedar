class VocabularyController < ApplicationController

  def index
    export = VocabularyExport.order('id DESC').first
    
    if export.nil? || export.spoiled || export.failed?
      export = VocabularyExport.new
      export.token = srand

      if export.save
        job = VocabularyJob.new(export, Iqvoc.config["site_url"])
        Delayed::Job.enqueue(job)
      end

      processing
    elsif export.processing?
      processing
    else
      time = export.finished_at.strftime('%Y-%m-%d_%H-%M')
      send_file export.filename, 
        filename: "vocabulary-#{time}.ttl",
        disposition: "inline"
    end
  end

  private

  def processing
    render :file => "#{Rails.root}/public/202.html", 
        :status => :accepted, 
        formats: ['html'], 
        layout: false
  end
end