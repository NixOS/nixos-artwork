{ pkgs }:

rec {

  mkBackgroundProperties = { backgroundName, backgroundFile }:
    pkgs.substituteAll {
      name = "${backgroundName}.xml";

      src = ./share/gnome-background-properties/template.xml.in;

      inherit backgroundName backgroundFile;
    };
    
  mkBackgroundOverride = { name, background }:
    pkgs.writeTextFile {
      inherit name;
      destination = "/share/gsettings-schemas/${name}/org.gnome.desktop.background.nixos.gschema.override";
      text = ''
        [org.gnome.desktop.background]
        picture-uri='file://${background}'
      '';
    };

  mkBackground = { backgroundName, backgroundFile }: rec {
    properties = mkBackgroundProperties {
      inherit backgroundName backgroundFile;
    };

    gsettings = mkBackgroundOverride {
      name = "nixos-${backgroundName}-background";
      background = properties;
    };
  };

  gnomeDark = mkBackground {
    backgroundName = "Gnome_Dark";
    backgroundFile = ./share/backgrounds/gnome/Gnome_Dark.jpg;
  };

}
