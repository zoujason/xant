function question1(){

    switch ($("#ddadmin-question-type").val()){
        case "Xmt::Test::SingleChoice":
            var type="radio";
            break;
        case "Xmt::Test::MultipleChoice":
            type="multiselected";
            break;
        case "Xmt::Test::BinaryChoice":
            type="judge";
            break;
        default:
            type='Xmt::Test::SingleChoice';
    }

    $("#ddadmin-question-type").change(function () {
        if($("#ddadmin-question-type").val()=="Xmt::Test::SingleChoice"){
            type="radio";
        }else if($("#ddadmin-question-type").val()=="Xmt::Test::MultipleChoice"){
            type="multiselected";
        }else if($("#ddadmin-question-type").val()=="Xmt::Test::BinaryChoice"){
            type="judge";
            $("#numbeOfType").val(2);
        }
    });
    function addelement(etype , n) {
        $(".question-item-ddadmin").empty();

        if(etype == "radio"){
            for(var j=0;j<n;j++){
                // $(".question-item-ddadmin").append(radioWrap);
                $(".question-item-ddadmin").append(
                    "<div class='form-group row radio'>" +
                    "<div class='col-sm-9'>" +
                    "<div class='checkbox'>" +
                    "<input type='checkbox' style='margin-top: 13px' class='square-teal'  name='xmt_test_question[answers]["+j+"][righted]' value='true' onclick='single($(this))'/>" +
                    "<textarea name='xmt_test_question[answers]["+j+"][title]' class='form-control' style='height:3em' required='required' >" +
                    "</textarea>" +
                    "</div>" +
                    "</div>" +
                    "<div class='col-sm-2'>" +
                    "<input name='xmt_test_question[answers]["+j+"][score]' class='form-control  score' placeholder='分值' style='margin-top: 11px'/>" +
                    "</div>" +
                    "</div>"
                )
            }

        }
        if(etype == "judge"){
            for(var z=0;z<2;z++){
                $(".question-item-ddadmin").append(
                    "<div class='form-group row radio'>" +
                    "<div class='col-sm-9'>" +
                    "<div class='checkbox'>" +
                    "<input type='checkbox' style='margin-top: 13px' class='square-teal'  name='xmt_test_question[answers]["+z+"][righted]' value='true' onclick='single($(this))'/>" +
                    "<textarea name='xmt_test_question[answers]["+z+"][title]' class='form-control' style='height:3em' required='required' >" +
                    "</textarea>" +
                    "</div>" +
                    "</div>" +
                    "<div class='col-sm-2'>" +
                    "<input name='xmt_test_question[answers]["+z+"][score]' class='form-control score' placeholder='分值' style='margin-top: 11px'/>" +
                    "</div>" +
                    "</div>"
                );
            }
        }
        if(etype == "multiselected"){
            for(var i=0;i<n;i++){
                $(".question-item-ddadmin").append(
                    "<div class='form-group row answer_item'>" +
                    "<div class='col-sm-9'>" +
                    "<div class='checkbox'>" +
                    "<input type='checkbox' style='margin-top: 13px' class='square-teal'  name='xmt_test_question[answers]["+i+"][righted]' value='true' onclick='multiple_choice($(this))'/>" +
                    "<textarea name='xmt_test_question[answers]["+i+"][title]' class='form-control' style='height:3em' required='required'></textarea>" +
                    "</div>" +
                    "</div>" +
                    "<div class='col-sm-2'>" +
                    "<input name='xmt_test_question[answers]["+i+"][score]' class='form-control score' placeholder='分值' style='margin-top: 11px'/>" +
                    "</div>" +
                    "</div>");
            }
        }

    }

    var answers_num = $("#numbeOfType").val();
    if ((answers_num>0) && (type != '')){
        $("#numbeOfType").val(answers_num);
    }
    $("#ddadmin-question-handle").click(function () {
        var num = $("#numbeOfType").val();
        if(type==''){
            alert("请选择题目类型")
        }
        if(num==""){
            alert("请输入选项个数")
        }
        addelement(type , num);
    })



}
$(function () {
    question1();

});
function single(self){
    if(self.is(':checked')){
        $(".question-item-ddadmin input:checkbox").not(self).attr("checked",false);

        $(".radio").find('.score').val(0.0)
        self.parents(".radio").find('.score').val($("#question_score").val());
    }

}

function multiple_choice(self){
    var question_val = $("#question_score").val();
    if(question_val){
       var answer_num = $(".question-item-ddadmin").find("input[type=checkbox]:checked").length;
       console.log(answer_num);
        $(".question-item-ddadmin").find(".score").val(0);
        $(".question-item-ddadmin").find("input[type=checkbox]:checked").parents(".answer_item").find(".score").val((question_val/answer_num).toFixed(2));
    }

}

function delete_question(self){
    self.parents('.question_item').remove()
}
function plus(self){
    self.parent("div").append("<div class='col-sm-10 questionsSet'>"+$(".questionsSet").html()+" <a class='btn btn-danger btn-sm add-row' href='javascript:void(0)' onclick='delete_rule($(this))'><i class='fa fa-minus'></i></a>"+"</div>")
}

function delete_rule(self){
    self.parent(".questionsSet").remove()
}


