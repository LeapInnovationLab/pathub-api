FactoryGirl.define do

  factory :user do 
    sequence(:email) { |n| "user_#{n}@pathhub.com" }
    password 'pathhub123'
    first_name "John"
    last_name "Doe"    

    factory :fb_user do
      uid '09230920dj209dj029dj0293d'
      provider :facebook
      first_name 'Jane'
      last_name 'Doe'
      birthday '1978/05/27'
      gender 'male'
      password nil
    end
    
  end  

end