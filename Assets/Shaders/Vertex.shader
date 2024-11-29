Shader "Custom/Vertex"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Slider ("Slider", Range(0, 1)) = 0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows vertex:vert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 color;
        };

        fixed4 _Color;
        float _Slider;

        struct appdata{
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float2 texcoord: TEXCOORD0;
            float3 color: COLOR;
        };

        void vert(inout appdata v, out Input o)
        {
            v.vertex.xyz += v.normal * 0.1 * _Slider;
            o.uv_MainTex = v.texcoord;
            o.color = v.color;
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = IN.color;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
