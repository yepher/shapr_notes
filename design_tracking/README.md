# Design Tracker

This is a simple proof of concept to track Shapr3D project changes. This is for MacOS. This is very likely to break at anytime so don't count on this as your project backup backup.

This is especially interesting since Shapr3D added cross device sync. Changes made from the iPad become available on Mac within a few minutes.

## What Does it Do?

`sync.sh`

Usage: `./sync.sh`

* Uses `rsync` to make a read-only copy of the files in `~/Library/Containers/com.shapr3d.shapr/Data/Documents`
* Uses `git` to check point changes

You can use `git history` to see what projects changed when

`buildIndex.sh`

Usage: `./buildIndex.sh |tee index.html; open ./index.html`

* Walks through all the directories in `Documents/workspaces` looking for `thumb.png`
* Writes HTML to standard out to build a thumbnail view of each project

