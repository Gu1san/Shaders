Shader "Custom/J"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Color1("Color 1", Color) = (1, 0, 0, 1)
        _Color2("Color 2", Color) = (0, 0, 1, 1)
        _Radius("Raio", Range(0, 0.5)) = 0.25
    }
        SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        sampler2D _MainTex;
        fixed4 _Color1;
        fixed4 _Color2;
        float _Radius;
        struct Input
        {
            float2 uv_MainTex;
        };
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Calcula o centro da textura
            float2 center = IN.uv_MainTex - 0.5;

            // Calcula a distância do centro
            float distance = length(center);

            // Pintando de preto tudo que estiver dentro da circunferência
            float circle = step(distance, _Radius);

            //Invertendo as cores
            float c = 1 - circle;

            // Aplica o azul no círculo
            o.Albedo = circle * float3(0, 0, 1) + c;
        }
        ENDCG
    }
        FallBack "Diffuse"
}

