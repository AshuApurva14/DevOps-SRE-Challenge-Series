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

### Verify with

`git log --oneline`

---

![Screenshot_1](Day_3_1.png)

---

![Screensho_2](Day_3_4.png)

---


## Task 2: Interactive Rebase

**Squash Commits:** Combining multiple individual commits into single. consolidated comit.

 - **When to Squash**

  1. Before merging a feature branch to simplify code review.

  2. To roll up many small commits into one, making rollbacks and change tracking easier.

  3. To keep the project commit history organized and meaningful.


**Reword Commits:** Reword in git means changing the commit messages of  one or more previous commits without any changes to actual code.

 - **Why Reword Commits?**

  1. To correct typos, clarify descriptions, or add information missed in the original commit message.

  2. To maintain a clean, professional commit history before sharing work or merging branches.

 - *To reword older commit messages, use interactive rebase— `git rebase -i HEAD~N` (where N is the number of commits back)*


**Drop Comiits:**  Dropping commits in Git means removing specific commits from the project history so that it's as if they never happened.

 - **Cautions**

 1. Dropping commits irreversibly rewrites history. If others are working on the same branch, coordinate with them to avoid conflicts or lost work.

 2. For public repositories, consider using git revert instead, as this preserves history but undoes changes safely.


 - *The most common way to drop (delete) commits is through interactive rebase: run `git rebase -i HEAD~N`, where N is the number of commits back to review.*


 - Rebase the last 3 commits

 *Before rebasing, have your target branch up to date, work on the correct branch, consider backing up, have permission to force push if needed, keep your working directory clean, and be prepared to resolve conflicts.*

  1. Check the last 3 commits with `git log --oneline`.

  2. Be on the branch (Typically feature) where you will rebase the master/main branch.

  3. you can rebase the last 3 commits using `git rebase -i HEAD~3`, where 3 is the number of commits.
  
  ![after rebase](Day3_4.png)


 - Squash last 2 commits and reword a message

  ![squash 2 commits](Day_3_6.png)

   
 - Final history
  ![Final History](Day_3_7.png)
  
---

## Task 3: Tag a Release

 **In the context of Git, tagging is a way to label specific points in your project's history, most commonly to mark release versions, major milestones, or significant events.**

 **Tagging in Git involves placing a “tag” on a particular commit (snapshot of your project), like sticking a bookmark or sticky note on a key page in a book. Once added, this tag will always point to the exact state of your repository at that moment, making it easy to revisit, share, or reference that version.**


 **Why Use Tags in Git?**
  
  *Release Management:*
  - Tags are essential for labeling releases, such as v1.0 or v2.3.1, so anyone can retrieve that exact version for bug fixes, deployment, or reference later.

  *Version Control:*
  - Tags help identify stable, feature-complete, or test versions of the software in the repository.

  *Collaboration:*
  - They provide an easy way for teams or automation tools to refer to specific code versions without confusion.

  **Two types of tags are available in [git](https://git-scm.com/book/en/v2/Git-Basics-Tagging):**
   1. *Lightweight tags*
   2. *Annotated tags*

---

 - Create an *annotated tag* v2.0.0.

   1. You can create an annotated tag using `git tag -a v2.0.0 -m "Official release of version 2.0".`
    
 - Push the tags to Github.

---

## Task 4: Sync with Upstream

 - Fork a repo, add upstream, and sync changes.

   1. Fork a repo 

   2. Add upstream `git remote add upstream <repo url>`

     ![Add Upstream](Day_3_9.png)     

   3. Sync fork repo `git fetch upstream`

     ![Sync upstream](Day_3_11.png)

     ![Sync upstream](Day_3_11.png)



## Task 5: Stashing and Cherry-Picking

🔹 1. Git Stash

👉 Analogy:
Imagine you’re writing a document, but someone tells you, “Stop, switch tasks!”. Instead of throwing away your half-written page, you quickly put it in a drawer (stash) and come back later.

That’s what git stash does — it temporarily shelves (stashes) your uncommitted changes so you can work on something else, and then reapply them later.


✅ Example: Using Stash

- You’re on main branch, editing file1.py and file2.py.
 
`git status`

shows:

![before stash](Day_3_12.png)

- Suddenly, you need to switch branches but don’t want to commit.

`git stash push`

![after stash](Day_3_13.png)


- This saves your modifications and cleans your working directory.

   - Now git status shows a clean tree.

   - Switch branches or pull updates safely.

   - When ready, bring back your changes:


`git stash pop`


- This reapplies your stashed changes and removes them from stash.

  👉 If you want to keep the stash for reuse:


`git stash apply`



📝 **Stash Commands Cheatsheet**

- `git stash` → save uncommitted changes

- `git stash list` → see all stashes

- `git stash apply stash@{1}` → apply a specific stash

- `git stash drop stash@{1}` → delete a stash

- `git stash clear` → remove all stashes


---

🔹 2. Git Cherry-Pick

👉 *Analogy:*

 Imagine you baked a cake with 5 layers (commits), but your friend only wants the 3rd layer. Instead of giving the whole cake, you pick that specific layer and place it into another cake.

That’s what git cherry-pick does — it copies a specific commit from one branch and applies it to another branch.

✅ Example: Cherry-Pick

 - On feature-branch, you make 3 commits:

     ![3 commits](Day_3_14.png)   

 - Your teammate says: “I need just the bug fix (g7h8i9) in main right now!”

 - Switch to main:

    `git checkout main`


 - Cherry-pick the commit:

    `git cherry-pick `


 - Now main has that commit, without merging the other ones.

   ![cherry-pick](Day_3_15.png)

📝 **Cherry-Pick Cheatsheet**

`git cherry-pick <commit-hash>` → pick one commit

`git cherry-pick A..B` → pick a range of commits (exclusive of A, inclusive of B)

`git cherry-pick --abort` → cancel if conflicts occur

`git cherry-pick --continue` → continue after fixing conflicts

---

## Task 6: Rebase a Feature Branch


  - Rebase onto main, resolve conflicts, and push.

   1. Chekcout into feature branch and run `git rebase main`

     ![after rebase](Day_3_16.png)

  


