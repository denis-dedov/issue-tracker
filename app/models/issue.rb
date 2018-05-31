class Issue < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  STATUSES = [:pending, :in_progress, :resolved].freeze

  validates_presence_of :assignee, if: Proc.new{ |i| i.status.to_sym.in?(STATUSES[1..2]) },
    on: :update

  def self.filter(filter)
    return self if filter.value?('all') || filter.blank?

    self.where(filter)
  end

  def self.statuses
    Hash[Issue::STATUSES.map{ |key| [key, I18n.t(key)] }]
  end
end
