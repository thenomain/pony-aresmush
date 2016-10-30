module AresMUSH
  module Manage
    class ExamineCmd
      include CommandHandler
      include CommandWithoutSwitches
      include CommandRequiresArgs
      include CommandRequiresLogin
      
      attr_accessor :target
      
      def crack!
        self.target = trim_input(cmd.args)
      end
      
      def required_args
        {
          args: [ self.target ],
          help: 'examine'
        }
      end
      
      def handle
        search = VisibleTargetFinder.find(self.target, enactor)
        if (search.found?)
          model = search.target
        else
          search = AnyTargetFinder.find(self.target, enactor)
          if (!search.found?)
            client.emit_failure search.error
            return
          end
          model = search.target
        end
        
        if (!Manage.can_manage_object?(enactor, model))
          client.emit_failure t('dispatcher.not_allowed')
          return
        end

        line = "-".repeat(78)
        json = model.print_json
        
        client.emit_raw "#{line}\n#{model.name}\n\n#{json}#{}\n#{line}"
      end
      
      def print_model
      end
    end
  end
end
