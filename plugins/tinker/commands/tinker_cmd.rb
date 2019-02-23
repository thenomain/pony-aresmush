module AresMUSH
  module Tinker
    class TinkerCmd
      include CommandHandler
      
      def check_can_manage
        return t('dispatcher.not_allowed') if !enactor.has_permission?("tinker")
        return nil
      end
      
def handle
  char = Character.find_one_by_name('Guest-1')
  char.update(alias: "guest")
  char = Character.find_one_by_name(cmd.args)
  if (char)
    client.emit "You found #{char.name}"
  else
    client.emit "Nothing found."
  end
end

    end
  end
end
