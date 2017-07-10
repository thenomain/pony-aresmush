module AresMUSH
  module Scenes
    class SceneReplaceCmd
      include CommandHandler
      
      attr_accessor :pose, :scene_num
      
      def parse_args
        self.scene_num = enactor_room.scene ? enactor_room.scene.id : nil
        self.pose = cmd.args
      end
      
      def required_args
        {
          args: [ self.pose ],
          help: 'scene replace'
        }
      end
      
      def handle        
        Scenes.with_a_scene(self.scene_num, client) do |scene|

          all_poses = scene.scene_poses.select { |p| p.character == enactor }
          last_pose = all_poses[-1]

          if (!last_pose)
            client.emit_failure t('scenes.no_pose_found')
            return
          end
            
          last_pose.update(pose: self.pose)
          scene.room.emit_ooc t('scenes.amended_pose', :name => enactor_name, :pose => self.pose)
        end
      end
    end
  end
end