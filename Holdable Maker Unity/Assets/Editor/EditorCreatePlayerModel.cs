using UnityEditor;
using UnityEngine;
using System.IO;
using UnityEngine.UI;
using UnityEngine.Tilemaps;

public class CreatePlayerModel
{

    static private string prefabPath;

    static public string filePath;

    [MenuItem("Assets/Create Holdable")]
    static public void BuildAssetBundle()
    {

        GameObject obj = Selection.activeGameObject;

        
        string PlayerModelName = obj.GetComponent<HoldableDescriptor>().HoldableName;
        string Author = obj.GetComponent<HoldableDescriptor>().Author;
        string Description = obj.GetComponent<HoldableDescriptor>().Description;

        Vector3 inhandscale = obj.GetComponent<HoldableDescriptor>().LocalScaleWhenInHand;
        Vector3 righthandpos = obj.GetComponent<HoldableDescriptor>().LocalPositionWhenInHandRight;
        Vector3 righthandeula = obj.GetComponent<HoldableDescriptor>().LocalEulerAnglesWhenInHandRight;
        Vector3 lefthandeula = obj.GetComponent<HoldableDescriptor>().LocalEulerAnglesWhenInHandLeft;
        Vector3 lefthandpos = obj.GetComponent<HoldableDescriptor>().LocalPositionWhenInHandLeft;
        Vector3 displaypos = obj.GetComponent<HoldableDescriptor>().LocalPositionWhenDisplayed;
        Vector3 displayeula = obj.GetComponent<HoldableDescriptor>().LocalEulerAnglesWhenDisplayed;
        Vector3 displayscale = obj.GetComponent<HoldableDescriptor>().LocalScaleWhenDisplayed;

        int bulletIndex = obj.GetComponent<HoldableDescriptor>().bulletIndex;
        bool bool1 = obj.GetComponent<HoldableDescriptor>().isFireArm;
        bool bool2 = obj.GetComponent<HoldableDescriptor>().bulletUsesGravity;
        bool bool3 = obj.GetComponent<HoldableDescriptor>().isFullAuto;
        float timebetweenshots = obj.GetComponent<HoldableDescriptor>().timeBetweenShots;
        float bulletspeed = obj.GetComponent<HoldableDescriptor>().bulletSpeed;
        string isFirearm = bool1.ToString();
        string isGravity = bool2.ToString();
        string isFullauto = bool3.ToString();
        string timebetweenshotsstring = timebetweenshots.ToString("F8");
        string bulletspeedspeed = bulletspeed.ToString("F8");
        int id = Random.Range(0, 1000000000);
        string idstring = id.ToString();
        if(obj.GetComponent<HoldableDescriptor>().bulletSpawnPoint != null){

        GameObject bsp = obj.GetComponent<HoldableDescriptor>().bulletSpawnPoint;
        bsp.AddComponent<Tilemap>().enabled = false;

        }

        foreach(BoxCollider collider in obj.GetComponentsInChildren<BoxCollider>())
        {
            collider.enabled = false;
        }
        foreach (SphereCollider collider in obj.GetComponentsInChildren<SphereCollider>())
        {
            collider.enabled = false;
        }
        foreach (CapsuleCollider collider in obj.GetComponentsInChildren<CapsuleCollider>())
        {
            collider.enabled = false;
        }
        foreach (Collider collider in obj.GetComponentsInChildren<Collider>())
        {
            collider.enabled = false;
        }
        if (!AssetDatabase.IsValidFolder("Assets/HOLDABLE OUTPUT"))
        {
            AssetDatabase.CreateFolder("Assets", "HOLDABLE OUTPUT");
        }

        if (PlayerModelName == null)
        {
            Debug.Log("Assigning PlayerModel Name to" + obj.name);
            PlayerModelName = obj.name;
        }

        prefabPath = "Assets/HOLDABLE OUTPUT/" + PlayerModelName + ".prefab";
        filePath = "Assets/HOLDABLE OUTPUT";

        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();



        var prefabAsset = PrefabUtility.SaveAsPrefabAsset(obj.gameObject, prefabPath);

        GameObject contentsRoot = PrefabUtility.LoadPrefabContents(prefabPath);


        contentsRoot.name = "playermodel.ParentObject";

        string newprefabPath = "Assets/HOLDABLE OUTPUT/" + contentsRoot.name + ".prefab";
  

        var desc = contentsRoot.GetComponent<HoldableDescriptor>();

        /*
        if(desc.left_finger != null && desc.right_finger != null)
        {
            desc.left_finger.name = "playermodel.leftfinger";
            desc.right_finger.name = "playermodel.rightfinger";

        }
        */


        
        Debug.Log(desc);

        Text player_info = contentsRoot.AddComponent<Text>();
        string split = "$";
        player_info.text = PlayerModelName + split + Author + split + Description + split + isFirearm+ split+bulletIndex+split+inhandscale.ToString("F8")+split+righthandpos.ToString("F8") + split+righthandeula.ToString("F8") + split+lefthandpos.ToString("F8") + split+lefthandeula.ToString("F8") + split+displayscale.ToString("F8") + split+displaypos.ToString("F8") + split+displayeula.ToString("F8") +split+isGravity+split+timebetweenshotsstring+split+bulletspeedspeed+split+isFullauto+split+idstring;
        Object.DestroyImmediate(contentsRoot.GetComponent<HoldableDescriptor>());

        PrefabUtility.SaveAsPrefabAsset(contentsRoot, newprefabPath);
        PrefabUtility.UnloadPrefabContents(contentsRoot);

        if (File.Exists(prefabPath))
        {
            File.Delete(prefabPath);
        }

        AssetImporter.GetAtPath(newprefabPath).SetAssetBundleNameAndVariant("playermodel.assetbundle", "");



        string assetBundleDirectory = "Assets/HOLDABLE OUTPUT";

        if (!Directory.Exists("Assets/HOLDABLE OUTPUT"))
        {
            Directory.CreateDirectory(assetBundleDirectory);
        }
        string asset_new = filePath + "/" + PlayerModelName;

        string asset_temp = filePath + "/playermodel.assetbundle";

        if (File.Exists(asset_new + ".holdable"))
        {

            File.Delete(asset_new + ".holdable");
        }


        BuildPipeline.BuildAssetBundles(assetBundleDirectory, BuildAssetBundleOptions.None, EditorUserBuildSettings.activeBuildTarget);

        if (File.Exists(newprefabPath))
        {
            File.Delete(newprefabPath);
        }

        string asset_manifest = assetBundleDirectory + "/playermodel.assetbundle.manifest";
        Debug.Log(asset_manifest);
        if (File.Exists(asset_manifest))
        {
            File.Delete(asset_manifest);
        }

        string folder_manifest = assetBundleDirectory + "/HOLDABLE OUTPUT";
        //Debug.Log(folder_manifest);
        if (File.Exists(folder_manifest))
        {
            File.Delete(folder_manifest);

            File.Delete(folder_manifest + ".manifest");
        }



        string metafile = asset_temp + ".meta";
        if (File.Exists(asset_temp))
        {

            Debug.Log("Created " + PlayerModelName);
            File.Move(asset_temp, asset_new + ".holdable");
            Debug.Log(metafile);
        }



        AssetDatabase.Refresh();
        Debug.ClearDeveloperConsole();
        Debug.Log("Created " + PlayerModelName);



    }
}