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
      avatar "http://lorempixel.com/150/150/people"
    end

    factory :user_with_topics do          
      after(:create) do |user, evaluator|
        create_list(:topic, 2, user: user)
      end
    end

  end  

end