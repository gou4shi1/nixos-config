final: prev:

{
  openssh = prev.openssh.override {
    withKerberos = true;
  };
}
