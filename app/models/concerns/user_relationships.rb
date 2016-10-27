module UserRelationships
  extend ActiveSupport::Concern
  included do
    has_many :users_roles
    has_many :roles, through: :users_roles
    has_many :user_services
    has_many :services, through: :user_services
    has_many :user_appointments, class_name: 'Appointment', foreign_key: 'user_id'
    has_many :provider_appointments, class_name: 'Appointment', foreign_key: 'provider_id'

    belongs_to :tenant
    belongs_to :schedule
  end
end
