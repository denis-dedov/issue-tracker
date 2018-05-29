# create admin
User.create(first_name: 'Admin',
  email: 'admin@fake-provider.com',
  password: 'admin',
  confirmed_at: 100.days.ago,
  is_admin: true)

# create managers
managers = User.create([{ first_name: 'Jane' }, { first_name: 'John' }]) do |u|
  u.last_name = 'Manager'
  u.email = u.first_name + '-manager@fake-provider.com'
  u.password = 'manager'
  u.confirmed_at = 100.days.ago
  u.is_manager = true
end.concat Array.new(1)

# create regular users
regulars = User.create([{ first_name: 'Anna' }, { first_name: 'Michael' }]) do |u|
  u.last_name = 'Regular'
  u.email = u.first_name + '-regular@fake-provider.com'
  u.password = 'regular'
  u.confirmed_at = 100.days.ago
end

# create bunch of identical issues
100.times do |i|
  Issue.create(
    title: "Simple Issue #{i.next}",
    description: "Simple Description #{i.next}",
    status: Issue::STATUSES.sample,
    updated_at: i.days.ago,
    owner: regulars.sample,
    assignee: managers.sample)
end
