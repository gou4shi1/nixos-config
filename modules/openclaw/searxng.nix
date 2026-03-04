{ pkgs, ... }:

{
  services.searx = {
    enable = true;

    settings = {
      use_default_settings = true;

      server = {
        bind_address = "127.0.0.1";
        port = 8080;
        secret_key = "local-searxng-secret-key-for-openclaw";
      };

      search.formats = [ "html" "json" ];

      engines = [
        { name = "bing"; disabled = false; }
        { name = "bilibili"; disabled = false; }
        { name = "iqiyi"; disabled = false; }
      ];
    };
  };
}
