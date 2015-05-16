**Development Branch** = current 100% working app, pull from here before you push your own brach.

Hello World Branch = The Hello World server
  - https://corpsebook.herokuapp.com/
  - https://git.heroku.com/corpsebook.git

**Draft One** = Original server creation brach. Currently in use for production of story and contribution routes
 - https://corpsebook-server.herokuapp.com/
 - https://git.heroku.com/corpsebook-server.git

**Search Nearby** = Most up to date server branch, with below routes and nearby (search radius) route in development (as of Friday evening). Heroku link as above.
 
**ROUTES:**

  /stories 
    -GET 
      - returns all stories 
      - will return each as: {story: {id: 1, title: "title", contribution_limit: 45, completed: false}}

  -POST
    - create a new story
    - needs to take input as: {story: { title: "title", contribution_limit: 45}}
    - failure status 400
    
  /stories/:id 
    -GET 
      - returns the title and contributions (last only if story is not completed, all if story is completed) for a story 
      - will return as: { title: "story title", all_contributions/last_contribution: { story_id: story_id, content: "content" } }

  /stories/:story_id/contributions 
    -POST 
      - create a contribution for a specific story 
      - needs to take input as: {contribution: {content: "content"}}

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
