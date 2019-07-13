
function setupPainter() {
	
	const canvas = $("#mySketcher")[0];
	if (canvas) {
		
		// atrament（お絵かきライブラリ）セットアップ
		const sketcher = atrament('#mySketcher');

		// 以前に書かれた画像を読み込む
		const image_url = $("#bedsore_handwrite_image").val();
		const ctx = canvas.getContext('2d');
		// 画像読み込み
		const image = new Image();
		image.src = image_url;
		// 画像を描画
		ctx.drawImage(image, 0, 0);
		

		// 手書き画像の保存処理
    $("#save_canvas").on("click", function () {
      const _form = $(".edit_bedsore")[0];
      const canvas_data = sketcher.toImage();
      $("#bedsore_remote_handwrite_image_url").val(canvas_data);
      $("#bedsore_handwrite_image").val(null);
      _form.submit();
    });
  } 
}

$(document).ready(setupPainter);
// $(document).on('page:load', setupPainter);
// $(document).on('turbolinks:load', setupPainter);
