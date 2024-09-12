Shader "Custom/Xadrez"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Color1("Color 1", Color) = (1, 0, 0, 1)
        _Color2("Color 2", Color) = (0, 0, 1, 1)
        _Size("Tamanho do Xadrez", Range(1, 20)) = 10
        _Speed("Velocidade", Range(0.1, 10)) = 4
    }
        SubShader
        {
            CGPROGRAM
            #pragma surface surf Standard fullforwardshadows
            sampler2D _MainTex;
            float _Size, _Speed;
            fixed4 _Color1, _Color2;
            struct Input
            {
                float2 uv_MainTex;
            };

            void surf(Input IN, inout SurfaceOutputStandard o)
            {
                // Pega o tempo global (Time.time)
                float time = _Time.y * _Speed;

                //Define quantas células vão ter ao multiplicar a própria UV
                float2 uv = IN.uv_MainTex * _Size;

                // Calcula se a célula atual é preta ou branca
                float checker = fmod(floor(uv.x) + floor(uv.y), 2);

                // Alterna os estados usando sin(time)
                float colorShift = smoothstep(0, 1, sin(time));

                // Alterna as cores das células ao pegar o valor absoluto delas
                o.Albedo = lerp(_Color1.rgb, _Color2.rgb, abs(checker - colorShift));
            }
            ENDCG
        }
            FallBack "Diffuse"
}
