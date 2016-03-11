class MenuItem < ActiveRecord::Base
  enum category: [:breakfast, :lunch, :dinner, :drink]
end
