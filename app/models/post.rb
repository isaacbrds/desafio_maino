# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true

  paginates_per 3
end
