module AresMUSH

  module FS3Skills
    class RemoveHookCmd
      include CommandHandler
      
      attr_accessor :name, :char_name

      def parse_args
        # Admin version
        if (cmd.args =~ /\=/)
          args = cmd.parse_args(ArgParser.arg1_equals_arg2)
          self.char_name = titlecase_arg(args.arg1)
          self.name = titlecase_arg(args.arg2)
        else
          self.name = titlecase_arg(cmd.args)
          self.char_name = enactor_name
        end          
      end

      def required_args
        [ self.name, self.char_name ]
      end
      
      def check_can_set
        return nil if enactor_name == self.char_name
        return nil if FS3Skills.can_manage_abilities?(enactor)
        return t('dispatcher.not_allowed')
      end    
      
      def handle        
        ClassTargetFinder.with_a_character(self.char_name, client, enactor) do |model|
          hook = model.fs3_hooks.find(name: self.name).first
          if (!hook)          
            client.emit_failure t('fs3skills.hook_not_found', :name => self.name)
          else
            hook.delete
            client.emit_success t('fs3skills.hook_removed', :name => self.name)
          end
        end
      end
    end
  end
end
