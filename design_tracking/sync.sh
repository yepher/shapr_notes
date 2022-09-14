# This will track changes that are made to Shapr3D projects
# WARNING: This is very likely to break at anytime so don't count on this backup

while [ 1 ]
do

ps -ef | grep Shapr  | grep -v grep
if [ $? -eq 1 ]
then
open /Applications/Shapr3D.app
else
echo "Shapr is running"
fi

# Make read-only copy of any changes
rsync -a ~/Library/Containers/com.shapr3d.shapr/Data/Documents/ ./Documents

# Save any changes
git status
git add .
git commit -m "adding changes"

sleep 600 # 10 minutes = 600 seconds
done
