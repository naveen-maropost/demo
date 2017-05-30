$(document).ready(function() {
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