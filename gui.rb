#Kunna visa att en specifik mapp används. Se in i mappen?, Lägga till mappar, 
#sync knapp och som sedan gör att filerna uppdateras 


#Idag
#Fixa en mapp som man kan kolla i med fixerade namn 
#Sync knapp (som inte gör något)


require 'fox16'

include Fox


class Controller 
  def initialize
    @syncing_activated = false
  end
  
  def syncing          #debug?
    if @syncing_activated == false 
      @syncing_activated = true
      puts "Syncing Files"
      #Synca via file observer?
      sleep 0.5  #Bara för att härma tiden det tar för file observer att köra 
    end
    puts "Done syncing"         #Får någon slags resultat från Fo som slutar denna?
    @syncing_activated = false
  end
  
  
end 


class SyncWindow < FXMainWindow
  def initialize(app)
    super(app, "Sync and stuff", :width => 400, :height => 300)
    @controller = Controller.new
    p = FXHorizontalFrame.new(self, :opts => LAYOUT_FILL_X|LAYOUT_RIGHT)
    
    sync_button = FXButton.new(p, "Synca",
      :opts => BUTTON_NORMAL|LAYOUT_CENTER_X)
      sync_button.connect(SEL_COMMAND) do |sender, sel, data|
        @controller.syncing
      end
    end
    
    def create
      super
      show(PLACEMENT_SCREEN)
    end
  end    
  
  
  
  if __FILE__ == $0
    FXApp.new do |app|
      SyncWindow.new(app)
      app.create
      app.run
    end
  end
  