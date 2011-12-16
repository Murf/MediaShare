class Mediafile < ActiveRecord::Base
  belongs_to :users
  belongs_to :medium
end
