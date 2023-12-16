class ReputationJob < ApplicationJob
  queue_as :default

  def perform(object)
    Calculation::Reputation.calculate(object)
  end
end
