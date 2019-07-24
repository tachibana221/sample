// お絵かき機能のセットアップ
// 使用ライブラリ
// https://konvajs.org/
// 参考
// https://konvajs.org/docs/sandbox/Free_Drawing.html
function setupPainter(imageWidth, imageheight) {
	const canvas = $("#canvas_area")[0];
	if (canvas) {
		const bedsoreID = $('#image_data').data('bedsore-id');
		const comments = $('#image_data').data('comments')

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
			width: imageWidth,
			height: imageheight
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
		const baseImageURL = $('#image_data').data('image-url');
		Konva.Image.fromURL(baseImageURL,function(imageNode){
			iamgeLayer.add(imageNode);
			iamgeLayer.batchDraw();
		});
		
		// 手書き画像を読み込んでレイヤーにセット
		const handwriteImageUrl = $('#image_data').data('handwrite-image-url');
		Konva.Image.fromURL(handwriteImageUrl,function(imageNode){
			drawLayer.add(imageNode);
			drawLayer.batchDraw();
		});

		// 保存されていたコメントを表示
		for (const comment of comments) {
			const textNode = new Konva.Text({
				text:comment.text,
				x:comment.position_x,
				y:comment.position_y,
				draggable:true,
				fontSize:30,
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
        points: [position.x , position.y ]
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
				comments[index].position_x = event.target.attrs.x;
				comments[index].position_y = event.target.attrs.y;
			}
      isPainting = false;
		});
		
		// キャンバスの上でマウスを押しながら動かしたとき（線を引いてるとき）
		stage.on('mousemove touchmove', function() {
			if (!isPainting) {
				return;
			}

			const position = stage.getPointerPosition();
			const newPoints = lastLine.points().concat([position.x , position.y ]);
			lastLine.points(newPoints);
			stage.batchDraw();
		});

		// 手書き画像の保存処理
		saveButton.on("click", function () {
			// const _form = $(".edit_bedsore")[0];
			const canvas_data = drawLayer.toDataURL();
			$.ajax({
				url: '/bedsores/'+bedsoreID, 
				type: "POST", 
				data:{
					bedsore:{
						handwrite_image_url:canvas_data,
						comments:comments,
					},
					_method:'PUT',
				}
			});
		});

		// 書いた絵を全部消す
		clearButton.on("click", function () {
			drawLayer.destroyChildren()
			stage.draw();
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

// 画像を読み込む
// 読み込み終了時/失敗時に戻り値が返される（それまで待つ）
async function loadImage(src) {
  return new Promise(function (resolve, reject) {
    const img = new Image();
    img.onload = () => resolve(img);
    img.onerror = (e) => reject(e);
    img.src = src;
  });
}

// 画像サイズを取得したいので一旦画像を読み込む
async function setup(){	
	const baseImageURL = $('#image_data').data('image-url');
	const image = await loadImage(baseImageURL)
	const width = image.width;
	const height = image.height;
	setupPainter(width, height);
}

// ページ読み込み完了時に実行する
$(function() {
	setup();
});