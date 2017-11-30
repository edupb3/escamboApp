class Member < ActiveRecord::Base
  
  ratyrate_rater
  
  has_many :ads
  has_one :profile_menber
  accepts_nested_attributes_for :profile_menber
  
  # Validations
  validate :nested_attributes
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def nested_attributes
    if nested_attributes_blank?
      errors.add(:base, "É necessário preencher os campos Primeiro e Segundo nome.")
    end
  end

  def nested_attributes_blank?
    profile_menber.first_name.blank? || profile_menber.last_name.blank?
  end
  
end
