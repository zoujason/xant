function add_question(typ){
    var order = 1;
    if ($("#questions_area .order_num").last().text()){
        order=parseInt($("#questions_area .order_num").length)+1;
    }
    if(typ == 'Xmt::Test::BinaryChoice'){
        $("#Question_add .question_btns").find('.add_answer').hide()
    }else{
        $("#Question_add .question_btns").find('.add_answer').show()
    }

    $("#add_button").before("<div class='form-group question_item edit_status'>"+"<input type='hidden' class='question_id' name='xmt_test_paper[questions][][id]' /><input type='hidden' class='question_type' name='xmt_test_paper[questions][][type]' value='"+typ+"' />"+"<input type='hidden' class='question_seq' name='xmt_test_paper[questions][][seq]' value='"+order+"' />"+"<label class='col-sm-1 control-label order_num' >"+order+".</label>"+$("#Question_add").html()+"</div>");


}

//试题内容输入同步
$("#questions_area").on("keyup",".question_edit .edit_content",function(){

    $(this).parents(".question_edit").siblings(".question_view").find('.question_content').text($(this).val()+"?");
});
//鼠标进入区域
$("#questions_area").on("mouseenter",".question_item",function(){
    var self = $(this);
    var btns = self.find(".question_btns");
    self.addClass('hover_status');
    btns.show();
});
//鼠标离开区域
$("#questions_area").on("mouseleave",".question_item",function(){
    var self = $(this);
    var btns = self.find(".question_btns");
    if(btns.find(".edit").text()=='编辑'){
        if(self.hasClass('hover_status')){
            self.removeClass('hover_status');
        }
        btns.hide();
    }else if(btns.find(".edit").length==0){
        if(self.hasClass('hover_status')){
            self.removeClass('hover_status');
        }
        if(self.hasClass('edit_status')){
            self.removeClass('edit_status');
        }
        btns.hide();
    }
});

//编辑/完成按钮切换
$("#questions_area").on("click",".question_btns .edit",function(){
    var self = $(this);
    var btns = self.parents(".question_btns");
    var view = btns.siblings(".question_view");
    var edit = btns.siblings(".question_edit");
    if(self.text()=='完成'){
        if(validate_item(self)){
            self.text('编辑')
            if(view.text()=='?'){
                view.text('你的试题标题')
            }
            edit.hide();
            btns.hide();
            self.parents(".question_item").removeClass('edit_status');
        }
    }else{
        self.text('完成');
        if(self.parents(".question_item").hasClass('hover_status')){
            self.parents(".question_item").removeClass('hover_status');
        }
        self.parents(".question_item").addClass('edit_status');
        edit.show();
    }
});

//试题删除
$("#questions_area").on("click",".question_btns .delete",function(){
    $(this).parents(".question_item").andSelf().remove();
});

//新增选项
$("#questions_area").on("click",".question_btns .add_answer",function(){
    var self = $(this);
    var btns = self.parents(".question_btns");
    var view = btns.siblings(".question_view");
    var edit = btns.siblings(".question_edit");
    var last_index = (edit.find(".answer_item").length);
    edit.find(".answer_item").last().after("<div class='col-sm-10 col-lg-offset-2 answer_item'>" +
        "<div class='col-sm-8'>" +
        "<div class='checkbox'>" +
        "<input type='checkbox' class='answer_righted' style='margin-top: 10px;' name='xmt_test_paper[questions][][answers]["+last_index+"][righted]' value='true'/>" +
        "<input name='xmt_test_paper[questions][][answers]["+last_index+"][title]' class='form-control answer_content' placeholder='选项内容' value='选项"+(last_index+1)+"' />" +
        "</div>" +
        "</div>" +
        "<div class='col-sm-3'>" +
        "<div class='input-group' style='margin-top: 6px;'>" +
        "<input type='text' name='xmt_test_paper[questions][][answers]["+last_index+"][score]' class='form-control score' placeholder='选项分值' />" +
        "<div class='input-group-addon'>分</div>" +
        "</div>" +
        "</div>" +
        "<div class='col-sm-1'>" +
        "<a class='btn btn-danger btn-xs delete_answer' href='javascript:void(0)'  style='margin-top: 11px;'><i class='fa fa-minus'></i></a>"+
        "</div>"+
        "</div>");
    view.find('.question_answers li').last().after(" <li><input type='radio' readonly><span>选项"+(last_index+1)+"</span></li>")

});

//答案删除
$("#questions_area").on("click",".question_edit .delete_answer",function(){
    var self = $(this)
    var edit = self.parents(".question_edit");
    var index = edit.find(".answer_item").index(self.parents('.answer_item'));
    self.parents(".answer_item").remove();
    edit.siblings(".question_view").find('.question_answers li').eq(index).remove();

});

//答案内容同步
$("#questions_area").on("keyup",".question_edit .answer_content",function(){
    var self = $(this)
    var edit = self.parents(".question_edit");
    var index = edit.find(".answer_item").index(self.parents('.answer_item'));
    edit.siblings(".question_view").find('.question_answers li').eq(index).html("<input type='radio'><span>"+self.val()+"</span>");
});
// 单选righted
$("#questions_area").on("click",".question_edit .answer_righted",function(){
    var self = $(this);
    var typ = self.parents(".question_item").find(".question_type").val();
    var question_val = self.parents('.question_item').find('.question_score').val()
    if(typ!='Xmt::Test::MultipleChoice'){
        if(self.is(':checked')){
            self.parents('.question_edit').find(".answer_righted").not(self).attr("checked",false);

            self.parents('.answer_item').siblings().find('.score').val(0)
            self.parents(".answer_item").find('.score').val(question_val);
        }
    }else{
        if(question_val){
            var answer_num = self.parents('.question_item').find(".answer_righted:checked").length;if(!self.is(':checked')){
                self.parents('.answer_item').find('.score').val(0)
            }
            self.parents('.answer_item').siblings().andSelf().find('.score').val(0)
            self.parents('.question_item').find(".answer_righted:checked").parents(".answer_item").find('.score').val((question_val/answer_num).toFixed(2));
        }

    }


});

//$("#questions_area").on("click",".question_btns .select_question",function(){
//    var index = $(this).parents(".question_item").index()
//    $("#Question_list").find("input[name=question_index]").val(index)
//});
// 题库添加按钮
$("#Question_list").on("click",".question_item_add",function(){
    var self = $(this);
    var order = 1;
    if ($("#questions_area .order_num").last().text()){
        order=parseInt($("#questions_area .order_num").last().text())+1;
    }

    var question_id = self.parents(".question_library_item").find("input[name=select_question_id]").val();
    var question_type = self.parents(".question_library_item").find("input[name=select_question_type]").val();
    var content = self.parents(".question_library_item").find(".select_question_content").text();
    var answers = self.parents(".question_library_item").find(".select_answers").html();
    var select_question_html = '<div class="col-sm-10 question_view">' +
        '<h4 class="question_content">'+content+'</h4>' +
        '<ul class="question_answers">' +answers+
        '</ul>' +
        '</div>' +
        '<div class="question_btns col-sm-10 col-lg-offset-2">' +
        '<a class="btn btn-danger delete" href="javascript:void(0)" role="button">删除</a>' +
        '</div>';
    $("#add_button").before("<div class='form-group question_item edit_status'>"+"<input type='hidden' class='question_id' name='xmt_test_paper[questions][][id]' value='"+question_id+"' />"+"<input type='hidden' class='question_type' name='xmt_test_paper[questions][][type]' value='"+question_type+"' />"+"<label class='col-sm-1 control-label order_num' >"+order+".</label>"+select_question_html+"</div>")
    $("#myQuestions").modal('hide');
});

// 题库复制按钮
$("#Question_list").on("click",".question_item_copy",function(){
    var self = $(this);
    var order = 1;
    if ($("#questions_area .order_num").last().text()){
        order=parseInt($("#questions_area .order_num").last().text())+1;
    }
    var question_add = $("#Question_add").html();
    console.log(question_add);
    var question_type = self.parents(".question_library_item").find("input[name=select_question_type]").val();
    $("#add_button").before("<div class='form-group question_item edit_status'>"+"<input type='hidden' class='question_id' name='xmt_test_paper[questions][][id]' /><input type='hidden' class='question_type' name='xmt_test_paper[questions][][type]' value='"+question_type+"' />"+"<label class='col-sm-1 control-label order_num' >"+order+".</label>"+question_add+"</div>");
    $("#myQuestions").modal('hide');
});
// 试题筛选
var page = 1;
$("#filter").on("click",".select_question_next",function(){
    $("#filter_form").find("input[name=select_question_page]").val(page++);
    new_question_list()
});
$("#filter").on("change",".filter_category",function(){
    page = 1;
    $("#filter_form").find("input[name=select_question_page]").val(0);
    new_question_list();
});
$("#filter").on("change",".filter_typ",function(){
    page = 1;
    $("#filter_form").find("input[name=select_question_page]").val(0);
    new_question_list();
});
// 试题局部更新
function new_question_list(){
    $.ajax({
        url : "ajax_next",
        type : "POST",
        data : $("#filter_form").serialize(),
        success: function(data){
            $("#Question_list").empty()
            if(data.length>0){
                var str = "";
                for(ii=0;ii<data.length;ii++){
                    str += " <div class='row question_library_item' style='margin: 0 15px;'>" +
                        "<input type='hidden' name='select_question_id' value='"+data[ii].id+"'>" +
                        "<input type='hidden' name='select_question_type' value='"+data[ii].typ+"'>" +
                        "<div class='col-md-8'>" +
                        "<p><span  class='select_question_content'>"+data[ii].content+"</span><span>("+data[ii].score+"分)</span></p>" +
                        "<ul class='select_answers'>";
                    for(jj=0;jj<data[ii].answers.length;jj++){
                        str += " <li><input type='radio'><span>"+data[ii].answers[jj].answer.title+"</span></li>"
                    }
                    str += "</ul>" +
                        "</div>" +
                        "<div class='col-md-4 text-right'><a class='btn btn-warning question_item_add hide' href='javascript:void(0)' role='button' style='margin-top: 20%;'>添加</a></div>" +
                        "</div>"
                }
                $("#Question_list").html(str)
                if(page>data[0].page){
                    page=0;
                }
            }else{
                $("#Question_list").html("<div class='text-center'>暂无数据</div>")
            }

        }
    })
}

$("#Question_list").on("mouseenter",".question_library_item",function(){
    $(this).css({"border":"1px solid #FDA43E","padding":"8px"});
    $(this).find('.question_item_add').removeClass("hide");
    $(this).find('.question_item_copy').removeClass("hide");
});
$("#Question_list").on("mouseleave",".question_library_item",function(){
    $(this).css({"border":"none","padding":0});
    $(this).find('.question_item_add').addClass("hide");
    $(this).find('.question_item_copy').addClass("hide");
});

var question_validate_flag = false;
function validate_item(obj){
    var btns = obj.parents(".question_btns");
    var edit = btns.siblings(".question_edit");
    if(edit.find(".edit_content").val()==''){
        question_validate_flag = false;
        edit.find(".item_error").html("请填写试题内容");
        return false;
    }
    if(edit.find(".question_score").val()==''){
        question_validate_flag = false;
        edit.find(".item_error").html("请填写试题分值");
        return false;
    }
    if(edit.find("input:checkbox:checked").length<1){
        question_validate_flag = false;
        edit.find(".item_error").html("请设置答案选项");
        return false;
    }

    question_validate_flag = true;
    edit.find(".item_error").empty();
    return true;


}
function validate(){

    var rule_single = $("#questions_area").find("input[name=exam_single]").val()!=undefined ? $("#questions_area").find("input[name=exam_single]").val() : 0;
    var rule_multiple = $("#questions_area").find("input[name=exam_multiple]").val()!=undefined ? $("#questions_area").find("input[name=exam_multiple]").val() : 0;
    var rule_binary =  $("#questions_area").find("input[name=exam_binary]").val()!=undefined ? $("#questions_area").find("input[name=exam_binary]").val() : 0;
    single_num = $("#questions_area").find("input[value='Xmt::Test::SingleChoice']").length;
    multiple_num = $("#questions_area").find("input[value='Xmt::Test::MultipleChoice']").length;
    binary_num = $("#questions_area").find("input[value='Xmt::Test::BinaryChoice']").length;
    // console.log(single_num+','+multiple_num+","+binary_num);
    if((single_num+multiple_num+binary_num)==0){
        $("#questions_area").find(".error").html("请添加试题");
        return false;
    }else if(!question_validate_flag){
        $("#questions_area").find(".error").html("请完成未完成选项");
        return false;
    }else if( (single_num!=rule_single) || (multiple_num!=rule_multiple) || (binary_num!=rule_binary) ){
        var err_str = '';
        if(rule_single!=0){
            err_str += '单选题:'+rule_single+'道';
        }
        if(rule_multiple!=0){
            err_str += '多选题:'+rule_multiple+'道';
        }
        if(rule_binary!=0){
            err_str += '判断题:'+rule_binary+'道';
        }
        $("#questions_area").find(".error").html("根据考试规则请创建:"+err_str);
        console.log(single_num+','+rule_single);
        console.log(multiple_num+','+rule_multiple);
        console.log(binary_num+','+rule_binary);
        return false;
    }else{
        $("#questions_area").find(".error").empty();
        return true;
    }


}

var que=document.getElementById('questions_area')
Sortable.create(que, {
    draggable: ".question_item",
    animation: 150,
    onEnd: function(evt){ //拖拽完毕之后发生该事件
        var $que = $(que);
        var que_item = $que.find('.question_item')
        for(var i=0, len=que_item.length; i<len; i++){
            que_item.eq(i).find('.question_seq').val(i+1);
        }
    }
});


