json.(@user, :id, :email, :username, :first_name, :last_name, :country, :province, :city, :neighborhood,
  :address, :gender, :handphone, :status, :birthday, :created_at, :provider, :uid)

json.photo do
  json.original @user.photo_url
  json.thumb @user.photo_url(:thumb)
  json.small @user.photo_url(:small)
  json.medium @user.photo_url(:medium)
  json.cover @user.photo_url(:cover)
end