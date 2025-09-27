{
  inputs,
  pkgs,
  ...
}: {
  pre-commit-check = inputs.pre-commit-hooks.lib.${pkgs.system}.run {
    default_stages = ["pre-commit"];
    src = ./.;
    hooks = {
      alejandra.enable = true;
      deadnix.enable = true;
      statix.enable = true;

      # Git + GitHub actions
      check-case-conflicts.enable = true;
      check-merge-conflicts.enable = true;
      detect-private-keys.enable = true;
      end-of-file-fixer.enable = true;
      fix-byte-order-marker.enable = true;
      mixed-line-endings.enable = true;
      trim-trailing-whitespace.enable = true;
      zizmor.enable = true;
    };
  };
}
