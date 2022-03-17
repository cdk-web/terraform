#! bash -eux

__filename=$(readlink -f "$0")
__dirname=$(dirname "$__filename")
__root=$(dirname "$__dirname")

installGitRepoAsNodeModule() {
  name=$1
  repo=$2
  branch=$3
  postCloneHook=$4
  pushd $__root
    rm -rf $name $name-src.tgz
    git clone --depth=1 --branch ${branch} ${repo} $name
    if [ -n "$postCloneHook" ]
    then
      pushd $__root
        bash -c "$postCloneHook"
      popd
    fi
    pushd $name
      npm init -y
      npm pack
    popd
    mv $name/$name-1.0.0.tgz $name-src.tgz && rm -rf $name
  popd
}

dependencies=$(node -p "Object.keys(require('$__root/package.json').gitDependencies).join('\n')")

for dependency in $dependencies
do
  repo=$(node -p "require('$__root/package.json').gitDependencies['${dependency}'].repo")
  branch=$(node -p "require('$__root/package.json').gitDependencies['${dependency}'].branch")
  postCloneHook=$(node -p "require('$__root/package.json').gitDependencies['${dependency}'].postClone||''")
  test -f $dependency-src.tgz || installGitRepoAsNodeModule $dependency $repo $branch "$postCloneHook"
done
