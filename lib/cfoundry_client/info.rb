class CfoundryClient
  module Info
    def cloud_info
      get('info')
    end
  end
end