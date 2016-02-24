class Tool < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :category
  belongs_to :user

  def formatted_price
    price / 100.00
  end
end
