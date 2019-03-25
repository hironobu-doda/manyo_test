FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'shibao' }
    email { 'shibao@example.com' }
    password { 'shibaodayo' }
    # password_digest { 'shibaodayo' }
    # password_confirmation { 'shibaodayo'}
  end
end
