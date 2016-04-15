require 'iqvoc/cedar/version'

Iqvoc.config do |config|
  config.register_settings({
    "title" => "Iqvoc Cedar"
  })
end

Iqvoc.host_namespace = Iqvoc::Cedar

# Iqvoc::Concept.base_class_name = "MyConceptClass"
# Iqvoc::Concept.pref_labeling_class_name = "MyLabelingClass"
# Iqvoc::Concept.further_relation_class_names << "MyConceptRelationClass"
# Iqvoc::Concept.note_class_names = []
# Iqvoc.default_rdf_namespace_helper_modules << MyModule

# Iqvoc.core_assets += []
