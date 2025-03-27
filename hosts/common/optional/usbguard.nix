{
  services.usbguard = {
    enable = true;

    IPCAllowedGroups = ["wheel"];
    implicitPolicyTarget = "block";
    insertedDevicePolicy = "apply-policy";
    presentControllerPolicy = "keep";
    presentDevicePolicy = "keep";
  };
}
