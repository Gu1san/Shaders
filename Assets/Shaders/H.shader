Shader "Custom/H"
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
            float y = IN.uv_MainTex.y;

            //arredondando os valores de X e saturando a cor
            float a = saturate(round(x));

            //Invertendo as cores
            float c = 1 - a;

            //Multiplicando o A com azul, onde era branco vira azul, gerando a listra azul e preta.
            //Após somar com C, que é a listra invertida, o branco é adicionado no preto e o azul não é modificado
            //Caso o Y seja maior que a metade, as cores são invertidas
            if (y > 0.5) {
                o.Albedo = c * float3(0, 0, 1) + a;
            }
            else {
                o.Albedo = a * float3(0, 0, 1) + c;
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}

