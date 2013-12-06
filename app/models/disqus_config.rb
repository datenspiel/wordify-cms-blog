module WordifyCms
  module Blog

    class DisqusConfig
      include ::Mongoid::Document

      field :api_key,         :type => String
      field :api_secret,      :type => String
      field :access_token,    :type => String
      field :blog_authorized, :type => Boolean, :default => false

      validates_presence_of :api_key
      validates_presence_of :api_secret
      validates_presence_of :access_token

      attr_accessible :api_key,
                      :api_secret,
                      :access_token

    end
  end
end
