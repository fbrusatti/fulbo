ActiveAdmin.register SportCenter do
  form do |f|
    f.inputs "Sport Center Details" do 
      f.input :owner
      f.input :name
      f.input :address
      f.input :cuit
      f.input :description
      f.input :email
      f.input :phone
    end
    f.actions
  end
end
