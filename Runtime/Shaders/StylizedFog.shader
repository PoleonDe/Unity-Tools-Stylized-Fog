Shader "Hidden/Control/PostProcessing/StylizedFog"
{
    SubShader
    {
        Tags { "RenderPipeline" = "UniversalPipeline" }
        LOD 100
        ZTest Always
        ZWrite Off
        Cull Off

        Pass
        {
            Name "Stylized Fog"

            HLSLPROGRAM
            #pragma target 3.5
            #pragma vertex Vert
            #pragma fragment Frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
            #include "Packages/com.unity.render-pipelines.core/Runtime/Utilities/Blit.hlsl"

            TEXTURE2D(_GradientTex);
            SAMPLER(sampler_GradientTex);

            float _MinDistance;
            float _MaxDistance;
            float _Intensity;

            half4 Frag(Varyings input) : SV_Target
            {
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

                float2 uv = input.texcoord.xy;
                half4 baseColor = SAMPLE_TEXTURE2D_X(_BlitTexture, sampler_LinearClamp, uv);

                float rawDepth = SampleSceneDepth(uv);
                float linearEyeDepth = LinearEyeDepth(rawDepth, _ZBufferParams);
                float depthRange = max(_MaxDistance - _MinDistance, 1e-5);
                float depth01 = saturate((linearEyeDepth - _MinDistance) / depthRange);

                float2 gradientUV = float2(depth01, 0.5);
                half4 gradientColor = SAMPLE_TEXTURE2D(_GradientTex, sampler_GradientTex, gradientUV);

                float mask = linearEyeDepth > _MinDistance ? 1.0 : 0.0;
                half blend = saturate(gradientColor.a * mask * _Intensity);

                half4 result = lerp(baseColor, gradientColor, blend);
                result.a = 1.0;
                return result;
            }
            ENDHLSL
        }
    }

    Fallback Off
}
