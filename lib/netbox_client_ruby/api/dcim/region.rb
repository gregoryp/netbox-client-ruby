require 'netbox_client_ruby/entity'

module NetboxClientRuby
  class Region
    include NetboxClientRuby::Entity

    id id: :id
    deletable true
    path 'dcim/regions/:id.json'
    creation_path 'dcim/regions/'
    object_fields parent: proc { |raw_data| Region.new raw_data['id'] }
  end
end
