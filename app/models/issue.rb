class Issue < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  STATUSES = ['Pending', 'In Progress', 'Resolved'].freeze

  validates_presence_of :assignee, if: Proc.new{ |i| i.status.in?(STATUSES[1..2]) }, on: :update
end
