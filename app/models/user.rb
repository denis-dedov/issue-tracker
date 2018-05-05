class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def to_s
    full_name.present? ? full_name : email
  end
end
