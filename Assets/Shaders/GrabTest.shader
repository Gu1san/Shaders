Shader "Unlit/GrabTest"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        GrabPass{"_GrabPass"}
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc"
            sampler2D _MainTex, _GrabPass;
            fixed4 frag (v2f_img i) : SV_Target
            {
                fixed4 col = tex2D(_GrabPass, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
