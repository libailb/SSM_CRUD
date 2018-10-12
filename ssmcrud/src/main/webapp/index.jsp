<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"  %>
<%--引入标签库--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<%--员工添加的模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                            <label  class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@outlook.com">
                                <span class="help-block"></span>
                            </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <%--单选框--%>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--员工修改的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@outlook.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <%--单选框--%>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 搭建显示页面 用bootstrap搭建-->
<div class="container">
    <%--第一行标题 每一行class="row"--%>
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-9">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox"  id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- 分页导航条信息 -->
        <div class="col-md-6" id="page_nav_area"></div>
    </div>

</div>
<script type="text/javascript">
    var totalRecord;
    var currentpage;
    //1.页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function(){
        to_page(1)
    });
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result)
                //3.解析并显示分页条信息
                bulid_page_nav(result)
            }
        });
    }
    function build_emps_table(result){
        //清空表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function(index,item){
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id",item.empId);
            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("del-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //var delBtn =
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }
    function build_page_info(result){
        $("#page_info_area").empty();
           $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"
               +result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"条记录");
           totalRecord=result.extend.pageInfo.total;
           currentpage=result.extend.pageInfo.pageNum;
    }
    //构建分页导航条
    function bulid_page_nav(result) {
        $("#page_nav_area").empty();
        var ul=$("<ul></ul>").addClass("pagination")
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }
        //为元素添加翻页事件
        firstPageLi.click(function () {
            to_page(1);
        });
        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum-1);
        });
        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage==false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }
        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum +1);
        });
        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        });

        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //去除页码号
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum==item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            //遍历添加页码提示
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        //吧ul加入nav
        var navEle=$("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //完整重置表单方法
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //重置模态框
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表
        getDepts("#dept_add_select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });
    function getDepts(ele) {
        //清空下拉列表
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
               //显示部门信息在下拉列表中
                $.each(result.extend.depts,function () {
                    var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }
    //校验表单数据
    function validate_add_form() {
        //1.拿到校验数据，使用正则表达式 校验名字
       var empName= $("#empName_add_input").val();
        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //清空元素之前的样式
            show_validate_msg("#empName_add_input","error","用户名有误");
            return false;
        }else{
            show_validate_msg("#empName_add_input","success","");
        };
        //校验邮箱
        var email=$("#email_add_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,8})$/;
        if(!regEmail.test(email)){
            //清空这个元素之前的样式
            show_validate_msg("#email_add_input","error","邮箱格式有误");
            return false;
        }else{
            show_validate_msg("#email_add_input","success","");
        };
        return true;
    }
    //对姓名和邮箱规范的校验
    function show_validate_msg(ele,status,msg) {
        //清除当前元素校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if(status=="success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if(status=="error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        var empName=this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#empName_add_input").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va-msg);
                    $("#empName_add_input").attr("ajax-va","error");
                }
            }
        });
    });


    //点击保存，保存员工
    $("#emp_save_btn").click(function () {
        //1.将模态框中填写的数据进行保存
        //进行校验
        if(!validate_add_form()){
          return false;
        };
        //若姓名重复，则不往下执行保存操作
        if($(this).attr("ajax-va")=="error"){
            return false;
        };
        //2.发送ajax请求保存员工
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            //提取模态框中数据
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                //判断返回结果中的状态码
                if(result.code==100){
                //保存成功后，关闭模态框
                $("#empAddModal").modal('hide');
                // 并来到最后一页,设置总记录数肯定大于总页数
               to_page(totalRecord);
                }
               else{
                    //有哪个字段的错误信息就显示哪段的
                    if(undefined !=result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined !=result.extend.errorFields.empName){
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }
            }
        });
    });
    //绑定删除按钮 单个删除
    $(document).on("click",".delete_btn",function () {
        //1.弹出是否确认删除对话框
       var empName=$(this).parents("tr").find("td:eq(2)").text();
       if(confirm("确认删除【"+empName+"】吗？")){
           //确认发送ajax请求
           $.ajax({
               url:"${APP_PATH}/emp/"+$(this).attr("del-id"),
               type:"DELETE",
               success:function (result) {
                   to_page(currentpage);
               }
           });
       }
    });
    //绑定编辑按钮
    $(document).on("click",".edit_btn",function () {
        //弹出模态框
        //下拉列表实现部门添加
        getDepts("#empUpdateModal select");
        //查出对应员工信息
        getEmp($(this).attr("edit-id"));
        //把员工id传给模态框更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });
    //查询员工信息
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var empData=result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }
    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var email=$("#email_update_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,8})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_update_input","error","邮箱格式有误");
            return false;
        }else{
            show_validate_msg("#email_update_input","success","");
        }
        //发送ajax请求保存数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //关闭模态框回到本页面
                $("#empUpdateModal").modal('hide');
                to_page(currentpage);
            }
        });
    });
    
    //完成全选全不选功能
    $("#check_all").click(function () {
        //若使用attr获取checked是undefined；
        //dom原生的属性，修改和读取用prop，attr获取自定义的属性值
        $(this).prop("checked");
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //若手动全选 那么上面的全选框也要被选中
    $(document).on("click",".check_item",function () {
        //判断当前选择个数是否是一页总个数
        var flag= $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });
    //批量删除
    $("#emp_delete_all").click(function () {
        var empNames="";
        var del_ids="";
        $.each($(".check_item:checked"),function () {
           empNames+= $(this).parents("tr").find("td:eq(2)").text()+",";
          del_ids+= $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除多余的逗号
       empNames= empNames.substring(0,empNames.length-1);
        del_ids= del_ids.substring(0,del_ids.length-1);
        if(confirm("确认删除【"+empNames+"】吗？")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_ids,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentpage);
                }
            });
        }
    });
    
</script>
</body>
</html>