var flag=true; //开关按钮
function show_menu(){
    var menu1 = document.getElementById("cart_content");
    if(flag){
        menu1.style.display="block";
        flag = false;
    }else{
        menu1.style.display="none";
        flag = true;
    }
}

function show_menu1() {
    var menu1 = document.getElementById("cart_content");
    menu1.style.display = "none";
    flag = true; //鼠标离开时将flag默认回true
}

function txtSearch()
{
    //遍历移除b标签，防止第二次搜索bug
    $(".changestyle").each(function()
    {
        var xx=$(this).html();
        $(this).replaceWith(xx);
    });
    //整个客户信息div
    var str=$("#img_content").html();
    //文本输入框
    var txt=$("#txtSearch").val();
    //不为空
    if($.trim(txt)!=="")
    {
        //定义b标签样式红色加粗
        var re="<b class='changestyle'>"+txt+"</b>";
        //替换搜索相关的所有内容
        var nn=str.replace( new RegExp(txt,"gm"),re);
        //赋值
        // document.getElementById("divMain").innerHTML=nn;
        $("#img_content").html(nn);
        //显示搜索内容相关的div
        $(".card").hide().filter(":contains('"+txt+"')").show();
    }
    else
    {
        $(".card").show();
    }
}

