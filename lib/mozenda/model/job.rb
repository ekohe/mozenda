module Mozenda::Model
  class Job < Mozenda::Model::Base

    def self.get job_id
      request = Mozenda::Request::JobGet.new(:job_id => job_id)
      request.send!
    end

    def self.resume job_id
      request = Mozenda::Request::JobResume.new(:job_id => job_id)
      request.send!
    end

    def self.pause job_id
      request = Mozenda::Request::JobPause.new(:job_id => job_id)
      request.send!
    end

    def self.cancel job_id
      request = Mozenda::Request::JobCancel.new(:job_id => job_id)
      request.send!
    end

  end
end
