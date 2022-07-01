using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System;
using System.IO;

public class HoldableDescriptor : MonoBehaviour
{
    [Header("Your Data")]
    public string HoldableName;
    public string Author;
    public string Description;
    [Header("Position, Rotation RIGHT HAND")]
    public Vector3 LocalPositionWhenInHandRight;
    public Vector3 LocalEulerAnglesWhenInHandRight;
    [Header("Position, Rotation LEFT HAND")]
    public Vector3 LocalPositionWhenInHandLeft;
    public Vector3 LocalEulerAnglesWhenInHandLeft;
    [Header("Scale when in hand BOTH")]
    public Vector3 LocalScaleWhenInHand;
    [Header("Position, Rotation & Scale DISPLAY")]
    public Vector3 LocalPositionWhenDisplayed;
    public Vector3 LocalEulerAnglesWhenDisplayed;
    public Vector3 LocalScaleWhenDisplayed;
    [Header("Properties")]
    public bool isFireArm;
    public bool isFullAuto;
    public bool bulletUsesGravity;
    public float timeBetweenShots;
    public float bulletSpeed;
    public int bulletIndex;
    public GameObject bulletSpawnPoint;



    
    // Start is called before the first frame update
    void Start()
    {


    }

    
    


    
}
