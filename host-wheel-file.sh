# host the compiled wheel file
# get current node's ip address
node_ip=$(hostname -I | awk '{print $1}')

# set ray_path to be first argument
ray_path=$1

# wheel path = ray_path + /python/dist/ray-<versions>.whl
wheel_path=$ray_path/python/dist/

# scan for wheel file
wheel_file=$(ls $wheel_path | grep ray)

cd $wheel_path

# host wheel file by python3 -m http.server 8888
echo "hosting wheel file: $wheel_file"
echo "use the following curl command to download the wheel file"
echo "curl http://$node_ip:8888/$wheel_file -o $wheel_file"

python3 -m http.server 8888 &