#Set the environmental variable GITHUB_TOKEN to avoid rate limiting
GITHUB_TOKEN_PARAMETER=""
if [ ! -z "$GITHUB_TOKEN" ]; then
   GITHUB_TOKEN_PARAMETER="?access_token=$GITHUB_TOKEN"
fi

#Setting Repo and API URL
TOOL_REPO="find-sec-bugs/find-sec-bugs"
API_URL="https://api.github.com/repos/$TOOL_REPO"

#Saving latest release info to assets.json
curl "$API_URL/releases/latest$GITHUB_TOKEN_PARAMETER" > releases.json

#Using jq to get Asset ID and File Name
ASSET_ID=$(jq -r '.assets[0].id' releases.json)
ASSET_NAME=$(jq -r '.assets[0].name' releases.json)

#Cleaning up locally stored Asset File and releases.json file
rm releases.json
rm -f $ASSET_NAME

#Downloading FindSecBugs from GitHub releases
curl -O -J -L -H "Accept: application/octet-stream" "$API_URL/releases/assets/$ASSET_ID$GITHUB_TOKEN_PARAMETER"
unzip -o $ASSET_NAME -d findsecbugs
rm -f $ASSET_NAME
sed -i 's/java -cp/java -Xmx8g -XX:-UseGCOverheadLimit -cp/g' findsecbugs/findsecbugs.sh