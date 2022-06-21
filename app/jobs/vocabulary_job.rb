class VocabularyJob < Struct.new(:export, :default_namespace_url)

  def enqueue(job)
    job.delayed_reference_id = export.id
    job.delayed_reference_type = export.class.to_s
    job.delayed_global_reference_id = export.to_global_id
    job.save!
  end

  def perform
    strio = StringIO.new

    exporter = VocabularyExporter.new(export.filename, default_namespace_url, Logger.new(strio))
    exporter.run
    @log = strio.string
  end

  def success(job)
    export.finish!(@log)
  end

  def error(job, exception)
    export.fail!(exception)
  end

end