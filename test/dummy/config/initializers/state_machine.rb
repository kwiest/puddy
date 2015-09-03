require 'state_machine/version'

unless StateMachine::VERSION == '1.2.0'
  Rails.logger.warn 'Please update to State Machine ~> 1.2.0'
end

module StateMachine::Integrations::ActiveModel
  public :around_validation
end
