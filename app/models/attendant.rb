class Attendant < ApplicationRecord
    validates :email, presence: true
end
