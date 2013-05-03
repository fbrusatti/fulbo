class SportCenter < ActiveRecord::Base
  attr_accessible :address, :cuit, :description, :email, :name, :phone
end
