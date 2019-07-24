// お絵かき画像のビューアーのセットアップ
// 使用ライブラリ
// https://konvajs.org/
// 参考
// https://konvajs.org/docs/sandbox/Free_Drawing.html
function setupPaintViewer(imageWidth, imageHeight) {
	const canvas = $("#canvas_area")[0];
	if (canvas) {
		const comments = $('#image_data').data('comments')

		// 大本となるキャンバス(ステージ)作成
		const stage = new Konva.Stage({
			container:"canvas_area",
			width: imageWidth,
			height: imageHeight
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
		Konva.Image.fromURL(baseImageURL, function(imageNode){
			iamgeLayer.add(imageNode);
			iamgeLayer.batchDraw();
		});
		
		// 手書き画像を読み込んでレイヤーにセット
		const handwriteImageUrl = $('#image_data').data('handwrite-image-url');
		Konva.Image.fromURL(handwriteImageUrl, function(imageNode){
			drawLayer.add(imageNode);
			drawLayer.batchDraw();
		});

		// 保存されていたコメントを表示
		for (const comment of comments) {
			const textNode = new Konva.Text({
				text:comment.text,
				x:comment.position_x,
				y:comment.position_y,
				draggable:false,
				fontSize:30,
				id:comment.id
			});
			textLayer.add(textNode);
			textLayer.batchDraw();
		}
  } 
}

// 画像サイズを取得したいので一旦画像を読み込む
async function setup(){	
	const baseImageURL = $('#image_data').data('image-url');
	const image = await loadImage(baseImageURL)

	// 読み込み完了後、お絵かきアプリのセットアップを行う。
	const width = image.width;
	const height = image.height;
	setupPaintViewer(width, height);
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

// ページ読み込み完了時に実行する
$(function() {
	setup();
});