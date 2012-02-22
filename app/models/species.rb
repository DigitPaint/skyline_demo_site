class Species < ActiveRecord::Base
  include Skyline::Content::Content
  include Skyline::Content::Versioning::Versionable
  
  has_many :creatures

  settings :identification_columns => [:name]

  
  field :name,
        :label => "Name"
        
  field :creatures
  
    
end
