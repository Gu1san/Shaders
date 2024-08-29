Shader "Custom/G"
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

            //arredondando os valores de X e saturando a cor
            float a = saturate(round(x));

            //Invertendo as cores
            float c = 1 - a;

            //Multiplicando o A com azul, onde era branco vira azul, gerando a listra azul e preta.
            //Após somar com C, que é a listra invertida, o branco é adicionado no preto e o azul não é modificado
            o.Albedo = a * float3(0, 0, x) + c;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

