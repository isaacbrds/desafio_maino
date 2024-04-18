require 'json'
require 'faker'
class HardWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: false

  def perform(*args)
    title = args[0]
    user_id = args[1].to_i
    content = Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4)

    post = Post.new(title:, user_id:, content:)
    puts "#{post.title} - #{post.user_id}"
    post.save
    true
  end
end
