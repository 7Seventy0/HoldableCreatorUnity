// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:5262,x:32719,y:32712,varname:node_5262,prsc:2|emission-5058-OUT,clip-60-OUT;n:type:ShaderForge.SFN_Color,id:4739,x:31638,y:32598,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_4739,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:5306,x:31833,y:32702,varname:node_5306,prsc:2|A-4739-RGB,B-1638-RGB;n:type:ShaderForge.SFN_Tex2d,id:1638,x:31645,y:32781,ptovrint:False,ptlb:texture,ptin:_texture,varname:node_1638,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Fresnel,id:2612,x:31859,y:33157,varname:node_2612,prsc:2|EXP-7000-OUT;n:type:ShaderForge.SFN_Slider,id:7000,x:31485,y:33181,ptovrint:False,ptlb:fresnel strength,ptin:_fresnelstrength,varname:node_7000,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:3.130435,max:10;n:type:ShaderForge.SFN_Color,id:7371,x:31755,y:32974,ptovrint:False,ptlb:fresnelcolor,ptin:_fresnelcolor,varname:_Color_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.6745283,c2:1,c3:0.9772592,c4:1;n:type:ShaderForge.SFN_SwitchProperty,id:9681,x:32415,y:32790,ptovrint:False,ptlb:fresnel,ptin:_fresnel,varname:node_9681,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-5306-OUT,B-9960-OUT;n:type:ShaderForge.SFN_Clamp01,id:5058,x:32519,y:32644,varname:node_5058,prsc:2|IN-9681-OUT;n:type:ShaderForge.SFN_Lerp,id:9960,x:32227,y:32910,varname:node_9960,prsc:2|A-5306-OUT,B-7371-RGB,T-957-OUT;n:type:ShaderForge.SFN_RgbToHsv,id:2096,x:32110,y:33099,varname:node_2096,prsc:2|IN-7371-RGB;n:type:ShaderForge.SFN_Multiply,id:957,x:32323,y:33122,varname:node_957,prsc:2|A-2612-OUT,B-2096-VOUT;n:type:ShaderForge.SFN_Depth,id:7257,x:32090,y:33329,varname:node_7257,prsc:2;n:type:ShaderForge.SFN_Add,id:60,x:32331,y:33327,varname:node_60,prsc:2|A-7257-OUT,B-8068-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8068,x:32090,y:33475,ptovrint:False,ptlb:Opacity Clip,ptin:_OpacityClip,varname:node_8068,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;proporder:1638-4739-7000-7371-9681-8068;pass:END;sub:END;*/

Shader "Custom/playermodel" {
    Properties {
        _texture ("texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _fresnelstrength ("fresnel strength", Range(0, 10)) = 3.130435
        _fresnelcolor ("fresnelcolor", Color) = (0.6745283,1,0.9772592,1)
        [MaterialToggle] _fresnel ("fresnel", Float ) = 0
        _OpacityClip ("Opacity Clip", Float ) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        LOD 200
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _texture; uniform float4 _texture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color)
                UNITY_DEFINE_INSTANCED_PROP( float, _fresnelstrength)
                UNITY_DEFINE_INSTANCED_PROP( float4, _fresnelcolor)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _fresnel)
                UNITY_DEFINE_INSTANCED_PROP( float, _OpacityClip)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 projPos : TEXCOORD3;
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float _OpacityClip_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OpacityClip );
                clip((partZ+_OpacityClip_var) - 0.5);
////// Lighting:
////// Emissive:
                float4 _Color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Color );
                float4 _texture_var = tex2D(_texture,TRANSFORM_TEX(i.uv0, _texture));
                float3 node_5306 = (_Color_var.rgb*_texture_var.rgb);
                float4 _fresnelcolor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _fresnelcolor );
                float _fresnelstrength_var = UNITY_ACCESS_INSTANCED_PROP( Props, _fresnelstrength );
                float4 node_2096_k = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
                float4 node_2096_p = lerp(float4(float4(_fresnelcolor_var.rgb,0.0).zy, node_2096_k.wz), float4(float4(_fresnelcolor_var.rgb,0.0).yz, node_2096_k.xy), step(float4(_fresnelcolor_var.rgb,0.0).z, float4(_fresnelcolor_var.rgb,0.0).y));
                float4 node_2096_q = lerp(float4(node_2096_p.xyw, float4(_fresnelcolor_var.rgb,0.0).x), float4(float4(_fresnelcolor_var.rgb,0.0).x, node_2096_p.yzx), step(node_2096_p.x, float4(_fresnelcolor_var.rgb,0.0).x));
                float node_2096_d = node_2096_q.x - min(node_2096_q.w, node_2096_q.y);
                float node_2096_e = 1.0e-10;
                float3 node_2096 = float3(abs(node_2096_q.z + (node_2096_q.w - node_2096_q.y) / (6.0 * node_2096_d + node_2096_e)), node_2096_d / (node_2096_q.x + node_2096_e), node_2096_q.x);;
                float3 _fresnel_var = lerp( node_5306, lerp(node_5306,_fresnelcolor_var.rgb,(pow(1.0-max(0,dot(normalDirection, viewDirection)),_fresnelstrength_var)*node_2096.b)), UNITY_ACCESS_INSTANCED_PROP( Props, _fresnel ) );
                float3 emissive = saturate(_fresnel_var);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _OpacityClip)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD1;
                float4 projPos : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float _OpacityClip_var = UNITY_ACCESS_INSTANCED_PROP( Props, _OpacityClip );
                clip((partZ+_OpacityClip_var) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
