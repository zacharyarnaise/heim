{lib, ...}: {
  custom = {
    # check whether an element is in a list
    has = elem: list: lib.any (x: x == elem) list;

    # use path relative to the root of the project
    relativeToRoot = lib.path.append ../.;
  };
}
