class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :owned_issues, class_name: 'Issue', foreign_key: 'owner_id'
  has_many :assigned_issues, class_name: 'Issue', foreign_key: 'assignee_id'

  scope :assignees, -> { where(is_manager: true) }
  scope :owners, -> { where.not(is_manager: true, is_admin: true) }

  def issues
    is_regular? ? owned_issues : Issue.all
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def to_s
    full_name.present? ? full_name : email
  end

  def role
    is_manager ? 'Manager' : 'Regular'
  end

  def not_regular?
    !is_regular?
  end

  def is_regular?
    !is_manager? && !is_admin?
  end
end
