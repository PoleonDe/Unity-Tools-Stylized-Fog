using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Control.Tools.PostProcessing.StylizedFog
{
    [Serializable]
    [VolumeComponentMenu("Post-processing/Control Tools/Stylized Fog")]
    [SupportedOnRenderPipeline(typeof(UniversalRenderPipelineAsset))]
    public sealed class StylizedFog : VolumeComponent, IPostProcessComponent
    {
        [Tooltip("Gradient lookup texture. The horizontal axis is sampled from min distance to max distance; alpha controls blend strength.")]
        public NoInterpTextureParameter gradientTexture = new NoInterpTextureParameter(null);

        [Tooltip("Eye-space distance where the fog starts.")]
        public MinFloatParameter minDistance = new MinFloatParameter(10f, 0f);

        [Tooltip("Eye-space distance where the fog reaches the right edge of the gradient.")]
        public MinFloatParameter maxDistance = new MinFloatParameter(80f, 0.001f);

        [Tooltip("Overall blend strength for the gradient fog.")]
        public ClampedFloatParameter intensity = new ClampedFloatParameter(1f, 0f, 1f);

        public bool IsActive()
        {
            return active
                && gradientTexture.value != null
                && intensity.value > 0f
                && maxDistance.value > minDistance.value;
        }

        [Obsolete("Unused. #from(2023.1)")]
        public bool IsTileCompatible() => false;
    }
}
