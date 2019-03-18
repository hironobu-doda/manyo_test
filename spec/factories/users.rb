FactoryBot.define do
  factory :user do
    name { 'shibao' }
    email { 'shibao@example.com' }
    password_digest { 'shibaodayo' }
    password_confirmation { 'shibaodayo'}
  end
end
