# Tiled Number Shader

Shader (+cginc) to handle tiled number textures

## Install

### OpenUPM

see [OpenUPM page](https://openupm.com/packages/net.narazaka.unity.tiled-number-shader/)

### VRChat Creaters Companion (VCC)

1. Press "Add to VCC" on https://vpm.narazaka.net/ to add Narazaka's repository to VCC.
2. Make sure that "Narazaka VPM Listing" is enabled in VCC -> Settings -> Packages -> Installed Repositories.
3. Install "Tiled Number Shader" from your project's "Manage Project".

## cginc Usage

```
#include "../net.narazaka.unity.tiled-number-shader/TiledNumber.cginc"

/// uv: UV
/// targetSize: display target region size
/// targetOffset: display target region offset
/// tileRegionSizeInTex: tile region size in tex
/// tileRegionOffsetInTex: tile region offset in tex
/// n: tile number
/// col: tile column
/// row: tile row
/// isUp: true if order is uv native
///  true:
///   3 4 5
///   0 1 2
///  false:
///   0 1 2
///   3 4 5
float2 TiledNumber_placeTileUV(float2 uv, float2 targetSize, float2 targetOffset, float2 tileRegionSizeInTex, float2 tileRegionOffsetInTex, uint n, uint col, uint row, bool isUp);

/// uv: UV
/// targetSize: display target region size
/// targetOffset: display target region offset
/// tileRegionSizeInTex: tile region size in tex
/// tileRegionOffsetInTex: tile region offset in tex
/// n: tile number
/// col: tile column
/// row: tile row
/// isUp: true if order is uv native
///  true:
///   3 4 5
///   0 1 2
///  false:
///   0 1 2
///   3 4 5
/// digitCount: number of digits (00 -> 2, 0000 -> 4)
/// zeroFill: zero fill (true -> "0123", false -> " 123"). The last tile in the texture must be blank for this feature.
float2 TiledNumber_placeTileUV(float2 uv, float2 targetSize, float2 targetOffset, float2 tileRegionSizeInTex, float2 tileRegionOffsetInTex, uint n, uint col, uint row, bool isUp, uint digitCount, bool zeroFill);
```

## License

[Zlib License](LICENSE.txt)
