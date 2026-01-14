# ./lib/unifi/client/vouchers.rb
module Unifi
  class Client

    require_relative 'response_normalizer'

    module Vouchers
      include ResponseNormalizer

      def create_voucher(options = {}, site = @site)
        body = { cmd: 'create-voucher',
                 expire: options[:expire] ||= 120,
                 n: options[:amount] ||= 1,
                 quota: options[:quota] ||= 1 }
        body[:note] = options[:note] if options[:note]
        body[:up] = options[:up] if options[:up]
        body[:down] = options[:down] if options[:down]
        body[:bytes] = options[:bytes] if options[:bytes]
        normalize_unifi_response(self.class.post("/s/#{site}/cmd/hotspot",
                                   { body: body.to_json } ))
      end

      def stat_voucher(create_time = nill, site = @site)
        body = { create_time: create_time }
        normalize_unifi_response(self.class.get("/s/#{site}/stat/voucher",
                                   { body: body.to_json }))
      end

      def revoke_voucher(voucher_id = nill, site = @site)
        body = { cmd: 'delete-voucher', _id: voucher_id }
        normalize_unifi_response(self.class.post("/s/#{site}/cmd/hotspot",
                                   { body: body.to_json } ))
      end

    end

  end
end