class PlayerSerializer < ActiveModel::Serializer

  attributes :id, :handle, :first_name, :last_name, :email, :bio, :city, :state, :zip_code, :slug, :website, :profile_image_path

end
