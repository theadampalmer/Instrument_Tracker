class Owner < ActiveRecord::Base
    has_many :instruments
    has_secure_password

    validates :username, presence: true, uniqueness: true
    
end
