class VocabularyExport < ActiveRecord::Base

  def finish!(log)
    self.log = log
    self.success = true
    self.finished_at = Time.now
    save!
  end

  def fail!(exception)
    self.log = exception.to_s + "\n\n" + exception.backtrace.join("\n")
    self.finished_at = Time.now
    save!
  end

  def failed?
    return self.finished_at? && !self.success
  end

  def processing?
    return self.finished_at.nil?
  end

  def filename
    File.join(Iqvoc.export_path, "vocabulary-#{self.token.to_s}.ttl")
  end

end
