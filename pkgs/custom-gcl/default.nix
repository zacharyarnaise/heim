{
  buildGo127Module,
  src,
}:
buildGo127Module {
  pname = "custom-gcl";
  version = src.shortRev or "unstable";
  inherit src;

  modRoot = "cmd/custom-gcl";
  # gorules tests load a testdata module that requires private dependencies
  subPackages = ["."];
  vendorHash = "sha256-JAMc5ghNqKB20EA/h5eN+E7X8Ed8wjVK4yQlPOS8SaM=";

  meta.mainProgram = "custom-gcl";
}
