require 'iq_rdf'

class VocabularyExporter
  include RdfHelper # necessary to use render_concept helper
  include RdfNamespacesHelper
  include Rails.application.routes.url_helpers

  def initialize(file_path, default_namespace_url, logger = Rails.logger)
    default_url_options[:port] = URI.parse(default_namespace_url).port
    default_url_options[:host] = URI.parse(default_namespace_url).to_s.gsub(/\/$/, '')

    @file_path = file_path
    @document = IqRdf::Document.new
    @logger = logger
  end

  def run
    export
  end

  def document(type = 'ttl')
    if type == 'ttl'
      @document.to_turtle
    elsif type == 'xml'
      @document.to_xml
    else
      @document.to_ntriples
    end
  end

  private

  def export
    start = Time.now
    @logger.info "Starting vocabulary export..."
    @logger.info "file_path = #{@file_path}"

    depth = -1
    scope = Iqvoc::Concept.base_class.published.ordered_by_pref_label

    root_concepts = scope.tops.load
    scope = scope.includes(:broader_relations, :narrower_relations)

    @concepts = {}
    root_concepts.each do |root_concept|
      @concepts[root_concept] = populate_hierarchy(root_concept, scope, depth,
          0, false)
    end
    
    add_namespaces(@document)
    add_concepts(@document, @concepts)
    
    save_file(@file_path, @document)

    done = Time.now
    @logger.info "Vocabulary export finished in #{(done - start).to_i} seconds."

  end

  # returns a hash of concept/relations pairs of arbitrary nesting depth
  # NB: recursive, triggering one database query per iteration
  def populate_hierarchy(root_concept, scope, max_depth, current_depth = 0,
      include_siblings = false)
    current_depth += 1
    return {} if max_depth != -1 and current_depth > max_depth

    rels = scope.where(Concept::Relation::Base.arel_table[:target_id].
        eq(root_concept.id)).references(:concept_relations)

    results = rels.inject({}) do |memo, concept|
      if include_siblings
        determine_siblings(concept).each { |sib| memo[sib] = {} }
      end
      memo[concept] = populate_hierarchy(concept, scope, max_depth,
          current_depth, include_siblings)
      memo
    end

    results
  end

  # NB: includes support for poly-hierarchies -- XXX: untested
  def determine_siblings(concept)
    concept.broader_relations.map do |rel|
      rel.target.narrower_relations.map { |rel| rel.target } # XXX: expensive
    end.flatten.uniq.sort { |a, b| a.pref_label <=> b.pref_label }
  end

  def add_namespaces(document)
    @logger.info "Exporting namespaces..."

    RdfNamespacesHelper.instance_methods.each do |meth|
      namespaces = send(meth)
      document.namespaces(namespaces) if namespaces.is_a?(Hash)
    end

    @logger.info "Finished exporting namespaces."
  end

  def add_concepts(document, hash)
    @relation_class = Iqvoc::Concept.broader_relation_class
    @relation_class = @relation_class.narrower_class

    hash.each do |concept, rels|
      document << concept.build_rdf_subject do |sbj|
        sbj.Skos::topConceptOf IqRdf.build_uri(Iqvoc::Concept.root_class.instance.origin) if concept.top_term?

        concept.pref_labelings.each do |labeling|
          labeling.build_rdf(document, sbj)
        end

        rels.each do |relation, _|
          @relation_class.new(:owner => concept, :target => relation). # XXX: hacky!?
              build_rdf(document, sbj, true)
        end
        add_concepts(document, rels)
      end
    end
  end

  def save_file(file_path, content)
    begin
      @logger.info "Saving vocabulary export to '#{@file_path}'"
      file = File.open(file_path, 'w')
      file.write(content.to_turtle)
    rescue IOError => e
    ensure
      file.close unless file == nil
    end
  end
end