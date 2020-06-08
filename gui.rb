require_relative 'files.rb'     #FileObserver 

require 'fox16'

include Fox



class SyncWindow < FXMainWindow
  def initialize(app)
    super(app, "SyncWindow", :width => 200, :height => 100)

    left_matrix = FXMatrix.new(self, 2, MATRIX_BY_ROWS | LAYOUT_FILL )    #Skapar en matrix för att lägga in knapparna 
    
    open_dir_btn = FXButton.new(left_matrix, "Choose Directory...", :opts => BUTTON_NORMAL|LAYOUT_RIGHT)   #knapp för att välja en mapp på datorn
    open_dir_btn.connect(SEL_COMMAND) do |sender, sel, data|
      
      dialog = FXDirDialog.new(self, "Choose Directory")
      dialog.directory = ""
      if dialog.execute != 0
    
        search_directory(dialog.directory)  #anropar funktion
      end
    end
    
    update_button = FXButton.new(left_matrix, "Update", :opts => BUTTON_NORMAL|LAYOUT_LEFT)    #Knapp för att uppdatera listorna och kolla igenom sökvägen för nya/uppdaterade eller raderade filer.
    update_button.connect(SEL_COMMAND) do |sender, sel, data|
      @fo.update_files
    end
  end
  
  
  
  
  def search_directory(dir)    #Funktionen söker igenom alla filer i den angivna sökvägen och skriver sedan ut resultatet i cmd. 
    p dir 
    @fo = FileObserver.new(dir)
    @fo.update_files 
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



#Utvärdering
#Klassen löser sin uppgift någorlunda bra. Man kan lätt välja sökväg och sedan lista upp alla filer och sedan uppdatera listan lätt med en knapp. 
#Sedan skrivs listan ut i cmd så att man kan se sina filer. 
#För att klassen ska lyckas lösa sin uppgift på bästa sätt så skulle det varit bra ifall man kunde få resultat i gui och inte i kommandotolken.
#Samt kunde man också få in lite debug utskrifter ifall man till exempel ska updatera listan när det inte finns någon lista så att programmet inte kraschar. 