{ lib, stdenv, fetchurl, xorg, alsa-lib, zlib }:

stdenv.mkDerivation {
  pname = "stereo_tool_gui_jack_64";
  version = "v10.30";

  src = fetchurl {
    curlOpts = "-L";
    url = "https://www.stereotool.com/download/stereo_tool_gui_jack_64";
    #sha256 = "b32d69b3892732548a55aa5241327afbc43bc7bd3f0a94548fb524596524ada2";
    sha256 = "r7fkSd4p6HlgpRH0qsJBXNZOQPYMeeLvP5GAtKR9pRU=";
    executable = true;
  };
  #sourceRoot = ".";

  dontConfigure = true;
  dontBuild = true;
  unpackPhase = ":";
  #phases = [ "installPhase" "fixupPhase ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/applications
    cp $src $out/bin

    cat > $out/share/applications/stereo_tool_gui_jack_64.desktop <<EOF
    [Desktop Entry]
    Name=Stereo Tool 10.30
    Exec=$out/bin/stereo_tool_gui_jack_64
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
        --set-rpath "${libPath}" $out/bin/stereo_tool_gui_jack_64
    '';
}
