FactoryGirl.define do
  factory :store_user, class: User do
    email "northeast@storeuser.com"
    password "123123123"
    password_confirmation "123123123"
    onboarded true
    role "Store"
  end

  factory :area_user, class: User do
    email "northeast@areauser.com"
    password "123123123"
    password_confirmation "123123123"
    onboarded true
    role "Area"
  end
end
