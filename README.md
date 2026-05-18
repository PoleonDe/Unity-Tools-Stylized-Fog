# Control Tools - Post Processing Stylized Fog

Distance-based gradient fog for Unity 6.3 URP fullscreen Volume rendering.

## Use

1. Add `StylizedFogRendererFeature` to the active URP renderer asset.
2. Add `Control Tools/Stylized Fog` to a Volume profile.
3. Assign a gradient texture in the Volume override.
4. Enable Post Processing on the camera.

The gradient texture is sampled horizontally from `minDistance` to `maxDistance`. Its alpha controls blend strength.

## Notes

The renderer feature records a RenderGraph pass. A Compatibility Mode pass is also included behind Unity's `URP_COMPATIBILITY_MODE` scripting define for projects that intentionally keep RenderGraph disabled.
