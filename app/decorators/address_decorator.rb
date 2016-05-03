class AddressDecorator < Draper::Decorator
  delegate_all

  def to_s
    [
      [object.firstname, object.lastname].reject { |e| e.blank? }.join(' '),
      object.address1,
      object.address2,
      [object.zipcode, object.city].reject { |e| e.blank? }.join(' ')
    ].reject { |e| e.blank? }.join(', ')
  end

  def partial_to_s
    [object.zipcode, object.city].reject { |e| e.blank? }.join(' ')
  end
end
