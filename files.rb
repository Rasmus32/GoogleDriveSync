#skapa borttagna filer lista. 






class FileObserver 
    
    
    
    
    def initialize(target_dir)
        @file_inventory = {}
        @updated_files = []
        @new_files = []
        @deleted_files = []
        @target_dir = target_dir
    end
    
    
    def update_files
        target_dir = "C:/Users/Rasmus.noord/Desktop/Filer/"    
        path = File.join( @target_dir, "**/*" ) 
        files = Dir.glob(path) # "hämtar" alla filer
        files.each do |file|   #går igenom varje fil 
            begin 
                if File.file?( file )
                    filetime = File.mtime(file) 
                    #@file_inventory[file] = File.mtime(file)
                    
                    if @file_inventory.has_key?(file)   #Har vi redan indexerat filen?
                        p "finns redan "     
                        if @file_inventory[file] != filetime #kollar ifall mtime är desamma och kollar med indexering
                            @file_inventory[file] = filetime 
                            @updated_files << file 
                        end
                    else
                        @file_inventory[file] = File.mtime(file)
                        @new_files << file 
                    end
                    
                end
            rescue => e
                puts e.message
            end
        end
        
        @file_inventory.each do |file, mtime|
            if !files.include?(file)
                @deleted_files << file 
                @file_inventory.delete(file)
            end
            
        end
        puts "Det här är raderade filer #{@deleted_files}"
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

#kolla ifall det fungerar och skapa nya filer, ändra kolla ifall det funkar. 
