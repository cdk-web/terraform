#! bash -eux

__filename=$(readlink -f "$0")
__dirname=$(dirname "$__filename")
__root=$(dirname "$__dirname")

installGitRepoAsNodeModule() {
  name=$1
  repo=$2
  branch=$3
  pushd $__root
    rm -rf $name $name-src.tgz
    git clone --depth=1 --branch ${branch} ${repo} $name
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
  test -f $dependency-src.tgz || installGitRepoAsNodeModule $dependency $repo $branch
done
