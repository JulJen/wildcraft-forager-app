// $(function(){
//   $("a.load_posts").on("click", function(e) {
//     //server responds with javascript
//     $.ajax({
//       url: this.href,
//       dataType: 'script'
//     })
//
//     e.preventDefault(); //stop browser from reloading
//   });
// });


// $(function(){
//   $("a.load_posts").on("click", function(e) {
//
//     alert('Load Post was performed.');
//
//     // //requesting HTML
//     // $.get(this.href).then(function(resp){
//     //   $("div.posts").html(resp);
//     // });
//
//     //requesting JSON
//     $.get(this.href).then(function(json){
//       //clear the h3 html in case there were stale comments
//
//       //js variable pointing at jquery object
//       let $h3 = $("div.posts h3")
//       $("div.comments h3").html("")
//       //iterate over each comment in json
//       //with each post data, append an LI to the OL with the post content
//         json.forEach(function(post){ //each individual post object
//           $h3.append("<li>" + post.name + "" + "</li>");
//         })
//     })
//
//   e.preventDefault(); //stop browser from reloading
//   });
// });



// // will only fire when entire document is loaded
// $(document).ready(function(){
//   $("a.load_posts").on("click", function(e){
//     alert("You clicked on this link")
//     e.preventDefault(); //stop browser from reloading
//   })
// })


// //when document is ready, fire the following function
// $(function(){
//   $("a.load_posts").on("click", function(e){ //when clicking on this link..
//     $.ajax({ //fire some ajax
//       method: "GET",
//       url: this.href  //what url do we want to fire this request to
//       //when request is done, server responds with content to this function as an argument called data
//     }).done(function(resp){ //callback, chaining on what to do when done
//       //get the response (it's variable data)
//       $("div.posts").html(resp)
//       alert('Load Post was performed.');
//     });
//
//     //get a response
//     //load that response into the html of the page
//
//     e.preventDefault(); //stop browser from reloading
//   })
// })
