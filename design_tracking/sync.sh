
# TODO: move logic that makes sure Shapr is continually running here

rsync -a ~/Library/Containers/com.shapr3d.shapr/Data/Documents/ ./Documents

git status

git add .

git commit -m "adding changes"
