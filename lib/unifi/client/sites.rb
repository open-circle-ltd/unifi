# ./lib/unifi/client/sites.rb
module Unifi
  class Client

    require_relative 'response_normalizer'

    module Sites
      include ResponseNormalizer

      def add_site(description, site = @site)
        body = { cmd: 'add-site', desc: description }
        normalize_unifi_response(self.class.post("/s/#{site}/cmd/sitemgr", { body: body.to_json }))
      end


      def delete_site(site_id, site = @site)
        body = { site: site_id, cmd: 'delete-site' }
        normalize_unifi_response(self.class.post("/s/#{site}/cmd/sitemgr", { body: body.to_json }))
      end

      def list_sites
        normalize_unifi_response(self.class.get("/self/sites"))
      end

      def stat_sites
        normalize_unifi_response(self.class.get("/stat/sites"))
      end

      def stat_sysinfo(site = @site)
        normalize_unifi_response(self.class.get("/s/#{site}/stat/sysinfo"))
      end

    end

  end
end