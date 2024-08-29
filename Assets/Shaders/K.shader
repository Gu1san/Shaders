Shader "Custom/K"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _A("Escala em X", Range(0, 20)) = 15.8
        _B("Deslocamento em X", Range(0, 3)) = 2.8
        _C("Escala em Y", Range(0, 2)) = 1
        _D("Deslocamento em Y", Range(0, 1)) = 0.6
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
        float _A;
        float _B;
        float _C;
        float _D;
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float x = IN.uv_MainTex.x;

            //função que gera ondas
            float y = sin(_A * x + _B) * _C + _D;

            //arredondando os valores de y e saturando a cor
            float a = saturate(round(y));

            //invertendo preto e branco
            float c = 1 - a;

            //Multiplicando o A com azul, onde era branco vira azul, gerando a listra azul e preta.
            //Após somar com C, que é a listra invertida, o branco é adicionado no preto e o azul não é modificado
            o.Albedo = a * float3(0, 0, 1) + c;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

