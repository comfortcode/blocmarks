class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks, :dependent => :destroy

  def self.find_or_create_by_topic(*args)
    options = args.extract_options!
    options[:name] = args[0] if args[0].is_a?(String)
    case_sensitive = options.delete(:case_sensitive)
    conditions = case_sensitive ? ['name = ?', options[:name]] : 
                                  ['UPPER(name) = ?', options[:name].upcase] 
    first(:conditions => conditions) || create(options)
  end

end
