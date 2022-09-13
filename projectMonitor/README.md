# Project Monitor

This is a starting point to monitor Shapr3D projects for changes.

**Goals**

* On project change wait for workspace quiescences
* `rsync` changes to read-only copy
* analyze changes and from an intelligent commit
* commit changes to git
* rinse & repeat

Usage:

```
go build
./projectMonitor
```

Currently app is stupid and just logs when something changes.

## TODO:

* Run this on extra Mac
* Keep Shapr3D running so sync happens in background
	* `ps -ef |grep Shapr3D |grep -v grep`
	* open /Applications/Shapr3D.app
* Make web interface to browse change history and select from most recent changes to send directly to CNC (ie was files call 2D drawing like cuts dwg)