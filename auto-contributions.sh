#!/bin/sh

set -e
set -x

# Setting git variables
git config --global user.email "$GITHUB_USER_EMAIL"
git config --global user.name "$GITHUB_USER_NAME"

#Cloning destination git repository
git clone https://$GITHUB_TOKEN@github.com/$GITHUB_USER_NAME/$GITHUB_REPO.git

# Setting git safe directory
git config --global --add safe.directory '*'

# Setting remote URL
git remote set-url origin https://$GITHUB_TOKEN@github.com/$GITHUB_USER_NAME/$GITHUB_REPO.git

# Generating random number (between 1 and 100) to decide how many commits will be made
random_number=$(expr $RANDOM % 100 + 1)

# Deciding the amount of commits according to the chances, 25% for each
if [ $random_number -le 25 ]; then
    commits=1
elif [ $random_number -le 50 ]; then
    commits=3
elif [ $random_number -le 75 ]; then
    commits=5
else
    commits=8
fi

# Creating new random files 
cd $GITHUB_REPO/auto-commits
i=1
while [ $i -le $commits ]
do
    echo \
"project:
  name: \"My Awesome Project Number: $(expr $RANDOM)\"
  description: \"A project to demonstrate the power of SHELL scripts.\"
  version: \"v$(expr $RANDOM % 10).$(expr $RANDOM % 10).$(expr $RANDOM % 10)\"
  repository:
    type: \"git\"
    url: \"https://github.com/$GITHUB_USER_NAME/$GITHUB_REPO.git\"

maintainer:
  name: \"$GITHUB_USER_NAME\"
  email: \"$GITHUB_USER_EMAIL\"
  role: \"Devops and Cloud Infrastructure Analyst\"" \
  > "auto_commit_$(expr $RANDOM)$(expr $RANDOM)$(expr $RANDOM).yml"

    i=$((i+1))

    # Adding git commit
    git add auto_commit_*
    git commit --message "Automatic update $GITHUB_REPO: $(expr $RANDOM)"

    # Pushing git commit
    git push
done