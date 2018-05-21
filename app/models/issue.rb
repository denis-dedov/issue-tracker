class Issue < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  STATUSES = ['pending', 'in progress', 'resolved'].freeze

  validates_presence_of :assignee, if: Proc.new{ |i| i.status.in?(STATUSES[1..2]) }
end
