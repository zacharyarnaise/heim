{
  programs.fish.functions = {
    bak = {
      description = "Create a backup of a file by appending .bak to its name. If a backup already exists, rotate the backups.";
      body = ''
        set orig $argv[1]
        set dest "$argv[1].bak"
        if test -e $dest
          mv $orig $dest.tmp
          mv $dest $orig
          mv $orig.tmp $dest
        else
          mv $orig $dest
          cp $dest $orig
          chmod ug+w $orig
        end
      '';
    };
  };
}
