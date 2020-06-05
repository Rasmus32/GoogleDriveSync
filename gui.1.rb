

require 'fox16'

include Fox


class Controller 
  def initialize
    @syncing_activated = false
  end
  
  def syncing         
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
    
    left_matrix = FXMatrix.new(self, 2, MATRIX_BY_ROWS | LAYOUT_FILL )
    
    open_dir_btn = FXButton.new(left_matrix, "Choose Directory...", :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
    open_dir_btn.connect(SEL_COMMAND) do |sender, sel, data|
      
      dialog = FXDirDialog.new(self, "Choose Directory")
      dialog.directory = "/Users/lyle"
      if dialog.execute != 0
        open_directory(dialog.directory)
      end
    end
    
    sync_button = FXButton.new(left_matrix, "Synca", :opts => BUTTON_NORMAL|LAYOUT_LEFT)
    sync_button.connect(SEL_COMMAND) do |sender, sel, data|
      @controller.syncing
    end
  end
  
  
  
  
  def open_directory(dir)
    puts dir  
  end
  
  
  
  
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  
  
  
  
  if __FILE__ == $0
    FXApp.new do |app|
      SyncWindow.new(app)
      app.create
      app.run
    end
  end
end
