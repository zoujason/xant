
function shengchengqi(obj) {
    if ($("#xmt_press_snippet_tag_type").val() == 'news_list') {
        $(".scq_list").css("display", "block");
        $(".scq_content").css("display", "none");
    }
    if ($("#xmt_press_snippet_tag_type").val() == 'news_content') {
        $(".scq_list").css("display", "none");
        $(".scq_content").css("display", "block");
    }
    if ($("#xmt_press_snippet_tag_type").val() == '') {
        $(".scq_list").css("display", "none");
        $(".scq_content").css("display", "none");
    }
}

$("#rcmd").change(function(){
    $("#dengji").show();
});


function ceratebiaoqian() {
    var html = '';
    var article_html = "";

    if ($("#xmt_press_snippet_tag_type").val() == 'news_list') {
        var space = "  ";
        var target = 'target="' + $("#target").val() + '"';
        var title = space + '<span><a href="<!= article.url !>" title="<!= article.attr(:title) !>" ' + target + ' ><!= article.attr(:title) !></a></span>\n';
        var image = "";
        var info = "";
        var datetype = "";
        var html_class = 'class = "article_list"';
        var sort = $("#sort").val();
        var level_type = $("#rcmd").val();
        var level = $("#dengji").val();
        var count = $("#pagenum").val();

        // 标签题头开始
        var tag_parent = $("#channel").val();
        if (tag_parent == "") {
            tag_parent = "@page.id";
        }
        var tag_hjp_start = "<! hlp_list_article('" + tag_parent + "', " ;
        var options = "{";
        if(sort != null && sort != ""){
            options += "sort:'" + sort + "', ";
        }
        if(level_type == "rcmd"){
            options += "rcmd_level:" + level + ", ";
        }else if(level_type == "head"){
            options += "headline_level:" + level + ", ";
        }
        if(count != 0){
            options += "count:" + count + ", ";
        }
        options += "}";

        var tag_foreach = ").each do |article| !>";
        var tag_hlp_head = tag_hjp_start + options + tag_foreach;
        //中间HTML标签开始

        $("input[name='pc']").each(function () {
            if ($(this).is(":checked")) {
                html_class = 'class = "' + $(this).val() + '"';
            }
        });

        if ($("input[name='image']").is(":checked")) {
            image = space + '<span><a href="<!= article.url !>" title="<!= article.attr(:title) !>" ' + target + ' ><!= image_tag(article.attr("avatar.url",{default: "xmtcms.jpg"}),alt:<!= article.attr(:title) !>)!></a></span>\n';
        }
        if ($("input[name='info']").is(":checked")) {
            info = space + '<span><a href="<!= article.url !>" title="<!= article.attr(:title) !>" ' + target + ' ><!= article.attr(:desc) !></a></span>\n';
        }
        if ($("input[name='date']").is(":checked")) {
            datetype = space + '<span><!= article.attr(:published_at,{format: "'+ $("#datetype").val().toString() +'"}) !></span>\n';
        }
        html += '<div ' + html_class + '>\n' + image + title + info + datetype + '</div>\n';
        //中间HTML标签结束

        var tag_hlp_end = "<! end !>";
        // 标签题头结束
        article_html = tag_hlp_head + '\n' + html + tag_hlp_end + '\n';
    }
    if ($("#xmt_press_snippet_tag_type").val() == 'news_content') {
        var share='';
        var js_share='';
        var datetype = '';
        var subtit = '';
        var author = '';
        var source = '';

        if ($("input[name='source']").is(":checked")) {
            source = '<span class="content_source">来源：<!= @page.attr(:source, {default: "站内信息"})!></span>\n';
        }
        if ($("input[name='subtit']").is(":checked")) {
            subtit =  '<span class="content_subtit"><!= @page.attr(:subtitle) !></span>\n';
        }
        if ($("input[name='author']").is(":checked")) {
            $("#default_author").show();
            author ='<span class="content_author">作者：<!= @page.attr(:author, {default: "站内信息"})!></span>\n';
        }
        if ($("input[name='content_date']").is(":checked")) {
            datetype = '<span class="content_date">时间：<!= @page.attr(:published_at, {format: "'+ $("#content_datetype").val() +'"}) !></span>\n';
        }




        var html_class = 'class = "article_content"';
        $("input[name='pc_content']").each(function () {
            if ($(this).is(":checked")) {
                html_class = 'class = "' + $(this).val() + '"';
            }
        });

        if ($("input[name='share']").is(":checked")) {

            share = '<div class="bshare-custom icon-medium-plus">\n' +
                '        <a title="分享到QQ空间" class="bshare-qzone"></a>\n' +
                '        <a title="分享到新浪微博" class="bshare-sinaminiblog"></a>\n' +
                '        <a title="分享到人人网" class="bshare-renren"></a>\n' +
                '        <a title="分享到腾讯微博" class="bshare-qqmb"></a>\n' +
                '        <a title="分享到网易微博" class="bshare-neteasemb"></a>\n' +
                '        <a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a>\n' +
                '        <span class="BSHARE_COUNT bshare-share-count"></span>\n' +
                '</div>\n';
            js_share =  '<script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/button.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"><\/script>\n' +
                '<a class="bshareDiv" onclick="javascript:return false;"></a>\n' +
                '<script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"><\/script>\n';
        }


        html += '<div '+html_class+'>\n' +
            '<div class="content_titile">\n' +
            '<h3><!= @page.attr(:title) !></h3>\n' +
            subtit+
            '<div class="content_attr">\n' +
            datetype+
            author +
            source +
            ' </div>\n' +
            '</div>\n' +
            ' <div class="conetnt_cont">\n' +
            '<!= @page.attr(:cont,{html_safe: true}) !>\n'+
            share+js_share +
            '</div>\n'+
            '</div>\n';

        article_html = html;
    }
    editor.setValue(article_html.replace(/!/g, "%"));
}

