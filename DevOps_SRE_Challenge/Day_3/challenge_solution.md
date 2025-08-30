# Challenge Solution

## Task 1: Amend a Commit

The `git commit --amend` command is the convenient way to modify the recent changes.It lets you combine the staged chnages with previous commit instead of cretaing a entierly new commit.

```
git commit --amend

```

*Example:*

**Let's supoose you have couple of files in your repo and made some chnages on those files.Then, you have staged and commit the changes in local(you have not pushed the changes to remote repository).**

```
git add /Day_3/challenge_solution.md challenge3.md

git commit -m "feat: add new lines in these files"

```

**Now, you missed to add a change to file in the last commit. So, you want to add the change and commit it.After done with change in the file, follow below steps:**

```
git add /Day_3/challenge_solution.md

git commit --amend -m "update: add few more changes to solution file"
```

So, this is how you can utilise the `git commit ---amend` command to fix **typos in the commit message** and **Add missed changes.**

