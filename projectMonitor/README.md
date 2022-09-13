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