class ProAbility
  include CanCan::Ability

  def initialize(pro)
    pro ||= User.new

    can :read, Intervention do |intervention|
      intervention.contractor.blank? ||
      intervention.contractor_id == pro.id
    end
    can :set_contractor, Intervention do |intervention|
      intervention.contractor.blank?
    end
  end
end
