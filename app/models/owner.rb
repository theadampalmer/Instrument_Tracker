class Owner < ActiveRecord::Base
    has_many :instruments
    has_secure_password

    validates :username, presence: true

    def slug
        username.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        Owner.all.find{|user| user.slug == slug}
    end
    
end
