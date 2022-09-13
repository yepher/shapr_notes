# Shapr 3D Rest API

Shapr3D notes.

## Project Structures

### iPad Project Structure


```
[PROJECT UUID] (one for each project
├── dark_thumbnail.png
├── metadata.plist
├── project
│   ├── drawings
│   │   ├── [PROJECT UUID].dwg
│   │   ├── [PROJECT UUID].png
│   │   └── [PROJECT UUID]_dark.png
│   └── workspace (SQLLite)
└── thumb.png
```

**metadata.plist**

```
{
	"OwnerID": "[USERS UUID]",
	"WorkspaceName": "[PROJECT NAME]"
}
```

### MacOS Project Structure

* `~/Library/Containers/com.shapr3d.shapr/Data/Documents`

```
├── Documents
│   ├── projects.db
│   ├── purchaserecord.plist
│   ├── resources
│   └── workspaces
│       │   └── [Project UUID]
│       │       ├── drawings
│       │       │   ├── [HEX_ID].dwg
│       │       │   ├── [HEX_ID].png
│       │       │   ├── [HEX_ID]
│       │       │   ├── [HEX_ID].dwg
│       │       │   ├── [HEX_ID].png
│       │       │   └── [HEX_ID]_dark.png
│       │       └── workspace
│       ├── More [Project UUID]...
```

## Viewing Workspace Contents

* x_b body data: `SELECT ShapeName, ShapeData FROM Shapes` 


## Protocol Dump


* Host: 
	* App API: `prod.api.shapr3d.com`
	* Sync API: `sync.api.shapr3d.com`
	* Telemetry: `telemetry.api.shapr3d.com`
	* Project Files Example: `shapr3d-sync-projects-prod.s3-accelerate.amazonaws.com`
	* Thumbnail Files: `shapr3d-sync-thumbnails-prod.s3-accelerate.amazonaws.com`
* User Agent: `Shapr3D/N.NNN.N (com.shapr3d.shapr; build:NNNN; macOS(Catalyst) N.N.N) Alamofire/N.N.N`
* Others:
	* Crashlytics
	* Firebase

	
### Auth

Initial Auth
	
### Refresh Token (APP)

* `https://prod.api.shapr3d.com/user-management/auth/refresh-token`



#### Request

* URL: `https://prod.api.shapr3d.com/user-management/auth/refresh-token`
* Method: POST

**Headers**

```
authorization: Bearer [TOKEN]
content-type: application/json
x-shapr-user-tracking-id: [User UUID]
accept: */*
accept-language: en-US;q=1.0
user-agent: Shapr3D/N.NNN.N (com.shapr3d.shapr; build:NNNN; macOS(Catalyst) N.N.N) Alamofire/N.N.N
x-shapr-platform: macos

```

```
{
	"audience": "app"
}
```

#### Response

**Headers**

```
content-type: application/json
x-amzn-requestid: [UUID]
access-control-allow-origin: 
x-amz-apigw-id: [BASE 64]
access-control-allow-methods: DELETE, PUT, POST, GET, OPTIONS
x-amzn-trace-id: Root=1-HEX_VALS;Sampled=0
x-amz-cf-pop: [AMAZON POINT OF ACCESS]
x-amz-cf-id: [BASE 64]
```


**Body**

```
{
	"refreshToken": "BASE64",
	"accessToken": "BASE64"
}
```


### Profile With Device

* URL: `https://prod.api.shapr3d.com/user-management/profile-with-device`
* Method: GET

#### Request

**Headers**

```
accept: */*
authorization: Bearer [TOKEN]
x-shapr-user-tracking-id: [User Tracking UUID]
x-shapr-app-version: N.NNN.N.NNNN
x-shapr-device-id: [DEVICE UUID]
accept-language: en-US;q=
```

#### Response

**Header**

```
content-type: application/json
x-amzn-requestid: [UUID[
access-control-allow-origin: 
x-amz-apigw-id: [BASE64]
access-control-allow-methods: DELETE, PUT, POST, GET, OPTIONS
x-amzn-trace-id: Root=HEXID;Sampled=0
x-cache: Miss from cloudfront
via: 1.1 HOSTID.cloudfront.net (CloudFront)
x-amz-cf-pop: [AMAZON POP]
x-amz-cf-id: [BASE64]
```

**Body**

```
type Subscription struct {
	ID               string `json:"id"`
	Email            string `json:"email"`
	SubscriptionType string `json:"subscriptionType"`
	Subscriptions    []struct {
		ID                  int    `json:"id"`
		Type                string `json:"type"`
		Tier                string `json:"tier"`
		EffectiveFeatureSet string `json:"effectiveFeatureSet"`
		Period              string `json:"period"`
		PurchaseDate        string `json:"purchaseDate"`
		ExpirationDate      string `json:"expirationDate"`
		AutoRenewStatus     bool   `json:"autoRenewStatus"`
		IsTrial             bool   `json:"isTrial"`
	} `json:"subscriptions"`
	SubscriptionExpires string `json:"subscriptionExpires"`
	HasEmail            bool   `json:"hasEmail"`
	HasPassword         bool   `json:"hasPassword"`
	HasFacebookID       bool   `json:"hasFacebookID"`
	SyncPermissions     struct {
		ProjectSyncAllowed     bool `json:"projectSyncAllowed"`
		ProjectSyncFeatureFlag bool `json:"projectSyncFeatureFlag"`
	} `json:"syncPermissions"`
	Plans struct {
		PaddleLiteMonthly struct {
			Tier            string `json:"tier"`
			Period          string `json:"period"`
			IsTrialEligible bool   `json:"isTrialEligible"`
			CheckoutURL     string `json:"checkoutURL"`
		} `json:"paddle.lite.monthly"`
		PaddleLitePERIOD struct {
			Tier            string `json:"tier"`
			Period          string `json:"period"`
			IsTrialEligible bool   `json:"isTrialEligible"`
			CheckoutURL     string `json:"checkoutURL"`
		} `json:"paddle.lite.PERIOD"`
	} `json:"plans"`
}
```


### Tracking IDS

* URL: `https://prod.api.shapr3d.com/user-management/users/UUID/tracking-ids`
* Method: PUT

#### Request

**Headers**

```
:authority: HOST
content-type: application/json
x-shapr-app-version: N.NNN.N.NNNN
x-shapr-user-tracking-id: [USER UUID]
accept: */*
authorization: Bearer [TOKEN]
x-shapr-device-id: [DEVICE UUID]
accept-encoding: br;q=1.0, gzip;q=0.9, deflate;q=0.8
accept-language: en-US;q=1.0
content-length: 39
user-agent: Shapr3D/N.NNN.N (com.shapr3d.shapr; build:NNNN; macOS(Catalyst) NN.N.N) Alamofire/N.N.N
x-shapr-platform: [PLATFORM]

```

**Body**

```
type UserTracking struct {
	AppsflyerID string `json:"appsflyerId"`
}
```


#### Response

```
{ 
	"success": true 
}
```


### App Properties


#### Request

* URL: `https://prod.api.shapr3d.com/user-management/users/[USER_UUID]/app-properties`
* Method: PUT

**Headers**

```
:method: PUT
:scheme: https
:authority: prod.api.shapr3d.com
content-type: application/json
x-shapr-app-version: N.NNN.N.NNNN
x-shapr-user-tracking-id: [USER UUID]
accept: */*
authorization: Bearer [TOKEN]
x-shapr-device-id: [DEVICE UUID]
accept-encoding: br;q=1.0, gzip;q=0.9, deflate;q=0.8
accept-language: en-US;q=1.0
user-agent: Shapr3D/N.NNN.N (com.shapr3d.shapr; build:NNNN; macOS(Catalyst) N.N.N) Alamofire/N.N.N
x-shapr-platform: [OS PLATFORM]
```

**Body**

```
type UserEngagementStatus struct {
	OnboardingIosMouseCompleted      bool   `json:"onboarding_ios_mouse_completed"`
	SegmentationInterest             string `json:"segmentation_interest"`
	OnboardingWinTrackpadCompleted   bool   `json:"onboarding_win_trackpad_completed"`
	OnboardingIosTrackpadCompleted   bool   `json:"onboarding_ios_trackpad_completed"`
	OnboardingIosPencilCompleted     bool   `json:"onboarding_ios_pencil_completed"`
	MacosGetStartedPromptSeen        bool   `json:"macos_get_started_prompt_seen"`
	OnboardingMacosTrackpadCompleted bool   `json:"onboarding_macos_trackpad_completed"`
	OnboardingWinMouseCompleted      bool   `json:"onboarding_win_mouse_completed"`
	OnboardingMacosMouseCompleted    bool   `json:"onboarding_macos_mouse_completed"`
	SegmentationWorkWebCompleted     bool   `json:"segmentation_work_web_completed"`
	WindowsGetStartedPromptSeen      bool   `json:"windows_get_started_prompt_seen"`
	OnboardingWinPencilCompleted     bool   `json:"onboarding_win_pencil_completed"`
	OnboardingWinWacomCompleted      bool   `json:"onboarding_win_wacom_completed"`
	IosGetStartedPromptSeen          bool   `json:"ios_get_started_prompt_seen"`
	SyncEnabledVersion               int    `json:"sync_enabled_version"`
	SegmentationIsDfcOrEntrepreneur  bool   `json:"segmentation_is_dfc_or_entrepreneur"`
	GdprAcceptanceLevel              bool   `json:"gdpr_acceptance_level"`
	SegmentationIsStudentOrTeacher   bool   `json:"segmentation_is_student_or_teacher"`
	SyncEnabled                      bool   `json:"sync_enabled"`
	SegmentationWorkCompleted        bool   `json:"segmentation_work_completed"`
}
```


### Refresh Token (Sync)

* URLL `https://prod.api.shapr3d.com/user-management/auth/refresh-token`	
* Method: Post

#### Request

**Header**

```
content-type: application/json
x-shapr-app-version: N.NNN.N.NNNN
accept: */*
x-shapr-user-tracking-id: [USER Tracking UUID]
authorization: Bearer [TOKEN]
x-shapr-device-id: [DEVICE UUID]
user-agent: Shapr3D/NNNN CFNetwork/NNNN.N.N Darwin/NN.N.N
x-shapr-platform: macOS

```

**Body**

```
{
	"audience":"sync"
}
```


#### Response

**Header**

```
content-type: application/json

```

**Body**

```
type OAuthTokens struct {
	RefreshToken string `json:"refreshToken"`
	AccessToken  string `json:"accessToken"`
}
```


### List Projects

* URL: `https://sync.api.shapr3d.com/v2/projects?deleted=true&pending=false&uploaded=true&changesSince=0`
* Method: GET

#### Request

**Header**

```
accept: */*
x-shapr-platform: macos
authorization: Bearer [TOKEN]
x-shapr-device-id: [DEVICED UUID]
user-agent: Shapr3D/NNNN CFNetwork/NNNN.N.N Darwin/NN.N.N
```

#### Response

**Header**

```
content-type: application/json

```

**Body**

**GoLang Response Struct**

```
type ProjectRevisions struct {
	Projects []struct {
		Project struct {
			ProjectID   string    `json:"projectId"`
			Name        string    `json:"name"`
			CreatedAt   time.Time `json:"createdAt"`
			UpdatedAt   time.Time `json:"updatedAt"`
			ChangeSeqNo int       `json:"changeSeqNo"`
		} `json:"project"`
		LatestRevision struct {
			RevisionID         int       `json:"revisionId"`
			UploadedByDeviceID string    `json:"uploadedByDeviceId"`
			UploadedByPlatform string    `json:"uploadedByPlatform"`
			CreatedAt          time.Time `json:"createdAt"`
			UploadedAt         time.Time `json:"uploadedAt"`
			LastModifiedAt     time.Time `json:"lastModifiedAt"`
			FileSize           int       `json:"fileSize"`
			AppVersion         string    `json:"appVersion"`
			ProjectVersion     int       `json:"projectVersion"`
			Latest             bool      `json:"latest"`
		} `json:"latestRevision"`
	} `json:"projects"`
	ChangeSeqNo int  `json:"changeSeqNo"`
	HasNextPage bool `json:"hasNextPage"`
}
```


### Fetch Project Revision

* URL: `https://sync.api.shapr3d.com/v2/projects/[Project UUID]/revisions/1?includeUpload=false`
* Method: Get

#### Request

```
authorization: Bearer [TOKEN]
x-shapr-app-version: N.NNN.N.NNNN
x-shapr-device-id: [DEVICE UUID]

```

#### Response

**GoLang Response Structure**

```
type ProjectRevision struct {
	Project struct {
		ProjectID   string    `json:"projectId"`
		Name        string    `json:"name"`
		CreatedAt   time.Time `json:"createdAt"`
		UpdatedAt   time.Time `json:"updatedAt"`
		ChangeSeqNo int       `json:"changeSeqNo"`
	} `json:"project"`
	Revision struct {
		RevisionID         int       `json:"revisionId"`
		UploadedByDeviceID string    `json:"uploadedByDeviceId"`
		UploadedByPlatform string    `json:"uploadedByPlatform"`
		CreatedAt          time.Time `json:"createdAt"`
		UploadedAt         time.Time `json:"uploadedAt"`
		LastModifiedAt     time.Time `json:"lastModifiedAt"`
		FileSize           int       `json:"fileSize"`
		AppVersion         string    `json:"appVersion"`
		ProjectVersion     int       `json:"projectVersion"`
		Latest             bool      `json:"latest"`
		FileDownload       struct {
			Method string    `json:"method"`
			URL    string    `json:"url"`
			Expiry time.Time `json:"expiry"`
		} `json:"fileDownload"`
		ThumbnailDownloads struct {
			Light struct {
				Method string    `json:"method"`
				URL    string    `json:"url"`
				Expiry time.Time `json:"expiry"`
			} `json:"light"`
		} `json:"thumbnailDownloads"`
	} `json:"revision"`
}
```

### Telemetry

* URL: `https://telemetry.api.shapr3d.com/debug/`
* Method: Post

#### Request

```
type TelemetryEvents []struct {
	EventProperties struct {
		Component  string `json:"component"`
		Level      string `json:"level"`
		LogContext struct {
			OldState string `json:"oldState"`
			NewState string `json:"newState"`
		} `json:"log_context"`
		Message string `json:"message"`
	} `json:"event_properties"`
	TrackingID         string `json:"tracking_id"`
	UserID             string `json:"user_id"`
	AppStoreCountry    string `json:"app_store_country"`
	OsLocale           string `json:"os_locale"`
	InternetConnection string `json:"internet_connection"`
	PencilStatus       string `json:"pencil_status"`
	MouseStatus        string `json:"mouse_status"`
	KeyboardStatus     string `json:"keyboard_status"`
	SpaceMouseStatus   string `json:"space_mouse_status"`
	Experiments        struct {
		FirebaseAaTest          string `json:"firebase_aa_test"`
		W2Retention             string `json:"w2_retention"`
		PpcActivationCohort     string `json:"ppc_activation_cohort"`
		DfcHeroBusiness         string `json:"dfc_hero_business"`
		TrialOnboardingCampaign string `json:"trial_onboarding_campaign"`
		NoPaywall               string `json:"no_paywall"`
		GetStartedAll           string `json:"get_started_all"`
	} `json:"experiments"`
	Idfv        string `json:"idfv"`
	AppVersion  string `json:"app_version"`
	DeviceType  string `json:"device_type"`
	Platform    string `json:"platform"`
	OsVersion   string `json:"os_version"`
	AppLocale   string `json:"app_locale"`
	AmplitudeID string `json:"amplitude_id"`
	DeviceID    string `json:"device_id"`
	EventName   string `json:"event_name"`
	EventTime   string `json:"event_time"`
	EventID     int    `json:"event_id"`
	RetryCount  int    `json:"retry_count"`
	UploadTime  string `json:"upload_time"`
}
```
