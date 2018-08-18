function StringBuffer() {
    this.__strings__ = new Array();
}

StringBuffer.prototype.append = function (str) {
    this.__strings__.push(str);
    return this;
};

StringBuffer.prototype.toString = function () {
    return this.__strings__.join("");
};

var indent = function(e){
    var deepth = e.attr("dep");
    e.children('td').eq(0).css("padding-left" , deepth -1+"em");

};

var addTreeHandleEl1 = function(el , e){
    var handle = "<i class='tree-table-handle' in='0'></i>";
    var sidS = new StringBuffer();
    var pidS = new StringBuffer();
    var sid , pid;

    el.find('tbody').children("tr").each(function(){


        var _this = $(this);
        sidS.append(_this.attr('sid')+",");
        sid = sidS.toString();

        pidS.append(_this.attr('pid')+",");
        pid = pidS.toString();


    });

    el.find('tbody').children("tr").each(function(){
        var s = $(this).attr("sid");
        var deepth = $(this).attr("dep") ;
        if(pid.indexOf(s) > 0){
            $(this).children("td").eq(0).prepend(handle);
        }else if(pid.indexOf(s) == -1){
            $(this).children('td').eq(0).css("padding-left" , deepth +"em");
        }
    })
};

var treeTableHandleToggle = function(el){
    var flag = 0;

    var tds = $(".tree-table-handle");
    var indexold=-1;
    tds.each(function(){
        var td = $(this);
        var index= $(this).parent("td").parent("tr").index();
        td.click(function(){
            if(index==indexold){
                flag++;
                if(flag % 2 > 0){
                    $(this).removeClass("close-tree-item");
                }else {
                    $(this).addClass("close-tree-item");
                }
            }else if(indexold==-1){
                flag =0;
                if($(this).hasClass("close-tree-item")){
                    $(this).removeClass("close-tree-item");
                }else{
                    $(this).addClass("close-tree-item");
                }
            }else{
                flag =0;
                if($(this).hasClass("close-tree-item")){
                    $(this).removeClass("close-tree-item");
                }else{
                    $(this).addClass("close-tree-item");
                }
            }
            indexold=index;

            var _this = $(this);
            var myid = $(this).parents('tr').attr('sid');

            el.find('tbody').children("tr").each(function(item){
                var p = $(this).attr('pid');
                var exp = new RegExp("^" + myid  , "g");
                if(exp.test(p)){

                    if(_this.hasClass("close-tree-item")){
                        $(this).hide();
                        $(this).children("td").eq(0).children(".tree-table-handle").addClass("close-tree-item");
                    }else{
                        $(this).show();
                        $(this).children("td").eq(0).children(".tree-table-handle").removeClass("close-tree-item");
                    }

                }
            });
        });
    });
};

var choiceChild = function (e ,el) {
    $(e).change(function () {
        var myid = $(this).parents('tr').attr('sid');
        var m = $(this);
        el.find('tbody').children("tr").each(function(){
            var p = $(this).attr('pid');
            var exp = new RegExp("^" + myid  , "g");
            if(exp.test(p)){
                if(m.is(':checked')){
                    $(this).find(e).prop("checked" , true);
                }else if(m.not(':checked')){
                    $(this).find(e).prop("checked" , false);
                }
            }
        });
    });
};

var choiceParent = function (e ,el) {
    $(e).change(function () {
        var pid = $(this).parents("tr").attr("pid");
        var _this = $(this);
        el.find('tbody').children("tr").each(function(){
            var sid = $(this).attr("sid");
            var exp = new RegExp("^" + sid  , "g");
            if(exp.test(pid)){
                if(_this.is(':checked')){
                    $(this).find(e).prop("checked" , true);
                }else if(_this.not(':checked')){
                    $(this).find(e).prop("checked" , false);
                }
            }
        });
    })
};

var inverseElection = function(e , el){
    $(e).change(function(){
        var p = $(this).parents("tr").attr("pid");
        var s = $(this).parents("tr").attr("sid");
        el.find('tbody').children("tr").each(function(){
            var p1 = $(this).attr("pid");
            var s1 = $(this).attr("sid");
            var exp0 = new RegExp("^" + s1  , "g");
            if(exp0.test(p)){
                $(this).find(e).prop("checked" , true);
            }
            if(p1 == p && s1 !== s && $(this).find(e).is(":checked")){
            }
        });
    });
};

var treeTable = function (el , treeview , article , edit ) {

    var num=0;
    el.find('tbody').children("tr").each(function () {
        var $this= $(this);
        var cur_dep = $this.attr("dep");
        if(cur_dep==1){
            var order = num++;
        }else{
            var order = $this.prevUntil("tr[dep="+(cur_dep-1)+"]").filter("tr[dep="+cur_dep+"]").length;
        }

        $(this).attr("order",(order+1));
    });

    var index = 1;
    el.find('tbody').children("tr").each(function(item){

        var cur = $(this).attr("order");
        var pcur = "";
        for(var i=$(this).attr("dep") - 1 ; i>=1 ;i--){
            var o = $(this).prevAll("tr[dep="+i+"]").eq(0).attr("order");
            cur = o+"-"+cur;
            pcur = o+"-"+pcur;
            var reg=/-$/gi;
            pcur=pcur.replace(reg,"");
            $(this).attr("sid" , cur);
            $(this).attr("pid" , pcur);
        }
        if($(this).attr("dep") == "1"){
            $(this).attr("sid" , index++);
            $(this).attr("pid" , "0");
        }
        var _this = $(this);
        indent(_this);
    });

    addTreeHandleEl1(el , $(this));
    treeTableHandleToggle(el);

    choiceChild(treeview ,el);
    choiceChild(article ,el);
    choiceChild(edit ,el);

    choiceParent(treeview , el);
    choiceParent(article , el);
    choiceParent(edit , el);

    inverseElection(treeview , el);
    inverseElection(article , el);
    inverseElection(edit , el);
};