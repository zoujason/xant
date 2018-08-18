//缩略图 删除图片
$("#Avatar").mouseenter(
    function () {
        $("#DeleteAvatar").css("display","inline-block");
    });
$("#DeleteAvatar").mouseleave(
    function () {
        $("#DeleteAvatar").hide();
    });
$("#DeleteAvatar").click(function(){
    var id = $("#aId").val();
    if (confirm("确定删除吗")==true){
        $.get("/xmt/press/articles/delelte_avatar",{id:id},function (data) {
            if(data==400){
                $("#Avatar").hide();
            }
        })
    }
})
//图片集 删除图片

function showPic(e){
    var ele=document.getElementById('AddPictureFile').files[0];
    var createObjectURL = function(blob){
        return window[window.webkitURL ? 'webkitURL' : 'URL']['createObjectURL'](blob);
    };
    var newimgdata = createObjectURL(ele);

    var id = $("#aId").val();
    var formData=new FormData();
    formData.append('aid',id);
    formData.append('pic',ele);
    $.ajax({
        url: "/xmt/press/articles/add_pic",
        type: 'post',
        data: formData,
        async: false,
        cache: false,
        contentType: false,
        processData: false,
        success: function (data) {
            if(data!=401){
                $('.pictures').last().parent().after('<div class="pictures news"><img src="'+newimgdata+'" class="pictures" width="50" height="50" /><a href="javascript:void(0)" class="deletePic" id="'+data+'"><i class="fa fa-trash fa-w-18"></i></a></div>');
            }else{
                alert("上传失败");
            }

        },
        error: function (returndata) {
            alert("上传失败");
        }
    });
}
$("#PictureGroup").on("mouseenter",".pictures",function(){
    $(this).next('.deletePic').css("display","inline-block");
})

$("#PictureGroup").on('mouseleave',".deletePic",function () {
    $(this).hide();
})
$("#PictureGroup").on('click','.deletePic',function(){
    var id = $("#aId").val();
    var $this = $(this);
    var pic_id = $this.attr('id');
    if (confirm("确定删除吗")==true){
        $.get("/xmt/press/articles/delete_pic",{id:id,pic_id:pic_id},function (data) {
            if(data==400){
                $this.prev('.pictures').hide();
            }

        })
    }
})


