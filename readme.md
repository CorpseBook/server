**Development Branch** = current 100% working app, pull from here before you push your own brach.

Hello World Branch = The Hello World server
  - https://corpsebook.herokuapp.com/
  - https://git.heroku.com/corpsebook.git

**Draft One** = Original server creation brach. Currently in use for production of story and contribution routes
 - https://corpsebook-server.herokuapp.com/
 - https://git.heroku.com/corpsebook-server.git
 
 **ROUTES:**

  /stories
    -GET return all stories
    -POST create a story

  /stories/:id
    -GET returns the title and contributions (last only if story is not completed, all if story is completed) for a     story
  
  /stories/:story_id/contributions
    -POST create a contribution for a specific story

**HEROKU INSTRUCTIONS**

As several branches within this repo have heroku servers when you initially pull the repo you need to set up heroku remotes and learn to specify which app you're running heroku commands on.

In order to push to heroku
1) If git remote -v does not include the heroku server git URL
  ```git remote add NAME_YOU_WANT_FOR_ROUTE heroku-git-url```
  
2) Push to heroku
  ```git push NAME-YOU-MADE-FOR-YOUR-ROUTE your-branch-name:master```

NB:

When running heroku commands make sure they work by saying
 ```your-command corpse-book-server```
