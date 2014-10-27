module Mozenda::Model
  class Agent < Mozenda::Model::Base

    def initialize agent_id
      @id = agent_id
    end

    def run params = {}, job_params = {}
      request = Mozenda::Request::AgentRun.new({
        :agent_id => @id,
        :params => params,
        :job_params => job_params
      })
      request.send!
    end

    def get
      request = Mozenda::Request::AgentGet.new(:agent_id => @id)
      request.send!
    end

  end
end
