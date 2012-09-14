class Photo < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
end
