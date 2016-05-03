class AdminAbility
  include CanCan::Ability

  def initialize(admin)
    admin ||= User.new
  end
end
