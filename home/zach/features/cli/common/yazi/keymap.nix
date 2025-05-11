{
  manager = {
    prepend_keymap = [
      {
        on = ["c" "m"];
        run = "plugin chmod";
        desc = "Chmod on selected files";
      }
      {
        on = ["<C-d>"];
        run = "plugin diff";
        desc = "Diff the selected with the hovered file";
      }
      {
        on = ["f"];
        run = "plugin jump-to-char";
        desc = "Jump to char";
      }
      {
        on = ["F"];
        run = "plugin smart-filter";
        desc = "Smart filter";
      }
    ];
  };
}
