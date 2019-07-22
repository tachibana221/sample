// 投稿時に画像をリサイズする

/*
  使いたいviewのファイルに以下みたいなものを定義する
  data-model-name: 画像を保存したいモデルの名前(複数形)
  data-image-field-name: 画像を保存するフィールドの名前
  data-record-id: レコードのID

  ↓例↓
  <button class="btn btn-primary" id="upload-button">登録</button>
  <div id="upload_data" 
    data-model-name="patients"
    data-image-url-field-name="image_url"
    data-record-id="<%= @patient.id %>"
  ></div>
*/
function resizeImage(){
  const THUMBNAIL_WIDTH = 1280;
  const THUMBNAIL_HEIGHT = 1280;
  const file = $("#image-file").prop('files')[0];  

  if(!file){
    return
  }

  // 選択されたファイルが画像かどうか判定
  if (file.type != 'image/jpeg' && file.type != 'image/png') {
    // 画像でない場合は終了
    return;
  }

  const modelName = $('#upload_data').data('model-name');
  const imageFieldName = $('#upload_data').data('image-field-name');
  const recordID = $('#upload_data').data('record-id');
  
  // 画像をリサイズする
  const image = new Image();
  const reader = new FileReader();
  reader.onload = function(e) {
    image.onload = function() {
      let width, height;
      if(image.width > image.height){
        // 横長の画像は横のサイズを指定値にあわせる
        const ratio = image.height/image.width;
        width = THUMBNAIL_WIDTH;
        height = THUMBNAIL_WIDTH * ratio;
      } else {
        // 縦長の画像は縦のサイズを指定値にあわせる
        const ratio = image.width/image.height;
        width = THUMBNAIL_HEIGHT * ratio;
        height = THUMBNAIL_HEIGHT;
      }
      // canvasのサイズを上で算出した値に変更
      const canvas = document.createElement("canvas");
      canvas.width = width;
      canvas.height = height;
      const ctx = canvas.getContext('2d');
      // canvasに既に描画されている画像をクリア
      ctx.clearRect(0,0,width,height);
      // canvasにサムネイルを描画
      ctx.drawImage(image,0,0,image.width,image.height,0,0,width,height);

      // canvasからbase64画像データを取得
      const base64 = canvas.toDataURL('image/jpeg');

      $.ajax({
				url: '/' + modelName + '/' + recordID + '/upload_image', 
				type: "POST", 
				data:{
          [imageFieldName]:base64,
				}
			});

    }
    image.src = e.target.result;
  }
  // 画像を読み込む
  reader.readAsDataURL(file);
}

$(function() {
	$("#upload-button").on("click", function () {
    resizeImage();
  });
});