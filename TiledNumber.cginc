// place tex to big tex's target position
float2 TiledNumber_placeUV(float2 uv, float2 targetSize, float2 targetOffset)
{
    return (uv - targetOffset) / targetSize;
}

            // zoom to tex's patrial region
float2 TiledNumber_focusUV(float2 uv, float2 regionSize, float2 regionOffset)
{
    return uv * regionSize + regionOffset;
}

float2 TiledNumber_downTileUVOffset(uint n, uint col, uint row)
{
    return uint2(n % col, row - 1 - n / col) / float2(col, row);
}

float2 TiledNumber_upTileUVOffset(uint n, uint col, uint row)
{
    return uint2(n % col, n / col) / float2(col, row);
}

// isUp is true if order is uv native
// true:
//  3 4 5
//  0 1 2
// false:
//  0 1 2
//  3 4 5
float2 TiledNumber_tileUVOffset(uint n, uint col, uint row, bool isUp)
{
    return lerp(TiledNumber_downTileUVOffset(n, col, row), TiledNumber_upTileUVOffset(n, col, row), isUp);
}

float2 TiledNumber_tileUV(float2 uv, uint n, uint col, uint row, bool isUp)
{
    return uv / float2(col, row) + TiledNumber_tileUVOffset(n, col, row, isUp);
}

/// <summary>
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
/// </summary>
float2 TiledNumber_placeTileUV(float2 uv, float2 targetSize, float2 targetOffset, float2 tileRegionSizeInTex, float2 tileRegionOffsetInTex, uint n, uint col, uint row, bool isUp)
{
    return TiledNumber_focusUV(TiledNumber_tileUV(TiledNumber_placeUV(uv, targetSize, targetOffset), n, col, row, isUp), tileRegionSizeInTex, tileRegionOffsetInTex);
}

/// <summary>
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
/// </summary>
float2 TiledNumber_placeTileUV(float2 uv, float2 targetSize, float2 targetOffset, float2 tileRegionSizeInTex, float2 tileRegionOffsetInTex, uint n, uint col, uint row, bool isUp, uint digitCount, bool zeroFill)
{
    float2 placedUv = TiledNumber_placeUV(uv, targetSize, targetOffset);
    uint digit = (uint)(placedUv.x * digitCount);
    uint unit = (uint)round(pow(10, digitCount - digit - 1));
    uint number = lerp(n / unit % 10, col * row - 1, !zeroFill && n < unit);
    return TiledNumber_placeTileUV(
        placedUv,
        float2(1 / (float)digitCount, 1),
        float2(digit / (float)digitCount, 0),
        tileRegionSizeInTex,
        tileRegionOffsetInTex,
        number,
        col,
        row,
        isUp
    );
}
