$(document).ready(function() {
  
  setTimeout(function(){
    $('.alert').slideUp(3000);
  }, 3500);


  $(document).on("keyup", ".img-name", function(){
    $.ajax({
      url:'/galleries/validate_img_name',
      type:'post',
      data:{
        name: $(this).val()
      },success:function(){

      }
    });
  });
});