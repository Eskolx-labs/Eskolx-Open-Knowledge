---
tldraw-file: true
tags:
  - tldraw
---


```json !!!_START_OF_TLDRAW_DATA__DO_NOT_CHANGE_THIS_PHRASE_!!!
{
	"meta": {
		"uuid": "d2fae5cd-5a73-405c-9d05-f6ec70d58e6f",
		"plugin-version": "1.32.0",
		"tldraw-version": "5.4.0"
	},
	"raw": {
		"tldrawFileFormatVersion": 1,
		"schema": {
			"schemaVersion": 2,
			"sequences": {
				"com.tldraw.store": 5,
				"com.tldraw.asset": 1,
				"com.tldraw.camera": 1,
				"com.tldraw.document": 2,
				"com.tldraw.instance": 26,
				"com.tldraw.instance_page_state": 5,
				"com.tldraw.page": 1,
				"com.tldraw.instance_presence": 6,
				"com.tldraw.pointer": 1,
				"com.tldraw.shape": 4,
				"com.tldraw.user": 1,
				"com.tldraw.asset.image": 6,
				"com.tldraw.asset.video": 5,
				"com.tldraw.asset.bookmark": 2,
				"com.tldraw.shape.arrow": 8,
				"com.tldraw.shape.bookmark": 2,
				"com.tldraw.shape.draw": 5,
				"com.tldraw.shape.embed": 4,
				"com.tldraw.shape.frame": 1,
				"com.tldraw.shape.geo": 12,
				"com.tldraw.shape.group": 0,
				"com.tldraw.shape.highlight": 4,
				"com.tldraw.shape.image": 5,
				"com.tldraw.shape.line": 5,
				"com.tldraw.shape.note": 13,
				"com.tldraw.shape.text": 4,
				"com.tldraw.shape.video": 4,
				"com.tldraw.binding.arrow": 1
			}
		},
		"records": [
			{
				"gridSize": 10,
				"name": "",
				"meta": {},
				"id": "document:document",
				"typeName": "document"
			},
			{
				"x": 0,
				"y": 0,
				"lastActivityTimestamp": 0,
				"meta": {},
				"id": "pointer:pointer",
				"typeName": "pointer"
			},
			{
				"meta": {},
				"id": "page:page",
				"name": "Page 1",
				"index": "a1",
				"typeName": "page"
			},
			{
				"followingUserId": null,
				"opacityForNextShape": 1,
				"stylesForNextShape": {},
				"brush": null,
				"scribbles": [],
				"cursor": {
					"type": "default",
					"rotation": 0
				},
				"isFocusMode": false,
				"exportBackground": true,
				"isDebugMode": false,
				"isToolLocked": false,
				"screenBounds": {
					"x": 0,
					"y": 0,
					"w": 1080,
					"h": 720
				},
				"insets": [
					false,
					false,
					false,
					false
				],
				"zoomBrush": null,
				"isGridMode": false,
				"isPenMode": false,
				"chatMessage": "",
				"isChatting": false,
				"highlightedUserIds": [],
				"isFocused": false,
				"devicePixelRatio": 1.5,
				"isCoarsePointer": false,
				"isHoveringCanvas": null,
				"openMenus": [],
				"isChangingStyle": false,
				"isReadonly": false,
				"meta": {},
				"duplicateProps": null,
				"cameraState": "idle",
				"id": "instance:instance",
				"currentPageId": "page:page",
				"typeName": "instance"
			},
			{
				"editingShapeId": null,
				"croppingShapeId": null,
				"selectedShapeIds": [],
				"hoveredShapeId": null,
				"erasingShapeIds": [],
				"hintingShapeIds": [],
				"focusedGroupId": null,
				"meta": {},
				"id": "instance_page_state:page:page",
				"pageId": "page:page",
				"typeName": "instance_page_state"
			},
			{
				"x": 0,
				"y": 0,
				"z": 1,
				"meta": {},
				"id": "camera:page:page",
				"typeName": "camera"
			},
			{
				"name": "",
				"color": "#F2555A",
				"imageUrl": "",
				"meta": {},
				"id": "user:KgFYMM8TjSHyGSFRj5vuj",
				"typeName": "user"
			},
			{
				"x": 123.33334350585938,
				"y": 237.34375,
				"rotation": 0,
				"isLocked": false,
				"opacity": 1,
				"meta": {},
				"id": "shape:mEjPnpVH6vh6sQGZxwHnQ",
				"type": "text",
				"props": {
					"color": "black",
					"size": "m",
					"w": 377.32293701171875,
					"font": "draw",
					"textAlign": "start",
					"autoSize": true,
					"scale": 1,
					"richText": {
						"type": "doc",
						"attrs": {
							"dir": "auto"
						},
						"content": [
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "New value x"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "     ↓"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "delta = x - mean"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "     ↓"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "mean = mean + delta / n"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "     ↓"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "M2 = M2 + delta × (x - mean)"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "     ↓"
									}
								]
							},
							{
								"type": "paragraph",
								"attrs": {
									"dir": "auto"
								},
								"content": [
									{
										"type": "text",
										"text": "sample variance = M2 / (n - 1)"
									}
								]
							}
						]
					}
				},
				"parentId": "page:page",
				"index": "a1Vb6",
				"typeName": "shape"
			}
		]
	}
}
!!!_END_OF_TLDRAW_DATA__DO_NOT_CHANGE_THIS_PHRASE_!!!
```