// /*显示弹出层*/
// function popPanel(panelId,backgroundId){
//     document.getElementById(panelId).style.display = 'block';
//     document.getElementById(backgroundId).style.display = 'block';
//
//     var backpanel = document.getElementById(backgroundId);
//     backgroundId.style.width = document.body.scrollWidth;
//     $("#" + backgroundId).height($(document).height());
// };
//
// /*关闭弹出层*/
// function hidePanel(panelId,backgroundId){
//     document.getElementById(panelId).style.display = 'none';
//     document.getElementById(backgroundId).style.display = 'none';
// };

var overlay = $( "overlay" );
/* 显示遮罩层 */
function showOverlay(panelId) {
    overlay.height(pageHeight());
    overlay.width(pageWidth());
    // fadeTo第一个参数为速度，第二个为透明度
    // 多重方式控制透明度，保证兼容性，但也带来修改麻烦的问题
    overlay.fadeTo(200, 0.5);

    document.getElementById(panelId).style.display = 'block';
    adjust(panelId);

}

/* 隐藏覆盖层 */
function hideOverlay(panelId) {
    overlay.fadeOut(200);
    document.getElementById(panelId).style.display = 'none';
}

/* 当前页面高度 */
function pageHeight() {
    return document.body.scrollHeight;
}

/* 当前页面宽度 */
function pageWidth() {
    return document.body.scrollWidth;
}

/* 定位到页面中心 */
function adjust(id) {
    var w = $(id).width();
    var h = $(id).height();

    var t = scrollY() + (windowHeight()/2) - (h/2);
    if(t < 0) t = 0;

    var l = scrollX() + (windowWidth()/2) - (w/2);
    if(l < 0) l = 0;

    $(id).css({left: l+'px', top: t+'px'});
}

//浏览器视口的高度
function windowHeight() {
    var de = document.documentElement;

    return self.innerHeight || (de && de.clientHeight) || document.body.clientHeight;
}

//浏览器视口的宽度
function windowWidth() {
    var de = document.documentElement;

    return self.innerWidth || (de && de.clientWidth) || document.body.clientWidth
}

/* 浏览器垂直滚动位置 */
function scrollY() {
    var de = document.documentElement;

    return self.pageYOffset || (de && de.scrollTop) || document.body.scrollTop;
}

/* 浏览器水平滚动位置 */
function scrollX() {
    var de = document.documentElement;

    return self.pageXOffset || (de && de.scrollLeft) || document.body.scrollLeft;
}
