Shader "Custom/I"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Size("Tamanho do quadrado", Range(0, 1)) = 0.5
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        sampler2D _MainTex;
        float _Size;
        struct Input
        {
            float2 uv_MainTex;
        };
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float x = IN.uv_MainTex.x;
            float y = IN.uv_MainTex.y;

            // Calcula o centro da textura
            float2 center = abs(IN.uv_MainTex - 0.5);

            //Calcula a área do quadrado separadamente em X e Y e multiplica os resultados
            float square = step(center.x, _Size * 0.5) * step(center.y, _Size * 0.5);

            float s = 1 - square;

            o.Albedo = square * float3(0, 0, 1) + s;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

