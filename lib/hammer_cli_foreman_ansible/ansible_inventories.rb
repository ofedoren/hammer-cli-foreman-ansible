# frozen_string_literal: true

module HammerCLIForemanAnsible
  class AnsibleInventoriesCommand < HammerCLIForeman::Command
    resource :ansible_inventories

    class HostsCommand < HammerCLIForeman::InfoCommand
      action :hosts
      command_name 'hosts'

      option '--plain', :flag, ''

      def print_data(data)
        return super unless option_plain?

        puts JSON.pretty_generate(data)
      end

      build_options

      extend_with(HammerCLIForemanAnsible::CommandExtensions::Inventory.new)
    end

    class HostgroupsCommand < HammerCLIForeman::InfoCommand
      action :hostgroups
      command_name 'hostgroups'

      option '--plain', :flag, ''

      def print_data(data)
        return super unless option_plain?

        puts JSON.pretty_generate(data)
      end

      build_options

      extend_with(HammerCLIForemanAnsible::CommandExtensions::Inventory.new)
    end

    class ScheduleCommand < HammerCLIForeman::Command
      action :schedule
      command_name 'schedule'

      build_options
    end

    autoload_subcommands
  end
end
