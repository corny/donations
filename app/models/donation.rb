class Donation < ApplicationRecord

  belongs_to :recipient

  scope :purpose, ->(val) { where(purpose: val) }
  scope :recipient, ->(val) { where(recipient: val) }

  def self.states
    distinct.order(:state).pluck(:state)
  end

  def self.grouped_by_year
    select("EXTRACT(year FROM date_begin) AS year, COUNT(*) count, SUM(amount) amount").group(:year).sort_by(&:year)
  end

  def self.grouped_by_recipients
    select("recipient_id, COUNT(*) count, SUM(amount) amount").group(:recipient_id)
  end

end
