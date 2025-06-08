{
  programs.btop = {
    enable = true;

    settings = {
      presets = "proc:0:default cpu:1:default,mem:0:default";
      rounded_corners = false;
      only_physical = true;
      show_swap = false;
      swap_disk = false;
    };
  };
}
