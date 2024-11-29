Shader "Custom/E"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _OuterRadius("Raio de fora", Range(-5, 5)) = 0
        _Smoothness("Smoothness", Range(-5, 5)) = 0
        _InnerRadius("Raio do centro", Range(-1, 1)) = 0
    }
        SubShader
        {
            CGPROGRAM
            #pragma surface surf Standard fullforwardshadows
            sampler2D _MainTex;
            float _OuterRadius;
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
                float centerDist = length(center);

                // Pintando de preto tudo que estiver dentro da circunferência
                float circle = step(centerDist, _InnerRadius);

                // Gradiente radial baseado na distância do centro ao raio externo
                float gradient = smoothstep(_InnerRadius - _Smoothness * 0.1, _OuterRadius, centerDist);

                float x = pow(center - _InnerRadius, 2);
                float y = pow(center - _InnerRadius, 2);
                float z = x + y;
                float c = saturate(1 - mul(2 * z, 2));
                o.Albedo = c;
                //o.Albedo = (1 - gradient);
            }
            ENDCG
        }
            FallBack "Diffuse"
}