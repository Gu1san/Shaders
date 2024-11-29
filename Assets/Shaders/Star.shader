Shader "Custom/Star"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RockTex ("Rock (RGB)", 2D) = "white" {}
        _WaterTex ("Water (RGB)", 2D) = "white" {}
        _Slider ("Slider", Range(0, 5)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:blend

        sampler2D _MainTex, _RockTex, _WaterTex;

        struct Input
        {
            float2 uv_MainTex;
        };
        fixed4 _Color;
        float _Slider;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 e = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 p = tex2D (_RockTex, IN.uv_MainTex);
            fixed4 a = tex2D (_WaterTex, IN.uv_MainTex + float2(_Time.y, 0));
            fixed3 star = (1 - e.rgb) * p;
            fixed3 water = e.rgb * a;
            o.Albedo = star + water;
            o.Alpha = saturate((1-e) + 0.5);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
