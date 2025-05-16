{
  inputs,
  config,
  ...
}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPerl = false;
    withPython3 = true;
    withRuby = false;

    clipboard.register = "unnamedplus";
    opts = {
      autoindent = true;
      backspace = "indent,eol,start";
      backup = false;
      breakindent = true;
      cindent = true;
      encoding = "utf-8";
      expandtab = true;
      hidden = true;
      linebreak = true;
      list = true;
      listchars = "tab:▸ ,trail:·,extends:>,precedes:<,nbsp:␣";
      number = true;
      relativenumber = true;
      scrolloff = 4;
      shiftwidth = 0;
      showmatch = true;
      sidescroll = 1;
      sidescrolloff = 15;
      smartindent = true;
      smarttab = true;
      swapfile = false;
      tabstop = 2;
      termguicolors = true;
      undodir = "${config.xdg.cacheHome}/nvim/undodir";
      undofile = true;
      undolevels = 5000;
      visualbell = true;
      wrap = false;
      writebackup = false;

      foldenable = false;
      foldmethod = "indent";
      foldnestmax = 3;

      splitbelow = true;
      splitright = true;

      incsearch = true;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;
      inccommand = "split";
    };
  };
}
