class CalendarItem < ActiveRecord::Base
  include Skyline::Content::Content
  include Skyline::Content::Versioning::Versionable
  include Skyline::Taggable
  include Skyline::BelongsToReferable
  include Skyline::HasManyReferablesIn 
  
  validates_presence_of :title

  has_many_referables_in :description
  
  default_scope :order => 'calendar_date ASC'
  
  settings :presenter => :article,
           :identification_columns => [:title],
           :label => ["calendar item","calendar items"],
           :order_by => "calendar_date DESC"
  
  field :title,
        :label => "Titel"
  
  field :calendar_date,
        :label => "Datum",
        :filterable => true        
  
  field :description, 
        :editor => :wysiwyg,
        :label => "Beschrijving",
        :hidden => [:list]  

end
