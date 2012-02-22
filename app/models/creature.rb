class Creature < ActiveRecord::Base
  include Skyline::Content::Content
  include Skyline::Content::Versioning::Versionable
  
  validates_presence_of :name

  default_scope :order => 'position ASC'
  belongs_to :species
  
  settings :identification_columns => [:name],
           :label => ["creature","creatures"],
           :order_by => "position ASC",
           :orderable => true
  
  field :name,
        :label => "Name"
  
  field :number_of_teeth,
        :label => "Number of teeth",
        :filterable => true
  
  field :species,
        :editor => :list,
        :list => Proc.new{|owner| Species.all.collect{|e| [e.name,e.id]} }
        
    
  
end
