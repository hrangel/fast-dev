# Git Alias
alias publishToSpecific="~/fast-dev/general/publishTo.sh"
alias publishToTeam="publishToSpecific team"
alias publishToStaging="publishToSpecific staging"

alias initGit="sh ~/fast-dev/general/init-git-project.sh"
alias bitbucketCreate="sh ~/fast-dev/general/create-new-bitbucket.sh"
alias githubCreate="sh ~/fast-dev/general/create-new-github.sh"

alias pg-start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias pg-stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"

alias mysql-start="mysql.server start"
alias mysql-stop="mysql.server stop"