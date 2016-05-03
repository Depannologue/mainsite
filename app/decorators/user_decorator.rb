class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    [object.firstname, object.lastname].reject { |e| e.blank? }.join(' ')
  end
end
