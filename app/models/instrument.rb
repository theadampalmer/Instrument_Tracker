class Instrument < ActiveRecord::Base
    belongs_to :owner
    validates :owner_id, presence: true
end
