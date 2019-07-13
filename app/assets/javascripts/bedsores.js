// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// function drwaing(){
//   if($("#mySketcher").length > 0){
//     const canvas = $("#mySketcher")[0];
//     const context = canvas.getContext('2d');
    
//     const image_url = $("#bedsore_handwrite_image").value
//     var image = new Image();
//     image.src = image_url;
//     image.onload = function(){
//       context.drawImage(image, 0, 0);
//     }
//     const sketcher = atrament('#mySketcher');
//     $("#save_canvas").on("click", function () {
//       const _form = $(".edit_bedsore")[0];
//       const canvas_data = sketcher.toImage();
//       $("#bedsore_remote_handwrite_image_url").val(canvas_data);
//       $("#bedsore_handwrite_image").val(null);
//       _form.submit();
//     });
//   } 
// }

// window.onload = drwaing