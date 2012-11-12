class Player < ActiveRecord::Base
  belongs_to :user
  attr_accessible :is_moving, :last_direction, :left, :top, :user_id
end
