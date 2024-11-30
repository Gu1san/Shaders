Shader "Hidden/Efeito"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _FrameTex ("Blend Texture", 2D) = "white"{}
        _AimTex ("Blend Texture", 2D) = "white"{}
        _GrainyTex ("Blend Texture", 2D) = "white"{}
        _Opacity ("Blend Opacity", Range(0,1)) = 1
        _GrainyStep ("Grainy Step", Range(0,1)) = 0.2
        _AimScale("Aim Scale", Vector) = (1, 1, 0, 0)
        _R("R", Range(0, 1)) = 1
        _G("G", Range(0, 1)) = 1
        _B("B", Range(0, 1)) = 1
    }
    SubShader
    {
        Cull Off ZWrite Off ZTest Always ColorMask G
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc"
            uniform sampler2D _MainTex, _FrameTex, _AimTex, _GrainyTex;
            fixed _R, _G, _B, _Opacity, _GrainyStep;
            fixed4 _AimScale; 
            fixed4 frag (v2f_img i) : COLOR
            {
                fixed4 tex = tex2D(_MainTex, i.uv);

                //Escala de cinza
                tex.rgb = dot(tex.rgb, float3(_R, _G, _B));

                //Granulado
                fixed grainy = tex2D(_GrainyTex, i.uv + float2(_Time.x, -_Time.x));
                fixed grainy2 = tex2D(_GrainyTex, i.uv + float2(-_Time.x, _Time.x));
                float b = step(grainy * grainy2, _GrainyStep);
                tex = lerp(tex, tex * b, _Opacity);

                //Moldura
                fixed4 frameTex = tex2D(_FrameTex, i.uv);
                tex = lerp(tex, tex * frameTex, _Opacity);

                //Mira
                fixed4 aimTex = tex2D(_AimTex, i.uv);
                tex = lerp(tex, tex * aimTex, _Opacity);

                return tex;
            }
            ENDCG
        }
    }
}
