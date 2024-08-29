Shader "Custom/A"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        sampler2D _MainTex;
        struct Input
        {
            float2 uv_MainTex;
        };
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float x = IN.uv_MainTex.x;
            //Fazendo 1 - o eixo X, o início que seria preto fica branco (1 - 0 = 1), e o final que seria branco fica preto (1 - 1 = 0)
            o.Albedo = 1 - x;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

