Shader "Hidden/Efeito"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BlendTex ("Blend Texture", 2D) = "white"{}
        _Opacity ("Blend Opacity", Range(0,1)) = 1
        _R("R", Range(0, 1)) = 1
        _G("G", Range(0, 1)) = 1
        _B("B", Range(0, 1)) = 1
    }
    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc"
            uniform sampler2D _MainTex, _BlendTex;
            fixed _R, _G, _B, _Opacity;
            fixed4 frag (v2f_img i) : COLOR
            {
                fixed4 tex = tex2D(_MainTex, i.uv);
                fixed4 blendTex = tex2D(_BlendTex, i.uv);
                tex.rgb = fixed3(tex.r * _R, tex.g * _G, tex.b * _B);
                fixed4 blendMultiply = tex * blendTex;
                tex = lerp(tex, blendMultiply, _Opacity);
                return tex;
            }
            ENDCG
        }
    }
}
