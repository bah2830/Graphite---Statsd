APP_NAME=graphite

RUN_FLAG="-d --restart=always"
if [ "$1" == "debug" ]; then
    RUN_FLAG="--rm"
fi

GRAPHITE_DATA=""
if [ -d "/Storage/Backup/graphite_data" ]; then
    GRAPHITE_DATA="-v /Storage/Backup/graphite_data:/opt/graphite/storage"
fi

echo "Building $APP_NAME image"
docker build -t $APP_NAME .

echo "Removing $APP_NAME container if it exists"
docker rm -f $APP_NAME

echo "Running $APP_NAME container"
docker run $RUN_FLAG \
    -h $APP_NAME \
    --name $APP_NAME \
    -p 8200:80 \
    -p 2003:2003 \
    -p 8125:8125/udp \
    $GRAPHITE_DATA \
    $APP_NAME
