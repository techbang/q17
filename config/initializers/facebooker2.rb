Facebooker2.load_facebooker_yaml

module Facebooker2
  module Rails
    module Controller
      # http://api.rubyonrails.org/classes/ActionDispatch/Cookies.html
      # http://blog.kabisa.nl/2010/10/27/share-sessions-between-rails-2-and-rails-3-applications/
      def set_fb_cookie(access_token,expires,uid,sig)
        # default values for the cookie
        value = 'deleted'
        expires = Time.now.utc - 3600 unless expires != nil

        if access_token
          data = fb_cookie_hash || {}
          data.merge!('access_token' => access_token, 'uid' => uid, 'sig' => sig, "expires" => expires.to_i.to_s)
          value = '"'
          data.each do |k,v|
            value += "#{k.to_s}=#{v.to_s}&"
          end
          value.chop!
          value+='"'
        end

        # if an existing cookie is not set, we dont need to delete it
        if (value == 'deleted' && cookies[fb_cookie_name] == "" )
          return;
        end

        # My browser doesn't seem to save the cookie if I set expires
        # cookies[fb_cookie_name] = { :value => value }#, :expires=>expires}

        # set domain to "techbang.com.tw" to allow all subdomains can share cookies
        cookies[fb_cookie_name] = { :value => value, :domain => ".techbang.com.tw" }
      end
    end
  end
end
