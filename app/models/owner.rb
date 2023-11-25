class Owner < ApplicationRecord
    validates :email, presence: true
end
