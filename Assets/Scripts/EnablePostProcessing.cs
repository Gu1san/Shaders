using UnityEngine;

public class EnablePostProcessing : MonoBehaviour
{
    [SerializeField] CameraEffect cameraEffect;
    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.E)){
            cameraEffect.enabled = !cameraEffect.enabled;
        }
    }
}
