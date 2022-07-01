using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class EditorSetPos
{
    [MenuItem("GameObject/Set Values")]
    static public void SetLocalValues()
    {
        GameObject obj = Selection.activeGameObject;
        HoldableDescriptor descriptor = obj.GetComponent<HoldableDescriptor>();
        if(descriptor.transform.parent.name == "RIGHT HAND")
        {
            descriptor.LocalPositionWhenInHandRight = obj.transform.localPosition;
            descriptor.LocalEulerAnglesWhenInHandRight = obj.transform.localEulerAngles;
            descriptor.LocalScaleWhenInHand = obj.transform.localScale;
        }
        else if(descriptor.transform.parent.name == "LEFT HAND")
        {
            descriptor.LocalPositionWhenInHandLeft = obj.transform.localPosition;
            descriptor.LocalEulerAnglesWhenInHandLeft = obj.transform.localEulerAngles;
            descriptor.LocalScaleWhenInHand = obj.transform.localScale;
        }
        else if (descriptor.transform.parent.name == "DISPLAY ANCHOR")
        {
            descriptor.LocalPositionWhenDisplayed = obj.transform.localPosition;
            descriptor.LocalEulerAnglesWhenDisplayed = obj.transform.localEulerAngles;
            descriptor.LocalScaleWhenDisplayed = obj.transform.localScale;
        }
    }

}