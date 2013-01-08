class Mediafile < ActiveRecord::Base
  belongs_to :user
  belongs_to :medium
end
