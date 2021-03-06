require 'netbox_client_ruby/entities'
require 'netbox_client_ruby/api/ipam/prefix'

module NetboxClientRuby
  class Prefixes
    include NetboxClientRuby::Entities

    path 'ipam/prefixes.json'
    data_key 'results'
    count_key 'count'
    entity_creator :entity_creator

    private

    def entity_creator(raw_entity)
      NetboxClientRuby::Prefix.new raw_entity['id']
    end
  end
end
