# ./lib/unifi/client/main.rb
module Unifi
  class Client
    module Main
+      include ResponseNormalizer

      def list_dashboard(site: @site)
-        response = self.class.get("/s/#{site}/stat/dashboard")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/dashboard"))
      end

      def list_clients(mac = '', site: @site)
-        response = self.class.get("/s/#{site}/stat/sta/#{mac.delete(' :')}")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/sta/#{mac.delete(' :')}") )
      end

      def stat_client(mac = '', site: @site)
-        response = self.class.get("/s/#{site}/stat/user/#{mac.delete(' :')}")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/user/#{mac.delete(' :')}") )
      end

      def list_devices(mac = '', site: @site, udm: @udm)
-        response = if udm
-                     self.class.get("/s/#{site}/stat/device/#{mac.delete(' :')}")
-                   elsif mac.is_a?(Array)
-                     self.class.post("/s/#{site}/stat/device/",
-                                     body: { macs: mac }.to_json)
-                   else
-                     self.class.get("/s/#{site}/stat/device")
-                   end
-        response.parsed_response
+        response = if udm
+                     self.class.get("/s/#{site}/stat/device/#{mac.delete(' :')}")
+                   elsif mac.is_a?(Array)
+                     self.class.post("/s/#{site}/stat/device/",
+                                     body: { macs: mac }.to_json)
+                   else
+                     self.class.get("/s/#{site}/stat/device")
+                   end
+
+        normalize_unifi_response(response)
      end

      def list_devices_v2(site: @site)
-        base_uri = "https://#{@url}:#{@port}/v2/api"
-        response = self.class.get("/site/#{site}/device", base_uri: base_uri)
-        response.parsed_response
+        base_uri = "https://#{@url}:#{@port}/v2/api"
+        normalize_unifi_response(self.class.get("/site/#{site}/device", base_uri: base_uri))
      end

      def list_updates(id, site: @site)
-        response = self.class.put("/s/#{site}/rest/device/#{id}")
-        response.parsed_response
+        normalize_unifi_response(self.class.put("/s/#{site}/rest/device/#{id}"))
      end

      def list_dynamicdns(site: @site)
-        response = self.class.get("/s/#{site}/list/dynamicdns")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/list/dynamicdns"))
      end

      def list_events(options = {}, site: @site)
        body = { _sort: '-time' }
        body[:within] = options[:historyhours] || 720
        body[:_start] = options[:start] || 0
        body[:_limit] = options[:limit] || 3000
-        response = self.class.get("/s/#{site}/stat/event", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/event", { body: body.to_json }))
      end

      def list_extension(site: @site)
-        response = self.class.get("/s/#{site}/list/extension")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/list/extension"))
      end

      def list_health(site: @site)
-        response = self.class.get("/s/#{site}/stat/health")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/health"))
      end

      def list_hotspotop(site: @site)
-        response = self.class.get("/s/#{site}/list/hotspotop")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/list/hotspotop"))
      end

      def list_networkconf(site: @site)
-        response = self.class.get("/s/#{site}/list/networkconf")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/list/networkconf"))
      end

      def list_portconf(site: @site)
-        response = self.class.get("/s/#{site}/list/portconf")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/list/portconf"))
      end

      def list_portforward_stats(site: @site)
-        response = self.class.get("/s/#{site}/stat/portforward")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/portforward"))
      end

      def list_rogueaps(within = 24, site: @site)
        body = { within: within }
-        response = self.class.get("/s/#{site}/stat/rogueap", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/rogueap", { body: body.to_json }))
      end

      def list_self(site: @site)
-        response = self.class.get("/s/#{site}/self")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/self"))
      end

      def list_settings(site: @site)
-        response = self.class.get("/s/#{site}/get/setting")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/get/setting"))
      end

      def list_usergroups(site: @site)
-        response = self.class.get("/s/#{site}/list/usergroup")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/list/usergroup"))
      end

      def list_users(site: @site)
-        response = self.class.get("/s/#{site}/list/user")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/list/user"))
      end

      def list_current_channels(site: @site)
-        response = self.class.get("/s/#{site}/stat/current-channel")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/current-channel"))
      end

      def list_dpi_stats(site: @site)
-        response = self.class.get("/s/#{site}/stat/dpi")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/dpi"))
      end

      def reconnect_sta(mac, site: @site)
        body = { cmd: 'kick-sta', mac: mac.downcase }
-        response = self.class.post("/s/#{site}/cmd/sitemgr", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.post("/s/#{site}/cmd/sitemgr", { body: body.to_json }))
      end

      def rename_ap(ap_id, apname, site: @site)
        body = { name: apname }
-        response = self.class.get("/s/#{site}/upd/device/#{ap_id.delete(' ')}", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/upd/device/#{ap_id.delete(' ')}", { body: body.to_json }))
      end

      def restart_ap(mac, site: @site)
        body = { cmd: 'restart', mac: mac.downcase }
-        response = self.class.get("/s/#{site}/cmd/devmgr", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/cmd/devmgr", { body: body.to_json }))
      end

      def stat_sta_sessions_latest(mac, limit = 5, site: @site)
        body = { mac: mac.downcase, _limit: limit, _sort: '-assoc_time' }
-        response = self.class.get("/s/#{site}/stat/session", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/session", { body: body.to_json }))
      end

      def stat_sessions(start_time = nil, end_time = Time.now.to_i, mac = nil, site: @site)
        body = { start: start_time || end_time - (7 * 24 * 3600), end: end_time, type: 'all' }
        body[:mac] = mac if mac
-        response = self.class.get("/s/#{site}/stat/session", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/session", { body: body.to_json }))
      end

      def stat_payment(within = nil, site: @site)
-        response = self.class.get("/s/#{site}/stat/payment#{within ? "?within=#{within}" : ''}")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/payment#{within ? "?within=#{within}" : ''}"))
      end

      def stat_hourly_site(start_time = nil, end_time = Time.now.to_i * 1000, site: @site)
        body = { start: start_time || end_time - (7 * 24 * 3600 * 1000),
                 end: end_time,
                 attributes: %w[bytes
                                wan-tx_bytes
                                wan-rx_bytes wlan_bytes num_sta lan-num_sta wlan-num_sta time] }
-        response = self.class.get("/s/#{site}/stat/report/hourly.site", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/report/hourly.site", { body: body.to_json }))
      end

      def stat_hourly_aps(start_time = nil, end_time = Time.now.to_i * 1000, site: @site)
        body = { start: start_time || end_time - (7 * 24 * 3600 * 1000),
                 end: end_time,
                 attrs: %w[bytes num_sta time] }
-        response = self.class.get("/s/#{site}/stat/report/hourly.ap", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/report/hourly.ap", { body: body.to_json }))
      end

      def stat_daily_aps(start_time = nil, end_time = Time.now.to_i * 1000, site: @site)
        body = { start: start_time || end_time - (7 * 24 * 3600 * 1000),
                 end: end_time,
                 attrs: %w[bytes num_sta time] }
-        response = self.class.get("/s/#{site}/stat/report/daily.ap", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/report/daily.ap", { body: body.to_json }))
      end

      def stat_daily_site(start_time = nil, end_time = Time.now.to_i - (Time.now.to_i % 3600) * 1000, site: @site)
        body = { start: start_time || end_time - (52 * 7 * 24 * 3600 * 1000),
                 end: end_time,
                 attributes: %w[bytes
                                wan-tx_bytes
                                wan-rx_bytes
                                wlan_bytes
                                num_sta
                                lan-num_sta
                                wlan-num_sta
                                time] }
-        response = self.class.get("/s/#{site}/stat/report/daily.site", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/report/daily.site", { body: body.to_json }))
      end

      def stat_auths(start_time = nil, end_time = Time.now.to_i, site: @site)
        body = { start: start_time || end_time - (7 * 24 * 3600),
                 end: end_time }
-        response = self.class.get("/s/#{site}/stat/authorization", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/authorization", { body: body.to_json }))
      end

      def stat_allusers(historyhours = 8760, site: @site)
        body = { type: 'all', conn: 'all', within: historyhours }
-        response = self.class.get("/s/#{site}/stat/alluser", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/alluser", { body: body.to_json }))
      end

      def spectrum_scan_state(mac, site: @site)
-        response = self.class.get("/s/#{site}/stat/spectrum-scan/#{mac.delete(': ')}")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/stat/spectrum-scan/#{mac.delete(': ')}"))
      end

      def spectrum_scan(mac, site: @site)
        body = { cmd: 'spectrum-scan', mac: mac }
-        response = self.class.post("/s/#{site}/cmd/devmgr", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.post("/s/#{site}/cmd/devmgr", { body: body.to_json }))
      end

      def upgrade_device_external(firmware_url, device_mac, site: @site)
        body = { url: firmware_url, mac: device_mac }
-        response = self.class.get("/s/#{site}/cmd/devmgr/upgrade-external", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/cmd/devmgr/upgrade-external", { body: body.to_json }))
      end

      def upgrade_device(mac, site: @site)
        body = { cmd: 'upgrade', mac: mac }
-        response = self.class.post("/s/#{site}/cmd/devmgr", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.post("/s/#{site}/cmd/devmgr", { body: body.to_json }))
      end

      def site_leds(enable, site: @site)
        body = { led_enabled: enable }
-        response = self.class.post("/s/#{site}/set/setting/mgmt", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.post("/s/#{site}/set/setting/mgmt", { body: body.to_json }))
      end

      def delete_usergroup(group_id, site: @site)
-        response = self.class.delete("/s/#{site}/rest/usergroup/#{group_id}")
-        response.parsed_response
+        normalize_unifi_response(self.class.delete("/s/#{site}/rest/usergroup/#{group_id}"))
      end

      def add_usergroup(group_name, group_dn = -1, group_up = -1, site: @site)
        body = { name: group_name, qos_rate_max_down: group_dn, qos_rate_max_up: group_up }
-        response = self.class.get("/s/#{site}/rest/usergroup", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/rest/usergroup", { body: body.to_json }))
      end

      def edit_usergroup(group_id, site_id, group_name, group_dn = -1, group_up = -1, site: @site)
        body = { _id: group_id,
                 name: group_name,
                 qos_rate_max_down: group_dn,
                 qos_rate_max_up: group_up,
                 site_id: site_id }
-        response = self.class.put("/s/#{site}/rest/usergroup/#{group_id}", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.put("/s/#{site}/rest/usergroup/#{group_id}", { body: body.to_json }))
      end

      def set_usergroup(user_id, group_id, site: @site)
        body = { usergroup_id: group_id }
-        response = self.class.get("/s/#{site}/upd/user/#{user_id}", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/upd/user/#{user_id}", { body: body.to_json }))
      end

      def set_sta_note(user_id, note = nil, site: @site)
        body = { noted: note ? true : false }
        body[:note] = note if note
-        response = self.class.get("/s/#{site}/upd/user/#{user_id}", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/upd/user/#{user_id}", { body: body.to_json }))
      end

      def set_sta_name(user_id, name = '', site: @site)
        body = { name: name }
-        response = self.class.get("/s/#{site}/upd/user/#{user_id}", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/upd/user/#{user_id}", { body: body.to_json }))
      end

      def locate_ap(mac, enable, site: @site)
        body = { cmd: enable ? 'set-locate' : 'unset-locate', mac: mac.downcase }
-        response = self.class.get("/s/#{site}/cmd/devmgr", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/cmd/devmgr", { body: body.to_json }))
      end

      def set_ap_radiosettings(_ap_id, radio, channel, ht, tx_power_mode, tx_power, site: @site)
        body = { radio_table: { radio: radio,
                                channel: channel,
                                ht: ht,
                                tx_power_mode: tx_power_mode,
                                tx_power: tx_power } }
      end

      def count_alarms(archived, site: @site)
-        response = self.class.get("/s/#{site}/cnt/alarm#{archived ? '' : '?archived=false'}")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/cnt/alarm#{archived ? '' : '?archived=false'}"))
      end

      def list_alarms(site: @site)
-        response = self.class.get("/s/#{site}/list/alarm")
-        response.parsed_response
+        normalize_unifi_response(self.class.get("/s/#{site}/list/alarm"))
      end

      def list_admins(site: @site)
        body = { cmd: 'get-admins' }
-        response = self.class.post("/s/#{site}/cmd/sitemgr", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.post("/s/#{site}/cmd/sitemgr", { body: body.to_json }))
      end

      def led_override(device_id, override_mode, site: @site)
        body = { led_override: override_mode }
        if %w[off on default].include?(override_mode)
-          response = self.class.put("/s/#{site}/rest/device/#{device_id}", { body: body.to_json })
-          response.parsed_response
+          normalize_unifi_response(self.class.put("/s/#{site}/rest/device/#{device_id}", { body: body.to_json }))
         else
           false
         end
       end

       def disable_ap(ap_id, disable, site: @site)
         body = { disabled: disable }
-        response = self.class.put("/s/#{site}/rest/device/#{ap_id}", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.put("/s/#{site}/rest/device/#{ap_id}", { body: body.to_json }))
       end

       def create_hotspotop(name, x_password, note = '', site: @site)
         body = { name: name, x_password: x_password }
         body[:note] = note if note
-        response = self.class.post("/s/#{site}/rest/hotspotop", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.post("/s/#{site}/rest/hotspotop", { body: body.to_json }))
       end

       def unblock_sta(mac, site: @site)
         body = { cmd: 'unblock-sta', mac: mac.downcase }
-        response = self.class.post("/s/#{site}/cmd/stamgr", { body: body.to_json })
-        response.parsed_response
+        normalize_unifi_response(self.class.post("/s/#{site}/cmd/stamgr", { body: body.to_json }))
       end
     end

-    def block_sta(mac, site: @site)
-      body = { cmd: 'block-sta', mac: mac.downcase }
-      response = self.class.post("/s/#{site}/cmd/stamgr", { body: body.to_json })
-      response.parsed_response
-    end
-
-    def adopt_device(mac, site: @site)
-      body = { cmd: 'adopt', mac: mac.downcase }
-      response = self.class.post("/s/#{site}/cmd/stamgr", { body: body.to_json })
-      response.parsed_response
-    end
+    def block_sta(mac, site: @site)
+      body = { cmd: 'block-sta', mac: mac.downcase }
+      normalize_unifi_response(self.class.post("/s/#{site}/cmd/stamgr", { body: body.to_json }))
+    end
+
+    def adopt_device(mac, site: @site)
+      body = { cmd: 'adopt', mac: mac.downcase }
+      normalize_unifi_response(self.class.post("/s/#{site}/cmd/stamgr", { body: body.to_json }))
+    end
   end
 end
