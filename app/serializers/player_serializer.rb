class PlayerSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :email, :bio, :handle, :city, :state, :zip_code, :slug, :website, :profile_image_path
  
end