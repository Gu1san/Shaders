Shader "Custom/Cartoon"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Slider ("Slider", Range(0, 10)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Luz

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        float _Slider;

        void surf (Input IN, inout SurfaceOutput o)
        {
            float4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = _Color * c;
        }
        float4 LightingLuz(SurfaceOutput s, float3 lightDir, float atten){
            float d = round(dot(lightDir, s.Normal)*_Slider)/_Slider;
            float3 ramp = tex2D(_MainTex, float2(d, 0.5));
            float3 base = s.Albedo * d;
            return float4(base, s.Alpha);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
  