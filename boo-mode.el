;;boo-mode.el -- Boo editing mode
;;(mainly for Unity)
;;
;;originary
;;
;;Author : Nariya Takemrua
;;Commentary:
;;Originary, This file was copied from below.
;;http://answers.unity3d.com/questions/263061/syntax-highlighting-for-boo-emacs.html
;;http://forum.unity3d.com/threads/72458-Official-Boo-Scripting-Resource-Thread/page4?p=1030789&viewfull=1#post1030789
;;
;;I customize some part, but mainly this script was wrote by them.
;; --------
;; BOO/UNITY SYNTAX HIGHLIGHTING
;;
;; Define faces
(defface boo-modifier-face
  '((t (:inherit font-lock-function-name-face)))
  "Face for Boo modifiers (public, static, etc.)")
(defvar boo-modifier-face 'boo-modifier-face)

(defface boo-type-face
  '((t (:inherit font-lock-constant-face)))
  "Face for Boo/CLI variable types (int, double, etc.)")
(defvar boo-type-face 'boo-type-face)
 
(defface unity-keyword-class-face
  '((t (:inherit font-lock-variable-name-face)))
  "Face for Unity-specific class keywords (MonoBehavior, Vector3, etc)")
(defvar unity-keyword-class-face 'unity-keyword-class-face)
 
(defface unity-idioms-face
  '((t (:underline t)))
  "Face for common Unity 'idioms' like 'gameObject.GetComponent'")
(defvar unity-idioms-face 'unity-idioms-face)
 
;; Define regex expressions for highlighting
(defvar boo-font-lock-keywords
  (let ((kw1 (mapconcat 'identity
            '("public" "static" "private" "abstract" "virtual" "override" "protected" "final" )
            "\\|"))
    (kw2 (mapconcat 'identity
            '("ADBannerView" "ADError" "ADInterstitialAd" "AccelerationEvent" "ActionScript" "AndroidInput" 
"AndroidJNIHelper" "AndroidJNI" "AndroidJavaObject" "AndroidJavaClass" "AnimationCurve" "AnimationEvent" 
"AnimationState" "Application" "Array" "AudioSettings" "BitStream" "BoneWeight" "Bounds" "Caching" 
"ClothSkinningCoefficient" "Collision" "Color32" "Color" "CombineInstance" "Compass" "ContactPoint" 
"ControllerColliderHit" "Debug" "DetailPrototype" "Event" "GL" "GUIContent" "GUILayoutOption" "GUILayoutUtility" 
"GUILayout" "GUISettings" "GUIStyleState" "GUIStyle" "GUIUtility" "GUI" "GeometryUtility" "Gizmos" "Graphics"
"Gyroscope" "Handheld" "Hashtable" "HostData" "IAchievementDescription" "IAchievement" "ILeaderboard" "IScore" 
"ISocialPlatform" "GameCenterPlatform" "IUserProfile" "ILocalUser" "Input" "JointDrive" "JointLimits" 
"JointMotor" "JointSpring" "Keyframe" "LayerMask" "LightmapData" "LightmapSettings" "LocalNotification" 
"LocationInfo" "LocationService" "MasterServer" "MaterialPropertyBlock" "Mathf" "Matrix4x4" "Microphone" 
"NavMeshHit" "NavMeshPath" "NetworkMessageInfo" "NetworkPlayer" "NetworkViewID" "Network" "NotificationServices" 
"Object" "AnimationClip" "AssetBundle" "AudioClip" "Component" "Behaviour" "Animation" "AudioChorusFilter" 
"AudioDistortionFilter" "AudioEchoFilter" "AudioHighPassFilter" "AudioListener" "AudioLowPassFilter" 
"AudioReverbFilter" "AudioReverbZone" "AudioSource" "Camera" "ConstantForce" "GUIElement" "GUIText" 
"GUITexture" "GUILayer" "LensFlare" "Light" "MonoBehaviour" "Terrain" "NavMeshAgent" "NetworkView" "Projector" 
"Skybox" "Cloth" "InteractiveCloth" "SkinnedCloth" "Collider" "BoxCollider" "CapsuleCollider" 
"CharacterController" "MeshCollider" "SphereCollider" "TerrainCollider" "WheelCollider" "Joint" 
"CharacterJoint" "ConfigurableJoint" "FixedJoint" "HingeJoint" "SpringJoint" "LODGroup" "LightProbeGroup" 
"MeshFilter" "OcclusionArea" "OcclusionPortal" "OffMeshLink" "ParticleAnimator" "ParticleEmitter" 
"ParticleSystem" "Renderer" "ClothRenderer" "LineRenderer" "MeshRenderer" "ParticleRenderer"
"ParticleSystemRenderer" "SkinnedMeshRenderer" "TrailRenderer" "Rigidbody" "TextMesh" "Transform" "Tree" 
"Flare" "Font" "GameObject" "LightProbes" "Material" "ProceduralMaterial" "Mesh" "NavMesh" "PhysicMaterial" 
"QualitySettings" "ScriptableObject" "GUISkin" "Shader" "TerrainData" "TextAsset" "Texture" "Cubemap" 
"MovieTexture" "RenderTexture" "Texture2D" "WebCamTexture" "OffMeshLinkData" "ParticleSystem.Particle" 
"Particle" "Path" "Physics" "Ping" "Plane" "PlayerPrefsException" "PlayerPrefs" "ProceduralPropertyDescription" 
"Profiler" "Quaternion" "Random" "Range" "Ray" "RaycastHit" "RectOffset" "Rect" "RemoteNotification" 
"RenderBuffer" "RenderSettings" "Resolution" "Resources" "Screen" "Security" "SleepTimeout" "Social" 
"SoftJointLimit" "SplatPrototype" "StaticBatchingUtility" "String" "SystemInfo" "Time" "TouchScreenKeyboard" 
"Touch" "TreeInstance" "TreePrototype" "Vector2" "Vector3" "Vector4" "WWWForm" "WWW" "WebCamDevice" 
"WheelFrictionCurve" "WheelHit" "YieldInstruction" "AsyncOperation" "AssetBundleCreateRequest" 
"AssetBundleRequest" "Coroutine" "WaitForEndOfFrame" "WaitForFixedUpdate" "WaitForSeconds" "iPhoneInput" 
"iPhoneSettings" "iPhoneUtils" "iPhone")
            "\\|"))
    (kw3 (mapconcat 'identity
            '("sbyte" "short" "int" "long" "byte" "ushort"
              "uint" "ulong" "single" "double" "decimal" "char"
              "bool" "string" "object")
            "\\|"))
    (kw4 (mapconcat 'identity
            '("transform.Translate" "gameObject.GetComponent"
              "Destroy" "gameObject.FindWithTag" "gameObject.Find" "Mathf.FloorToInt" "gameObject.GetComponent" "Resources.Load" "DestroyImmediate")
            "\\|"))
    )
    (list
     ;; variable/class/function modifiers
     (list (concat "\\([^. \t]\\|^\\)[ \t]*\\b\\([" kw1 "\\| ]+\\)\\b[ \b\t]")
       2 boo-modifier-face)
     ;; Unity-specific classes and such
     (list (concat "[ ()\t]+\\(" kw2 "\\)[ )(\t\n]+")
       1 unity-keyword-class-face)
     ;; BOO/CLI variable types
     (list (concat "\\b\\(" kw3 "\\)\\b")
       1 boo-type-face)
     ;; Unity-specific commonly used "idioms"
     (list (concat "\\(" kw4 "\\)")
       1 unity-idioms-face)
     ;; Variable assignment
     (list (concat "^[ \t]*\\b\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)\\b[ \t]*\\(-=\\|\\+=\\|=\\)[ \t]*")
           1 font-lock-constant-face)
 
     ;; True/False is now true/false (and null)
     '("\\<\\(true\\|false\\|null\\)\\>"
       1 font-lock-keyword-face)
 
     ;; basic lock syntax
     '("\\<\\(lock\\|struct\\|class\\)\\>"
       1 font-lock-keyword-face)
 
     ;; highlight a struct name
     '("^[ \t]*struct \\(.*\\):"1 py-class-name-face)
  
     ))
  "Additional expression to highlight in Boo mode.")

;; Define a new mode, boo-mode, derived from python-mode. This
;; will currently just function as python-mode with some additional
;; syntax highlighting.
(define-derived-mode boo-mode python-mode
  "boo-mode"
  "syntax highlighting for boo. derived from python-mode"
  (font-lock-add-keywords 'boo-mode boo-font-lock-keywords)
 
  (set-syntax-table
   (let ((table (make-syntax-table python-mode-syntax-table)))

    ;; C-style comments /**/ (see elisp manual "Syntax Flags"))
    (modify-syntax-entry ?/ ". 124" table)
    (modify-syntax-entry ?* ". 23b" table)
    table)
					)

;;; Constants
  (defconst py-blank-or-comment-re "[ \t]*\\($\\|#\\|//\\)"
	"Regular expression matching a blank or comment line.")

  (defconst py-no-outdent-re "\\(struct\\s+.*:\\|lock\\s+.*:\\|try:\\|except\\(\\s +.*\\)?:\\|using\\s +.*:\\|while\\s +.*:\\|for\\s +.*:\\|if\\s +.*:\\|elif\\s +.*:\\)\\([    ]*\\_<\\(return\\|raise\\|break\\|continue\\|pass\\)\\_>[   \n]\\)")

  (defconst py-block-re "[ \t]*\\_<\\(class\\|def\\|for\\|if\\|try\\|using\\|while\\|with\\|lock\\|struct\\)\\_>[: \n\t]"

  "Matches the beginning of a compound statement. ")
  (defconst py-minor-block-re "[ \t]*\\_<\\(for\\|if\\|try\\|lock\\|struct\\)\\_>[: \n\t]"
    "Matches the beginning of an `for', `if' or `try' block. ")
  (defconst py-block-or-clause-re "[ \t]*\\_<\\(if\\|else\\|elif\\|using\\|while\\|for\\|def\\|class\\|try\\|except\\|finally\\|with\\|lock\\|struct\\)\\_>[: \n\t]"
    "Matches the beginning of a compound statement or it's clause. ")

  (defconst py-extended-block-or-clause-re "[ \t]*\\_<\\(def\\|class\\|if\\|else\\|elif\\|using\\|while\\|for\\|try\\|except\\|finally\\|with\\)\\_>[: \n\t]"
	"Matches the beginning of a compound statement or it's clause.Includes def and class. ")

)

;; All files with the .boo extension will now use boo-mode
;;(require 'boo-mode)                 
(setq auto-mode-alist (cons '("\\.boo" . boo-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("boo" . boo-mode) interpreter-mode-alist)) 
;; define boo interpreter 
(setq boo-python-command "booi -")
