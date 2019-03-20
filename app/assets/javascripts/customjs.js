// 画像ロード中の表示エリアのサイズ（px）
var initialSize = 60;

// 拡大表示をウインドウの端から何px空けるか
var padding = 100;

// 各アニメーションの時間（ミリ秒）
var animDuration = 300;

function showImage(img) {
  var windowWidth = $(window).width();
  var windowHeight = $(window).height();
  
  var windowAspectRatio = windowWidth / windowHeight;
  
  var imageAspectRatio = img.width / img.height;
  
  var dispWidth;
  var dispHeight;
  if (windowAspectRatio > imageAspectRatio) {
    // 画像の方が縦に長い場合
    dispHeight = windowHeight - padding;
    dispWidth = dispHeight * imageAspectRatio;
  } else {
    // 画像の方が横に長い場合
    dispWidth = windowWidth - padding;
    dispHeight = dispWidth / imageAspectRatio;
  }
  
  $(img).css({
    width: dispWidth + "px",
    height: dispHeight + "px",
    display: "none"
  });
  
  $(".popup-content").html(img);
  
  $(".popup-content").animate(
    {
      width: dispWidth + "px",
      height: dispHeight + "px",
      "margin-left": -dispWidth / 2 + "px",
      "margin-top": -dispHeight / 2 + "px"
    },
    animDuration,
    "swing",
    function() {
      $(img).fadeIn(animDuration);
    }
  );
}

function showPopup(imageUrl) {
  $(".popup-content").html("");
  
  $(".overlay").fadeIn(animDuration);
  
  $(".popup-content").css({
    width: initialSize + "px",
    height: initialSize + "px",
    // 以下2つは上下左右中央に置くために必要
    "margin-left": -initialSize / 2 + "px",
    "margin-top": -initialSize / 2 + "px"
  });
  
  var img = new Image();
  img.onload = function() {
    showImage(img);
  };
  img.src = imageUrl;
}

function closePopup() {
  $(".overlay").fadeOut(animDuration);
}

function updateButton() {
  if ($(this).scrollTop() >= 300) {
    $(".back-to-top").fadeIn();
  } else {
    $(".back-to-top").fadeOut();
  }
}

$(document).on('turbolinks:load', function() {
  updateButton();
  
  $(window).scroll(updateButton);
  
  $(".back-to-top").click(function() {
    $("html, body").animate(
      {
        scrollTop: 0
      }, 600);
      
      return false;
  });
  
  $(".popup").click(function() {
    showPopup($(this).attr("src"));
    return false;
  });
  
  $(".overlay").click(function() {
    closePopup();
    return false;
  });
});