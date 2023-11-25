class Consumer < ApplicationRecord
    validates :email, presence: true
end
