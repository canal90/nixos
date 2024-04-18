{ lib, stdenv, fetchurl, xorg, alsa-lib, zlib }:
let
  name = "stereo_tool_gui_jack_64";
in
stdenv.mkDerivation {
  pname = name;
  version = "v10.30";

  src = fetchurl {
    curlOpts = "-L";
    url = "https://www.stereotool.com/download/${name}";
  #dontConfigure = true;
    sha256 = "r7fkSd4p6HlgpRH0qsJBXNZOQPYMeeLvP5GAtKR9pRU=";
    executable = true;
  };

  dontStrip = true;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/applications
    install -m755 $src $out/bin/${name}

    cat > $out/share/applications/${name}.desktop <<EOF
    [Desktop Entry]
    Name=Stereo Tool 10.30
    Exec=$out/bin/${name}
    Type=Application
    Categories=AudioVideo;Audio;Mixer;
    Keywords=stereotool
    EOF

    runHook postInstall
  '';

  preFixup = let
    libPath = lib.makeLibraryPath [
      xorg.libX11
      xorg.libXpm
      alsa-lib
      zlib
    ];
    in ''
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "${libPath}" $out/bin/${name}
    '';
}
