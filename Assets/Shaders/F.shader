Shader "Custom/F"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Radius("Raio do centro", Range(0.05, 1)) = 0.1
        _Smoothness("Smoothness", Range(0.1, 10)) = 3.0
        _InnerRadius("Raio do centro", Range(0.1, 2.0)) = 0.5
    }
        SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        sampler2D _MainTex;
        float _Radius;
        float _Smoothness;
        float _InnerRadius;
        struct Input
        {
            float2 uv_MainTex;
        };
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Calcula o centro da textura
            float2 center = IN.uv_MainTex - 0.5;

            // Calcula a distância do centro
            float distance = (length(center) + _Radius);

            distance = pow(distance, _Smoothness);

            o.Albedo = lerp(1, 0, distance);
        }
        ENDCG
    }
        FallBack "Diffuse"
}

