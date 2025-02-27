FactoryBot.define do
  factory :reading_status do
    association :user
    association :book
    status { :want_to_read }
    start_date { nil }
    completion_date { nil }

    trait :currently_reading do
      status { :currently_reading }
      start_date { Date.current }
      completion_date { nil }
    end

    trait :completed do
      status { :completed }
      start_date { 1.month.ago }
      completion_date { Date.current }
    end
  end
end
