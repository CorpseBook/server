**Development Branch** = current 100% working app, pull from here before you push your own brach.

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


Harriet's secret testing ajax

 $(document).ready(function(){
   $.ajax({
     url: "http://localhost:3000/token",
     type: "POST",
     data: {email: "user@example.com",
             password: "password"
           },
     success: function(data, status){
       console.log(data)
       var token = data.token
       $.ajaxSetup({
           headers: { 'Authorization': "Token token="+token }
       });
       $.ajax({
         url: "http://localhost:3000/stories",
         type: "GET",
         // data: {story:
         //         {title: "soemthing"}
         //       },
         success: function(data, status){
           console.log(data, status)
         },
         failure: function(data, status){
           console.log(data, status)
         }
       })
     },
     failure: function(data,status){
       console.log(data, status)
     }
   })
 });
