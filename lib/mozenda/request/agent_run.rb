module Mozenda::Request
  class AgentRun < Mozenda::Request::Base

    def initialize options
      super
      put_additional_param("AgentID", options[:agent_id])
      params = options[:params] || {}
      params.each_pair do |name, value|
        put_additional_param("AgentParameter.#{name}", value)
      end
      # TODO: job params
    end

    private

    OPERATION = "Agent.Run"
    REQUIRED_PARAMS = ["AgentID", "Operation"].freeze

  end
end
