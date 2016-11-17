class CfoundryClient
  module Jobs
    ##
    # See https://apidocs.cloudfoundry.org/246/jobs/retrieve_job_that_is_queued.html
    def job(job_guid)
      get("jobs/#{job_guid}")
    end
  end
end