$("#SelectAll").click(function(){
    is_checked = $(this).is(':checked');
    if(is_checked){
        $(".select").prop('checked',true);
    }else{
        $(".select").prop('checked',false);
    }
})

$("#BatchDelete").click(function(){
    count = $('input[type=checkbox]:checked').length;
    if(count>0){
        var ids = [];
        $.each($('.select:checked'),function(e){
            ids[e] = $(this).val();
        });
        $.post("/xmt/press/articles/destroy_batch",{ids:ids},function(data){
            if(data==200){
                for(var ii=0;ii<ids.length;ii++){
                    $("#tr_"+ids[ii]).hide('slow');
                }
            }else{
                alert("删除失败")
            }
        },'text')
    }else{
        alert('请选择删除对象');
    }

})