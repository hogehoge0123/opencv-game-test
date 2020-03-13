# opencv-game-test
OpenCVのテスト用

公式（iOS向け）（動画像の取得〜画像処理の基本的な流れはここにまとまっている）<br>
https://docs.opencv.org/master/d3/dc9/tutorial_table_of_content_ios.html

ダウンロード（iOS向け）<br>
https://opencv.org/releases/

# TODO
- [x] Xcode のプロジェクトに OpennCV を組み込んで実機で動かす
- [x] フロントカメラから動画像を取得する
- [ ] eye-tracking の情報を取得する
  - [x] 目の位置を検出する
  - [ ] 黒目の位置を検出する
  - [ ] 目線を検出する
- [ ] ３６０°動画を再生する
- [ ] 目線で動画を操作する

# 参考
OpenCV for iOS の導入と画像の加工まで<br>
https://qiita.com/shu223/items/3ff48a8bd6edd910e780

# 今後参考にするかもしれないやつ
OpennCV を使った動画像の読み込みなど<br>
https://note.nkmk.me/python-opencv-videocapture-file-camera/

dlib、OpenCV を用いた顔認識について<br>
https://qiita.com/nonbiri15/items/9561c8194ba0b2041bd0

OpenCV, dlib を用いて黒目の追跡を行う処理を解説する動画<br>
https://www.youtube.com/watch?v=kbdbZFT9NQI

# メモ
* ビルドのために Foundationn などのフレームワークを追加する必要がある。
* 実機でカメラを使う場合には info.plist の設定（NSCameraUsageDescription）が必要<br>https://qiita.com/Takumi_Mori/items/f53c6eec1676d3df59dc
* VR動画を再生するために必要なもの<br>https://qiita.com/junpluse/items/0c8a78b0a754c9fc687b
* サンプルコードの Rect や Size は cv::Rect や cv::Size としないと iOS 標準の方の同名クラスの方が使われてしまうので注意。
