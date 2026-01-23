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
          mv $dest.tmp $dest
        else
          mv $orig $dest
          cp $dest $orig
          chmod ug+w $orig
        end
      '';
    };
    gwip = {
      description = "Commit all current changes with a WIP message.";
      body = ''
        git add -A
        git rm $(git ls-files --deleted) 2> /dev/null
        git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"
      '';
    };
  };
}
