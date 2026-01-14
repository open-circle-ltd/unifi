# Unifi
A Ruby interface to UniFi Controller API. Supported versions 5.x.x, 6.x.x and 7.x.x. 8.x.x is currently untested.
It's fork [Unifi Api Browser](https://github.com/malle-pietje/UniFi-API-browser/blob/master/phpapi/class.unifi.php) written in php.

## Versioning & Installation

- This gem uses a single source of truth for the version in lib/unifi/version.rb.
- To use a specific version of the gem directly from GitHub, reference a tag in your project's `Gemfile`:

```ruby
gem 'unifi', git: 'https://github.com/open-circle-ltd/unifi', tag: 'v0.1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unifi

- We run Semantic Release on merges to `main`. When a PR is merged with Conventional Commit messages, the workflow will:
    - determine the next semantic version,
    - update `lib/unifi/version.rb`,
    - create a git tag (e.g. `v1.2.3`) and a GitHub release.

- If you prefer to pin to a commit instead of a tag, use `ref:` with the commit SHA:

```ruby
gem 'unifi', git: 'https://github.com/open-circle-ltd/unifi', ref: 'a1b2c3d'
```

## Usage

Unifi gem needs url, site, login, password:

```ruby
client = Unifi::Client.new({url:"demo.ubnt.com", 
                            site: "default"
                            username:"superadmin", 
                            password:"superadmin"})
client.list_health
```
It will return something like that:
```
{"data"=>[{"num_adopted"=>118, "num_ap"=>118, "num_disabled"=>0, 
"num_disconnected"=>0, "num_guest"=>0, "num_pending"=>0, 
"num_user"=>1180, "rx_bytes-r"=>504, "status"=>"ok", 
"subsystem"=>"wlan", "tx_bytes-r"=>535}...}
```

Create new voucher code:
```ruby
client.create_voucher({expire: 360, note: 'test-voucher'})
```
It will return something like that:
```
{"data"=>[{"create_time"=>1500804202}], "meta"=>{"rc"=>"ok"}}
```
Get voucher code, need create_time in second:
```ruby
client.stat_voucher(1500804202)
```
It will return something like that:
```
{"data"=>[{"_id"=>"5974746a619469d63475866a", 
"admin_name"=>"sergey", "code"=>"9224743381", ...}], 
"meta"=>{"rc"=>"ok"}}
```

* list_health
* list_hotspotop
* list_networkconf
* list_portconf
* list_portforward_stats
* list_portforwarding
* list_rogueaps
* list_self
* list_settings
* list_sites
* list_usergroups
* list_users
* list_wlan_groups
* list_wlanconf
* list_current_channels
* list_dpi_stats
* reconnect_sta
* rename_ap
* restart_ap
* revoke_voucher
* extend_guest_validity
* set_ap_radiosettings
* set_guestlogin_settings
* set_sta_name
* set_sta_note
* set_usergroup
* edit_usergroup
* add_usergroup
* delete_usergroup
* set_wlansettings
* create_wlan
* delete_wlan
* site_leds
* upgrade_device
* upgrade_device_external
* spectrum_scan
* spectrum_scan_state
* stat_allusers
* stat_auths
* stat_client
* stat_daily_site
* stat_daily_aps
* stat_hourly_aps
* stat_hourly_site
* stat_payment
* stat_sessions
* stat_sites
* stat_sta_sessions_latest
* stat_sysinfo
* stat_voucher

You can see the documentation for the methods [here](https://github.com/malle-pietje/UniFi-API-browser/blob/master/phpapi/class.unifi.php).

## Useful links

* [Original Unifi API Browser](https://github.com/malle-pietje/UniFi-API-browser)
* [API as published by Ubiquiti](https://www.ubnt.com/downloads/unifi/5.4.14/unifi_sh_api)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zumkorn/unifi. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).