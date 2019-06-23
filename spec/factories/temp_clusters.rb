FactoryBot.define do
  factory :temp_cluster do
    created_at { Time.now }
    updated_at { Time.now }
    cluster_id { nil }
    terminated_at { nil }
    cluster_name { nil }
    last_credentials_at { nil }
  end
end
