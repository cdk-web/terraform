#! bash -eux

__filename=$(readlink -f "$0")
__dirname=$(dirname "$__filename")
__root=$(dirname "$__dirname")

dependencies=$(node -p "Object.keys(require('$__root/package.json').gitDependencies).join('\n')")

for dependency in $dependencies
do
  pushd $__root/node_modules/$dependency
    test -d .git || (\
      git init && \
      git add -A && \
      git commit -m "unpatched" \
    )
  popd
done
