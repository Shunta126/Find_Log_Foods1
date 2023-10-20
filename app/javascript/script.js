$(document).on('turbolinks:load',function() {
  // スクロールトップボタンをクリックしたときの処理
  $('.scroll-top-btn').click(function(e) {
    e.preventDefault();
    $('html, body').animate({ scrollTop: 0 }, 'slow'); // ページトップへスクロール
  });

  // ページが100ピクセルまでスクロールされたらボタンを表示
  $(window).scroll(function() {
    if ($(this).scrollTop() > 250) {
      $('.scroll-top-btn').fadeIn();
    } else {
      $('.scroll-top-btn').fadeOut();
    }
  });
});