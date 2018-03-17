# Onboarding Skip #

Pre requirments

- Install JQ
https://stedolan.github.io/jq/download/

To install:

```
git clone https://github.com/hrangel/fast-dev

chmod u+x ./fast-dev/onboarding.sh

source ./fast-dev/onboarding.sh

rm -rf fast-dev
```


## Usage ##

```
publishToSpecific team    # merges and push codes to team branch
publishToSpecific staging # merges and push codes to staging branch
publishToSpecific live    # merges and push codes to live branch

initGit                   # initializes git project with default branches
bitbucketCreate           # creates a BitBucket Rep
githubCreate              # creates a GitHub Rep
```