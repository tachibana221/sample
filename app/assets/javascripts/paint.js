
function setupPainter() {
	
	const canvas = $("#mySketcher")[0];
	if (canvas) {
		// 下に置く写真を取得
		const underImage = $("#under_image");
		canvas.width = underImage.width();
		canvas.height = underImage.height();
		
		// atrament（お絵かきライブラリ）セットアップ
		const sketcher = atrament('#mySketcher');
		const saveButton = $("#save_canvas");
		const clearButton = $("#clear_canvas");
		const colorSelector = $("#color_canvas");
		const modeSelector = $("#mode_canvas");
		const weightRange = $("#weight_canvas");
		sketcher.weight = 5;

		// 以前に書かれた画像を読み込む
		const image_url = $("#bedsore_handwrite_image").val();
		const ctx = canvas.getContext('2d');
		// 画像読み込み
		const image = new Image();
		// URLをセットして画像を読み込ませる
		image.src = image_url;

		// 読み込み完了時に画像を描画する
		image.onload = function(){			
			ctx.drawImage(image, 0, 0);
		}

		// 手書き画像の保存処理
    saveButton.on("click", function () {
      const _form = $(".edit_bedsore")[0];
      const canvas_data = sketcher.toImage();
      $("#bedsore_remote_handwrite_image_url").val(canvas_data);
      $("#bedsore_handwrite_image").val(null);
      _form.submit();
		});
		
		// 書いた文字を全部消す
		clearButton.on("click", function () {
			sketcher.clear();
		});

		// ペンの色を変更
		colorSelector.change(function () {
			const color = colorSelector.val();
			sketcher.color = "#" + color
		});

		// モードを変更
		modeSelector.change(function () {
			const mode = modeSelector.val();			
			sketcher.mode = mode;
		});

		// 太さ変更
		weightRange.change(function () {
			const weight = weightRange.val();			
			sketcher.weight = parseFloat(weight);
		});
  } 
}

// ページ読み込み完了時に実行する
$(document).ready(setupPainter);
// $(document).on('page:load', setupPainter);
// $(document).on('turbolinks:load', setupPainter);
