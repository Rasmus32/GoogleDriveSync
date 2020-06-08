

class FileObserver
    def initialize(target_dir)    #Skapar alla listor och hasg
        @file_inventory = {}
        @updated_files = []
        @new_files = []
        @deleted_files = []
        @target_dir = target_dir
    end
     
    def update_files
        @target_dir.gsub!("\\", "//")    #byter ut \ mot / annars funkar ej sökvägen
        path = File.join( @target_dir, "**/*" ) 
        files = Dir.glob(path) # "hämtar" alla filer
        files.each do |file|   #går igenom varje fil 
            begin 
                if File.file?( file )    #kollar ifall filen är en fil eller en mapp 
                    filetime = File.mtime(file) 
                    if @file_inventory.has_key?(file)   #Har vi redan indexerat filen?
                        if @file_inventory[file] != filetime #kollar ifall mtime är desamma och kollar med indexering
                            @file_inventory[file] = filetime 
                            @updated_files << file 
                        end
                    else
                        @file_inventory[file] = File.mtime(file)     #om det är en ny fil läggs den till
                        @new_files << file 
                    end
                    
                end
            rescue => e
                puts e.message  #felhantering
            end
        end
        
        @file_inventory.each do |file, mtime|     #kollar raderade filer
            if !files.include?(file)
                @deleted_files << file            #lägger till i en separat lista 
                @file_inventory.delete(file)
            end
            
        end
        puts "Det här är raderade filer #{@deleted_files}"       #output
        puts "-------------------------------------------"
        puts "Det här en uppdaterade filer #{@updated_files} "
        puts "-------------------------------------------"
        puts  "Det här en nya filer #{@new_files} "
        puts "-------------------------------------------"
        puts "Det här är alla filer #{@file_inventory}"
        @new_files = []       
        @updated_files = [] 
        @deleted_files = []
    end  

end




#Utvärdering 
#Klassen löser sin uppgift bra. 

