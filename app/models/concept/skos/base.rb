class Concept::SKOS::Base < Concept::Base

  belongs_to :ark

  before_create :mint_ark
  before_save :update_ark

  self.rdf_namespace = 'skos'
  self.rdf_class = 'Concept'

  def build_rdf_subject(&block)
    ns = IqRdf::Namespace.find_namespace_class(self.rdf_namespace)
    raise "Namespace '#{self.rdf_namespace}' is not defined in IqRdf document." unless ns
    subject = IqRdf.build_uri(self.origin, ns.build_uri(self.rdf_class), &block)

    # ensure skos:Concept type is present
    unless self.rdf_namespace == 'skos' && self.rdf_class == 'Concept'
      subject.Rdf.build_predicate('type', IqRdf::Skos.build_uri('Concept'))
    end

    return subject
  end

  # ********** Scopes
  def self.expired(time = Time.now)
    where(arel_table[:expired_at].lt(time))
  end

  def self.not_expired(time = Time.now)
    col = arel_table[:expired_at]
    where((col.eq(nil)).or(col.gteq(time)))
  end

  private
    def mint_ark
      if (@inline_matches ||= {}).any?
        @ark = Ark.create(
          who: Iqvoc.config["minter.erc_who"],
          when: Time.now.strftime("%Y-%m-%d"), 
          what: what_label,
          where: $_URL
        )
        @inline_matches["Match::SKOS::ExactMatch"].push(Iqvoc.config["minter.base_url"] + @ark.id)
      end
    end

    def update_ark
      if (@inline_matches ||= {}).any? and @inline_matches.key?("Match::SKOS::ExactMatch")
        @inline_matches["Match::SKOS::ExactMatch"].each do |url|
          matches = url.match(/(ark:\/[0-9a-z\/]+)/)
          if !matches.nil?
            @ark = Ark.find(matches[0])
            @ark.what = what_label
            @ark.save
          end
        end
      end
    end

    def what_label
      lang = I18n.locale.to_s == 'none' ? nil : I18n.locale.to_s
      @labelings_by_text['labeling_skos_pref_labels'][lang].to_s
    end

end