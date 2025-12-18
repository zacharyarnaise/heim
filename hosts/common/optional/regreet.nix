# Graphical greeter, hooks into greetd
{
  programs.regreet = {
    enable = true;
    cageArgs = ["-s" "-m" "last"];
  };

  environment.persistence = {
    # Persist last user and last selected session
    "/persist".directories = [
      {
        directory = "/var/lib/regreet";
        user = "greeter";
        group = "greeter";
      }
    ];
  };
}
