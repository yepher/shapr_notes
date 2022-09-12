# This will track changes that are made to Shapr3D projects
# WARNING: This is very likely to break at anytime so don't count on this backup


# TODO: move logic that makes sure Shapr is continually running here

# Keep read-only copy of files to make sure we don't mess the App up
rsync -a ~/Library/Containers/com.shapr3d.shapr/Data/Documents/ ./Documents

# dump list of current changes
git status

# add all changes (could be a lot smarter here)
git add .

# save off any changes that may have happened
# Would be nice to have smarter comments somehow
git commit -m "adding changes"
