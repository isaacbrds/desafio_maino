# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    user
  end
end
