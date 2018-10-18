function backMain() {
    var userId = $.cookie('user_id');
    window.location.replace('/seckill/desk/' + userId);

}
