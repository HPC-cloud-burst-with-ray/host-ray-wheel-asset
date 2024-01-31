# prepare for environment according to the ray official document

set -e

ray_path=$1

echo "ray path: $ray_path"

# install dependencies: nvm, node, npm, bazel
cd $ray_path

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

source ~/.bashrc

nvm install 14
nvm use 14

# install bazel, run ./ci/env/install-bazel.sh
./ci/env/install-bazel.sh

cd $ray_path/dashboard/client
npm ci
npm run build
cd $ray_path/python

pip3 install -e . --verbose

# pack ray wheel file
python3 setup.py bdist_wheel