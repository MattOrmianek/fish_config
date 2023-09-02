import subprocess

# Fetch all remote branches
subprocess.run(["git", "fetch", "origin"])

# Get a list of all remote branches
remote_branches = subprocess.getoutput("git branch -r").split("\n")
remote_branches = [branch.strip().replace("origin/", "") for branch in remote_branches]

# Loop through each remote branch and create a corresponding local branch
for branch in remote_branches:
    if branch:  # Ignore empty lines
        print(f"Creating local branch for {branch}")
        subprocess.run(["git", "checkout", "-b", branch, f"origin/{branch}"])
