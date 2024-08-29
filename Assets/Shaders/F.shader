Shader "Custom/F"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Radius("Raio do centro", Range(0.05, 1)) = 0.1
    }
        SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        sampler2D _MainTex;
        float _Radius;
        struct Input
        {
            float2 uv_MainTex;
        };
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Calcula o centro da textura
            float2 centeredUV = IN.uv_MainTex - 0.5;

            // Calcula a distância do centro
            float distance = length(centeredUV);

            float a = distance > _Radius ? distance : 1;

            o.Albedo = a;
        }
        ENDCG
    }
        FallBack "Diffuse"
}

