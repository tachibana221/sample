
// 使用ライブラリ
// https://konvajs.org/
// 参考
// https://konvajs.org/docs/sandbox/Free_Drawing.html

// 測定手順
// - 付箋の下端を選ばせる
// - 付箋の上端を選ばせる
// - 線を引く
// - 引き直すかどうかの確認
// - 褥瘡部位の長径の始点を選ばせる
// - 褥瘡部位の長径の終点を選ばせる
// - 線を引く
// - 引き直すかどうかの確認
// - 褥瘡部位の短径の始点を選ばせる
// - 褥瘡部位の短径の始点を選ばせる
// - 線を引く
// - 引き直すかどうかの確認
// - 計測
// - 結果表示
// 描画はkonvaJS

// 計測結果入れとくやつ
let resultSize = {
  'minorAxisSize': 0,
  'majorAxisSize': 0,
}
// 大きさを測ったかポケットを測ったか
let measureType = 'size'

// サイズ計測用のクラス
let SizeMeasure = class{
  constructor(stage){
    this.stage = stage;
    this.measureLayer = new Konva.Layer();
    this.stage.add(this.measureLayer);
    // 測定の基準となるタグのサイズ(cm)      
    this.tagSize = 15;
  }
  async measureSize (){
    // 付箋の長さ
    const tagLine =  await this.drawLine('red', '付箋');
    const tagLength = this.calcLengthBetweenTwoPoints(tagLine[0], tagLine[1]);
    // 短径の長さ
    const minorAxisLine =  await this.drawLine('green', '褥瘡部位の短径');
    const minorAxisLength = this.calcLengthBetweenTwoPoints(minorAxisLine[0], minorAxisLine[1]);
    
    // 長径の長さ
    const majorAxisLine =  await this.drawLine('blue', '褥瘡部位の長径');
    const majorAxisLength = this.calcLengthBetweenTwoPoints(majorAxisLine[0], majorAxisLine[1]);

    const minorAxisSize = (minorAxisLength / tagLength) * this.tagSize;
    const majorAxisSize = (majorAxisLength / tagLength) * this.tagSize;

    return {
      'minorAxisSize': Math.round(minorAxisSize * 10) / 10,
      'majorAxisSize': Math.round(majorAxisSize * 10) / 10,
    }
  }

  // 線を描画する
  // 始点と終点の座標を返す
  // [{始点.x 始点.y}, {終点.x, 終点.y}]
  async drawLine(color, message){
    // 始点を決める
    const startPosition = await this.drawPoint(color, message + "の始点");

    // 終点を決める
    const endPosition = await this.drawPoint(color, message + "の終点")

    // 2点間で線を引く
    const line = new Konva.Line({
      points: [startPosition.x, startPosition.y, endPosition.x, endPosition.y],
      stroke: color,
      strokeWidth: 3,
      lineCap: 'round',
      lineJoin: 'round'
    });
    this.measureLayer.add(line);
    this.measureLayer.batchDraw();
    return [startPosition, endPosition];
  }

  // ポインターを描画する
  // 座標を返す
  async drawPoint(color, message){
    // 表示する案内用のメッセージを表示
    $("#guide-message-under").text(message + "を指定してください")
    const position = await this.getPointPosition();
    const point = new Konva.Circle({
      x: position.x,
      y: position.y,
      radius: 5,
      fill: color,
      stroke: 'black',
      strokeWidth: 1
    });
    this.measureLayer.add(point);
    this.measureLayer.batchDraw();
    return position
  }

  // タッチ（クリック）した場所の座標を取得
  // Promiseは入力があるまで処理を待つやつ
  async getPointPosition(){
    // new Promise~~ のなかでthisを使うとスコープが違ってSizeMeasureのthis.stageを取得できないので一旦ローカル変数に取り出す
    // アロー関数を使えばこんな事しなくてもいいけど、今後の代への引き継ぎと可読性を考えてアロー関数は封印
    const stage = this.stage
    return new Promise(function(resolve, reject){
      stage.on('mousedown touchstart', function(){
        const position = stage.getPointerPosition();
        resolve(position);
      });
    });
  }

  // 2点間の距離を算出
  calcLengthBetweenTwoPoints(startPoint, endPoint){
    return Math.sqrt(Math.pow(startPoint.x - endPoint.x, 2) + Math.pow(startPoint.y - endPoint.y, 2));
  }
}

// 測定開始
async function startMeasure (stage, type) {
  if(type == "size"){
    $("#guide-message").text("大きさを測定します");
  }else{
    $("#guide-message").text("ポケットを測定します");
  }

  const sizeMeasure = new SizeMeasure(stage);
  // 長さを測定する
  const size = await sizeMeasure.measureSize();
  // 測定完了時結果を表示する

  if(type == "size"){
    $("#guide-message").text("大きさは");
  }else{
    $("#guide-message").text("ポケットは");
  }

  $(".end-button").show();
  $("#guide-message-under").text("短径" + size.minorAxisSize + "cm , 長径" + size.majorAxisSize + "cm");
  $("#guide-message-under").toggleClass('h4');

  resultSize = size;
  measureType = type;
}

// 画像サイズを取得したいので一旦画像を読み込む
async function setup(){
  const baseImageURL = $('#image_data').data('image-url');
  const image = await loadImage(baseImageURL);

  const width = image.width;
  const height = image.height;
  const stage = await drawImage(width, height);

  // 測定開始
  $("#start-size-measure").on("click", async function(){
    $(".start-measure").hide()
    await startMeasure(stage, "size")
  });

  $("#start-pocket-measure").on("click", async function(){
    $(".start-measure").hide()
    await startMeasure(stage, "pocket")
  });

  // 再測定
  $("#re-measure").on("click", async function(){
    $(".end-button").hide();
    $("#guide-message-under").toggleClass('h4');
    stage.children[1].destroy()
    await startMeasure(stage)
  });

  // 測定終了
  $("#end-measure").on("click", async function(){
    $(".end-button").hide();
    $("#guide-message-under").toggleClass('h4');
    $("#guide-message").text("");
    
    if(measureType == "size"){
      $("#size_minor_axis").val(resultSize.minorAxisSize)
      $("#size_major_axis").val(resultSize.majorAxisSize)
      $("#guide-message-under").text("大きさを入力欄に入力しました。");
    }else{
      $("#pocket_minor_axis").val(resultSize.minorAxisSize)
      $("#pocket_major_axis").val(resultSize.majorAxisSize)
      $("#guide-message-under").text("ポケットを入力欄に入力しました。");
    }
    
    stage.children[1].destroy()
    $(".start-measure").show()
  });
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

// 画像を描画する
async function drawImage(imageWidth, imageHeight) {
	const canvas = $("#canvas_area")[0];
	if (canvas) {

		// 大本となるキャンバス(ステージ)作成
		const stage = new Konva.Stage({
			container:"canvas_area",
			width: imageWidth,
			height: imageHeight
		});

		// 画像表示用レイヤー
		const iamgeLayer = new Konva.Layer();

		// それぞれのレイヤーをステージに追加
		stage.add(iamgeLayer);

		// 背景画像を読み込んでレイヤーにセット
		const baseImageURL = $('#image_data').data('image-url');
		Konva.Image.fromURL(baseImageURL, function(imageNode){
			iamgeLayer.add(imageNode);
			iamgeLayer.batchDraw();
		});
    return stage;
  } 
}

// ページ読み込み完了時に実行する
$(function() {
	setup();
});