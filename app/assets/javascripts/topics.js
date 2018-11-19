// Submit Comments via AJAX - soon to be replaced by remote true
$(function(){
  $("#new_topic").on("submit", function(e){
    // 1.need URL to submit the POST requested
    // 2.need form data

    // //low level
    // $.ajax({
    //   type: ($("input[name='_method']").val() || this.method),
    //   url: this.action,
    //   data: $(this).serialize(); //either json or querystring serializing
    //   success: function(resp){
    //     $("#topic_name").val("");
    //     var $h3 = $("div.topics h3")
    //     $h3.append(resp);
    //   }
    // });
    e.preventDefault();
    console.log("Stop")
  });
});
