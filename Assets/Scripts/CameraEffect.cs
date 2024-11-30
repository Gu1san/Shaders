using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[ExecuteInEditMode]
public class CameraEffect : MonoBehaviour
{
    public Shader curShader;
    [Range(0, 2.0f)]
    public float red = 1.0f;
    [Range(0, 2.0f)]
    public float green = 1.0f;
    [Range(0, 2.0f)]
    public float blue = 1.0f;
    [Range(0, 1.0f)]
    public float opacity = 1.0f;
    [Range(0.01f, 1.0f)]
    public float grainyStep = .2f;
    public Vector4 aimScale;
    Material mat;
    public Texture2D frameTex;
    public Texture2D aimTex;
    public Texture2D grainyTex;
    void OnEnable()
    {
        if(mat == null)
        {
            mat = new Material(Shader.Find("Hidden/Efeito"));
            
        }
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (curShader != null){
            mat.SetFloat("_R", red);
            mat.SetFloat("_G", green);
            mat.SetFloat("_B", blue);
            mat.SetFloat("_Opacity", opacity);
            mat.SetFloat("_GrainyStep", grainyStep);
            mat.SetVector("_AimScale", aimScale);
            mat.SetTexture("_FrameTex", frameTex);
            mat.SetTexture("_AimTex", aimTex);
            mat.SetTexture("_GrainyTex", grainyTex);
            Graphics.Blit(source, destination, mat);
        } else {
            Graphics.Blit(source, destination);
        }
    }

    void OnDisable()
    {
        if (mat != null) DestroyImmediate(mat);
    }
}
