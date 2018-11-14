// // will only fire when entire document is loaded
// $(document).ready(function(){
//   $("a.load_posts").on("click", function(e){
//     alert("You clicked on this link")
//     e.preventDefault(); //stop browser from reloading
//   })
// })

//when document is ready, fire the following function
$(function(){
  $("a.load_posts").on("click", function(e){
    alert("You clicked on this link")

    //fire some ajax
    //get a response
    //load that response into the html of the page

    e.preventDefault(); //stop browser from reloading
  })
})
