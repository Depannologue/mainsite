# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                  :string

class Profession < ActiveRecord::Base
  has_many :InterventionType

  def self.plomberie
    plomberie = Profession.where(name: 'Plomberie').first
    InterventionType.where(profession_id: plomberie.id)
  end

  def self.serrurerie
    serrurerie = Profession.where(name: 'Serrurerie').first
    InterventionType.where(profession_id: serrurerie.id)
  end

  def self.vitrerie
    vitrerie = Profession.where(name: 'Vitrerie').first
    InterventionType.where(profession_id: vitrerie.id)
  end


end
