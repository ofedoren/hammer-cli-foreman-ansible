# frozen_string_literal: true

module HammerCLIForemanAnsible
  module CommandExtensions
    class Inventory < HammerCLI::CommandExtensions
      output do |definition|
        definition.append do
          field :hostname, _('Name')
          field :fqdh, _('fqdh')
          field :hostgroup, _('hostgroup')
          field :location, _('location')
          field :organization, _('organization')
          field :domainname, _('domain')
          field :foreman_domain_description, _('foreman_domain_description')
          field :owner_name, _('owner_name')
          field :owner_email, _('owner_email')
          field :ssh_authorized_keys, _('ssh_authorized_keys')
          field :root_pw, _('root_pw')
          field :foreman_config_groups, _('foreman_config_groups')
          field :puppetmaster, _('puppetmaster')
          field :foreman_env, _('foreman_env')

          field :ansible_roles_check_mode, _('ansible_roles_check_mode')
          field :host_packages, _('host_packages')
          field :host_registration_insights, _('host_registration_insights')
          field :host_registration_remote_execution, _('host_registration_remote_execution')
          field :remote_execution_ssh_keys, _('remote_execution_ssh_keys')
          field :remote_execution_ssh_user, _('remote_execution_ssh_user')
          field :remote_execution_effective_user_method, _('remote_execution_effective_user_method')
          field :remote_execution_connect_by_ip, _('remote_execution_connect_by_ip')

          collection :foreman_subnets, _('Subnets') do
            field :name, _('name')
            field :network, _('network')
            field :mask, _('mask')
            field :gateway, _('gateway')
            field :dns_primary, _('dns_primary')
            field :dns_secondary, _('dns_secondary')
            field :from, _('from')
            field :to, _('to')
            field :boot_mode, _('boot_mode')
            field :ipam, _('ipam')
            field :vlanid, _('vlanid')
            field :mtu, _('mtu')
            field :nic_delay, _('nic_delay')
            field :network_type, _('network_type')
            field :description, _('description')
          end

          collection :foreman_interfaces, _('Network interfaces') do
            field :name, _('Interface Name')
            field :identifier, _('Identifier')
            field :attrs, _('Attributes'), Fields::Field, hide_blank: true
            field :mac, _('MAC address')
            field :ip, _('IPv4 address'), Fields::Field, hide_blank: true
            field :ip6, _('IPv6 address'), Fields::Field, hide_blank: true
            field :fqdn, _('FQDN')
            field :virtual, _('Virtual')
            field :link, _('Link')
            field :managed, _('managed')
            field :primary, _('Primary')
            field :provision, _('Provision')
            field :subnet6, _('subnet6')
            field :tag, _('tag')
            field :attached_to, _('attached_to')
            field :type, _('Bridge')
            field :attached_devices, _('attached_devices')
            collection :subnet, _('Subnet'), numbered: false, hide_blank: true do
              field :name, _('name')
              field :network, _('network')
              field :mask, _('mask')
              field :gateway, _('gateway')
              field :dns_primary, _('dns_primary')
              field :dns_secondary, _('dns_secondary')
              field :from, _('from')
              field :to, _('to')
              field :boot_mode, _('boot_mode')
              field :ipam, _('ipam')
              field :vlanid, _('vlanid')
              field :mtu, _('mtu')
              field :nic_delay, _('nic_delay')
              field :network_type, _('network_type')
              field :description, _('description')
            end
          end

          collection :foreman_users, _('Foreman Users'), numbered: false do
            field :firstname, _('firstname')
            field :lastname, _('lastname')
            field :mail, _('mail')
            field :description, _('description')
            field :fullname, _('fullname')
            field :ssh_authorized_keys, _('ssh_authorized_keys')
          end

          collection :foreman_ansible_roles, _('Foreman Ansible Roles'), numbered: false do
            field :name, _('Role')
          end
        end
      end

      before_print do |data|
        new_data = data['all']['hosts'].each_with_object([]) do |hostname, arr|
          data['_meta']['hostvars'][hostname]['foreman']['foreman_users'] = data['_meta']['hostvars'][hostname]['foreman']['foreman_users']&.map { |u| u[1] }
          arr << {
            'hostname' => hostname
          }.merge(data['_meta']['hostvars'][hostname]['foreman'])
        end
        data.clear
        data['results'] = new_data
      end
    end
  end
end
