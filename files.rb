class FileObserver 
    def initialize(target_dir)
        @file_inventory = {}
        @updated_files = []
        @target_dir = target_dir
    end
    
    def get_files
        # target_dir = "C:/Users/Rasmus.noord/Desktop/Filer/"
        path = File.join( @target_dir, "**/*" )
        files = Dir.glob(path)
        files.each do |file|
            begin    
                if File.file?( file )
                    file_full_path = File.join( @target_dir, file ) 
                    @file_inventory[file_full_path] = File.mtime(file)
                end
            rescue => e
                puts e.message
            end
        end
    end
        
    def update_files
        path = File.join( @target_dir, "**/*" )
        files = Dir.glob(path)
        files.each do |file|
            if @file_inventory.has_key?(file) #Har vi redan indexerat filen?
                filetime = File.mtime(file)
                if @file_inventory[file] != filetime
                    @file_inventory[file] = filetime 
                    @updated_files << file 
                end
            else  #Ifall det är en ny fil 
                @file_inventory[file] = File.mtime(file)
                @update_files << file 
            end
        end 
    end
end