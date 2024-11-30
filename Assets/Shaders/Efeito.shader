Shader "Hidden/Efeito"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
<<<<<<< Updated upstream
        _BlendTex ("Blend Texture", 2D) = "white"{}
=======
        _Color ("Color", Color) = (1,0,0,1)
        _FrameTex ("Blend Texture", 2D) = "white"{}
        _AimTex ("Blend Texture", 2D) = "white"{}
        _GrainyTex ("Blend Texture", 2D) = "white"{}
>>>>>>> Stashed changes
        _Opacity ("Blend Opacity", Range(0,1)) = 1
        _R("R", Range(0, 1)) = 1
        _G("G", Range(0, 1)) = 1
        _B("B", Range(0, 1)) = 1
        [IntRange]_StencilRef ("StencilRef", Range(0,255))=0
    }
    SubShader
    {
        Cull Off ZWrite On ZTest Always ColorMask RGB
        Stencil
        {
            Ref [_StencilRef]
            Comp Greater
            Pass Invert
        }
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
<<<<<<< Updated upstream
                fixed4 blendTex = tex2D(_BlendTex, i.uv);
                tex.rgb = fixed3(tex.r * _R, tex.g * _G, tex.b * _B);
                fixed4 blendMultiply = tex * blendTex;
=======

                //Moldura
                fixed4 frameTex = tex2D(_FrameTex, i.uv);

                //Granulado
                fixed grainy = tex2D(_GrainyTex, i.uv + float2(_Time.x, _Time.x));
                float b = step(grainy, 0.5);
                fixed4 c = lerp(tex, tex * b + (1 - b), _Opacity);

                //tex.rgb = dot(tex.rgb, float3(_R, _G, _B));
                fixed4 blendMultiply = tex * frameTex;
>>>>>>> Stashed changes
                tex = lerp(tex, blendMultiply, _Opacity);
                return tex;
            }
            ENDCG
        }
    }
}
