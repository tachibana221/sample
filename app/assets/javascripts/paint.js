// お絵かき機能のセットアップ
// 使用ライブラリ
// https://konvajs.org/
// 参考
// https://konvajs.org/docs/sandbox/Free_Drawing.html
function setupPainter(width,height) {
	const comments = [{
		id:10,
		text:"hello",
		x:100.11,
		y:200.5
	},
	{
		id:1,
		text:"world",
		x:500,
		y:200
	},
	{
		id:2,
		text:"zoi",
		x:100,
		y:400
	}]
	const canvas = $("#canvas_area")[0];
	if (canvas) {

		// 各種画像編集用のUI
		const saveButton = $("#save_canvas");
		const clearButton = $("#clear_canvas");
		const colorSelector = $("#color_canvas");
		const modeSelector = $("#mode_canvas");
		const weightRange = $("#weight_canvas");
		const zibaku = $("#zibaku");

		// 大本となるキャンバス(ステージ)作成
		const stage = new Konva.Stage({
			container:"canvas_area",
			width: width,
			height: height
		});

		// 画像表示用レイヤー
		const iamgeLayer = new Konva.Layer();
		// 手書き用レイヤー
		const drawLayer = new Konva.Layer();
		// 文字表示用レイヤー
		const textLayer = new Konva.Layer();

		// それぞれのレイヤーをステージに追加
		stage.add(iamgeLayer, drawLayer, textLayer);

		// 背景画像を読み込んでレイヤーにセット
		const baseImageURL = $("#bedsore_image_url").val();
		Konva.Image.fromURL(baseImageURL,function(imageNode){
			iamgeLayer.add(imageNode);
			iamgeLayer.batchDraw();
		});
		
		// 手書き画像を読み込んでレイヤーにセット
		const handwriteImageUrl = $("#bedsore_handwrite_image_url").val();
		Konva.Image.fromURL(handwriteImageUrl,function(imageNode){
			drawLayer.add(imageNode);
			drawLayer.batchDraw();
		});

		// 保存されていたコメントを表示
		for (const comment of comments) {
			const textNode = new Konva.Text({
				text:comment.text,
				x:comment.x,
				y:comment.y,
				draggable:true,
				fontSize:20,
				id:comment.id
			});
			textLayer.add(textNode);
			textLayer.batchDraw();
		}

		// 手書き用設定
		let isPainting = false;
		// ペンの色
		let strokeColor= '#000000'
		// ペンの太さ
		let strokeWidth = 5;
		// ペンか消しゴムか
		let mode = 'draw'
		// 線描画用
		let lastLine;

		// キャンバスの上でマウスを押したとき
		stage.on('mousedown touchstart', function(event){
			// ドラッグ可能なオブジェクト（テキスト等）な場合は線を引かない
			if(event.target.attrs.draggable){
				return;
			}

			isPainting = true;
      const position = stage.getPointerPosition();
      lastLine = new Konva.Line({
        stroke: strokeColor,
        strokeWidth: strokeWidth,
        globalCompositeOperation:
          mode === 'draw' ? 'source-over' : 'destination-out',
        points: [position.x, position.y]
      });
      drawLayer.add(lastLine);
		});
		
		// キャンバスの上でマウスを離したとき
		stage.on('mouseup touchend', function(event) {
			// テキストを移動していた場合は座標を書き換える
			// jqueryめんどくさい。vueとかreeact使いたい
			if(event.target.attrs.draggable){
				const id = event.target.attrs.id;
				const index = comments.findIndex(function(comment) {
					return comment.id == id;
				});
				comments[index].x = event.target.attrs.x
				comments[index].y = event.target.attrs.y
			}
      isPainting = false;
		});
		
		// キャンバスの上でマウスを押しながら動かしたとき（線を引いてるとき）
		stage.on('mousemove touchmove', function() {
			if (!isPainting) {
				return;
			}

			const position = stage.getPointerPosition();
			const newPoints = lastLine.points().concat([position.x, position.y]);
			lastLine.points(newPoints);
			stage.batchDraw();
		});

		// 手書き画像の保存処理
		saveButton.on("click", function () {
			const _form = $(".edit_bedsore")[0];
			const canvas_data = drawLayer.toDataURL();
			$("#bedsore_handwrite_image_url").val(canvas_data);
			_form.submit();
		});

		// 書いた絵を全部消す
		clearButton.on("click", function () {
			drawLayer.destroyChildren()
			stage.draw();
		});

		// 書いた絵を全部消す
		zibaku.on("click", function () {
			console.log(textLayer);
			
		});

		// ペンの色を変更
		colorSelector.change(function () {
			strokeColor = "#" + colorSelector.val();
		});

		// モードを変更
		modeSelector.change(function () {
			mode = modeSelector.val();			
		});

		// 太さ変更
		weightRange.change(function () {
			strokeWidth = weightRange.val();			
			// sketcher.weight = parseFloat(weight);
		});
  } 
}

function loadImage(){
	console.log("called");
	const baseImageURL = $("#bedsore_image_url").val();
	const image = new Image();
	image.src = baseImageURL;

	image.onload = function(){
		const width = image.width;
		const height = image.height;
		console.log(width, height);
		
		setupPainter(width, height);
	};
}



// ページ読み込み完了時に実行する
$(document).on('turbolinks:load', loadImage);

// $(document).on('page:load', setupPainter);
// $(document).on('turbolinks:load', setupPainter);
