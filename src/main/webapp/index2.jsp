<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 呱呱呱
  Date: 2019/5/26
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link href="bootstrap/bootstrap.css" rel="stylesheet">
    <script src="jq/jquery-3.2.1.js"></script>
    <script src="bootstrap/bootstrap.js"></script>
</head>
<body>

<%--员工更新的模态框--%>
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" name="empNameLabel"
                               class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>

                            <span id="name_update_span"></span>
                            <span id="name_update_help_span" class="help_span"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" name="emailLabel" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email_update_input" name="email">
                            <span id="email_update_span"></span>
                            <span id="email_update_help_span" class="help_span"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderF_update_input" value="F" checked="checked"> 女
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderM_update_input" value="M"> 男
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--                   部门提交部门id即可         --%>
                            <select class="form-control" id="dept_add_select" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="emp_update_cancel_btn">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_save_btn">更新</button>
            </div>
        </div>
    </div>
</div>



<!-- 员工添加 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" name="empNameLabel"
                               class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName_add_input" name="empName"
                                   placeholder="empName">
                            <span id="name_span"></span>
                            <span id="name_help_span" class="help_span"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" name="emailLabel" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email_add_input" name="email"
                                   placeholder="email@loocc.com">
                            <span id="email_span"></span>
                            <span id="email_help_span" class="help_span"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderF_add_input" value="F" checked="checked"> 女
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderM_add_input" value="M"> 男
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--                   部门提交部门id即可         --%>
                            <select class="form-control" id="dept_add_select" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="emp_cancel_btn">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <%--    标题    --%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--    按钮    --%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modelBtn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>

    <%--  显示表格数据  --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <td>
                        <input type="checkbox" id="check_all"/>
                    </td>
                    <td>#</td>
                    <td>empName</td>
                    <td>gender</td>
                    <td>email</td>
                    <td>deptName</td>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="">

                </tbody>

            </table>

        </div>

    </div>
    <%--  显示分页信息  --%>
    <div class="row">
        <%--        分页文字信息   --%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--       分页条     --%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord;
    var currentPage;
    //页面加载完成，直接发送ajax请求，要到分页数据
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps/empsWithJson",
            data: "pn=" + pn,
            type: "get",
            success: function (data) {
                console.log(data);
                //1、解析并显示员工数据
                build_emps_table(data)
                //2、解析并显示分页信息
                build_page_info(data);
                //  3、解析并显示分页条信息
                build_page_nav(data);
                $("#check_all").prop("checked",$(".check_item:checked").length == $(".check_item").length);
            }
        });

    }

    //解析员工数据
    function build_emps_table(data) {
        //先清空，不然会显示之前的数据
        $("#emps_table tbody").empty();
        var emps = data.listEmp.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox'class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            /**
             使用addClass方法给元素添加class名字,并且返回该调用的元素
             * @type {*|jQuery}
             */
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为editBtn添加一个自定义属性，值为当前emp的id，为后面编辑emp信息时，得到empId铺垫
            editBtn.attr("edit-id",item.empId);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            //为delBtn添加一个自定义属性，值为当前emp的id，为后面编辑emp信息时，得到empId铺垫
            delBtn.attr("delete-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完了以后还是返回原来撤销元素
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd)
                .append(deptNameTd).append(btnTd).appendTo("#emps_table tbody")
        })
    }

    // 解析分页信息
    function build_page_info(data) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + data.listEmp.pageInfo.pageNum + "页,总共有" + data.listEmp.pageInfo.pages + "页,总记录数:" + data.listEmp.pageInfo.total);
        totalRecord = data.listEmp.pageInfo.pages;
        currentPage = data.listEmp.pageInfo.pageNum;
    }


    //显示分页条，和分页条的点击事件
    function build_page_nav(data) {
        $("#page_nav_area").empty();

        //给属性赋值用attr，还是会返回该元素
        // <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (data.listEmp.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled")
            prePageLi.addClass("disabled")
        } else {
            firstPageLi.click(function () {
                to_page(1)
            });
            prePageLi.click(function () {
                to_page(data.listEmp.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
        if (data.listEmp.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            lastPageLi.click(function () {
                to_page(data.listEmp.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(data.listEmp.pageInfo.pageNum + 1);
            });
        }


        //添加前一页和，首页提示
        ul.append(firstPageLi).append(prePageLi);

        //遍历给ul中添加页码提示
        $.each(data.listEmp.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (data.listEmp.pageInfo.pageNum == item) {
                numLi.addClass("active")
            }
            numLi.click(function () {
                to_page(item)
            })
            ul.append(numLi);
        });
        //添加下一页和尾页的提示
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }


    //点击新增按钮，弹出模态框
    $("#emp_add_modelBtn").click(function () {
        //重置表单内容
        $("#empAddModel form")[0].reset();
        show_check_msg("#empName_add_input", "", "");
        show_check_msg("#email_add_input", "", "");
        //发ajax请求，查询部门信息，显示在下拉列表中
        getDepts("#empAddModel select");
        //弹出模态框
        $("#empAddModel").modal()
    });


    //    查询所有部门信息,并显示在下拉列表
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/dept/depts",
            type: "get",
            success: function (data) {
                // alert(data)
                // $("#empAddModel select").append("")
                $.each(data.listEmp.listDept, function (index, item) {
                    var optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                    optionEle.appendTo(ele)
                });
            }
        })
    }

    //   为按钮添加保存事件
    $("#emp_save_btn").click(function () {
        if ($(this).attr("status") == "error") {
            return false;
        }
        //先对数据校验
        if (!check_add_empName()||!check_add_email()) {
            return false;
        }
        //2、发送ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/emps/saveEmp",
            type: "post",
            data: $("#empAddModel form").serialize(),
            success: function (data) {
            if(data.code == 100){
                //  1、  保存成功应该关闭模态框
                $("#empAddModel").modal('hide');
                //  2、  应该跳转到最后一页
                to_page(totalRecord)
            }else{
                //显示失败信息
                console.log(data)
            }

            }

        })
        //serialize会把表单中的值，序列化为字符串,要使用这个元素必须要有name属性
        // alert($("#empAddModel form").serialize());
    });


    //验证用户名
    function check_add_empName() {
        //    拿到要校验的数据
        var empName = $("#empName_add_input").val();

        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;

        if (!regName.test(empName)) {
            // alert("用户名不正确");
            show_check_msg("#empName_add_input", "error", "用户名应该是6-16个字母或数字或2-5个汉字!");
            return false;
        } else {
            // alert("用户名不正确");
            show_check_msg("#empName_add_input", "success", "");
            return true;
        }

    }

    //验证邮箱
    function check_add_email() {
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_check_msg("#email_add_input", "error", "邮箱格式不正确!");
            return false;
        } else {
            // alert("用户名不正确");
            show_check_msg("#email_add_input", "success", "");
            return true;
        }
    }

    function show_check_msg(ele, status, msg) {

        //先清空
        $(ele).parent().removeClass("has-success has-feedback has-error");
        $(ele).removeClass("form-control");
        $(ele).siblings(".help_span").removeClass("glyphicon glyphicon-ok form-control-feedback");
        $(ele).next("span").removeClass("help-block");
        $(ele).siblings(".help_span").removeClass("glyphicon glyphicon-remove form-control-feedback", "");
        $(ele).next("span").addClass("help-block").text("")
        if ("success" == status) {
            $(ele).parent().addClass("has-success has-feedback");
            $(ele).addClass("form-control");
            $(ele).siblings(".help_span").addClass("glyphicon glyphicon-ok form-control-feedback");
            $("#name_span").addClass("help-block").append(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass(" has-error  has-feedback");
            $(ele).addClass("form-control");
            $(ele).siblings(".help_span").addClass("glyphicon glyphicon-remove form-control-feedback", "help-block");
            $(ele).next("span").addClass("help-block").append(msg);
        }
    }

    //校验用户名是否可用
    $("#empName_add_input").blur(function () {
        if (check_add_empName()) {
            $.ajax({
                url: "${APP_PATH}/emps/checkUser",
                data: "empName=" + this.value,
                type: "post",
                success: function (data) {
                    if (data.code == 100) {
                        show_check_msg("#empName_add_input", "success", "用户名可用。");
                        $("#emp_save_btn").attr("status", "success");
                    } else {
                        show_check_msg("#empName_add_input", "error", "用户名不可用。");
                        $("#emp_save_btn").attr("status", "error");
                    }
                }
            });
        }
    });

    /**
     *
     * 这样不能绑定点击事件
     * 因为表格中的信息（包括编辑按钮）是在页面加载完成之后发送的ajax请求显示的，
     * 而下面的绑定事件先于它执行，此时都没有edit_btn
     * 解决办法，1、在创建按钮的时候就绑定（不好）
     *              2、用jq的live方法（给所有匹配的元素附加一个事件处理函数，即使这个元素是以后再添加进来的也有效）。
     *              jq新版本中没有live方法，用on方法替代
     * $(".edit_btn").click(function(){
     *     alert("test"):
     * })
     */


    //给编辑按钮添加事件
    $(document).on("click",".edit_btn",function () {
        //查出员工信息并显示

        //查出部门信息并显示
        getDepts("#empUpdateModel select");
        getEmp($(this).attr("edit-id"))

        //把员工id传递给模态框的更新按钮
        $("#emp_update_save_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModel").modal();
    })

    //点击编辑时，查询该员工数据
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emps/getEmp/"+id,
            type:"get",
            success:function (data) {
                var empData = data.listEmp.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModel input[name=gender]").val([empData.gender]);
                $("#empUpdateModel select").val([empData.dId])
            }
        })
    }
    
    $("#emp_update_save_btn").click(function () {
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_check_msg("#email_add_input", "error", "邮箱格式不正确!");
            return false;
        } else {
            // alert("用户名不正确");
            show_check_msg("#email_add_input", "success", "");
        }
        $.ajax({
            url:"${APP_PATH}/emps/updateEmp/"+$(this).attr("edit-id"),
            // type:"post",
            // data:$("#empUpdateModel form").serialize()+"&_method=PUT",
            type:"PUT",
            data:$("#empUpdateModel form").serialize(),
            success:function (data) {
                //关闭对话框
                $("#empUpdateModel").modal("hide");
                //回到本页面
                to_page(currentPage)
            }
        });

    });

    //单个删除
    $(document).on("click",".delete_btn",function () {
    //    弹出确认删除的对话框
        //找到删除按钮的所有祖先元素，在从祖先元素中找到第二个tr元素，取其文体内容
        // alert($(this).parents("tr").find("td:eq(1)").text());
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确认删除【"+empName+"】吗？")){
        //        确认，发送ajax请求删除

            //在构建del-btn的时候就给它添加一个自定义属性，值为empID
            var empId = $(this).attr("delete-id");
             $.ajax({
                 url:"${APP_PATH}/emps/deleteEmpById/"+empId,
                 type:"post",
                 data:"&_method=DELETE",
                 success:function (data)  {
                     alert(data.msg);
                     to_page(currentPage);
                 }
             })
        }
    })

//完成全选/全不选
    $("#check_all").click(function () {
        //使用attr获取checked的值是undefined
        //这些原生的dom属性的值用prop方法获取，自定义属性值用attr获取
        // alert($(this).attr("checked"))
        // alert($(this).prop("checked"))
            $(".check_item").prop("checked",$(this).prop("checked"))
    });

    //给每个checked添加事件
    $(document).on("click",".check_item",function () {
        //判断当前选中的元素是否是五个(一页只有五个),是就把check_all选中
        // $("#check_all")
        //判断当前选中的元素是否是五个(一页只有五个),是就把check_all选中
        //:checked   匹配所有选中的被选中元素(复选框、单选框等，不包括select中的option)
        // alert($(".check_item:checked").length);
        var flag = $(".check_item:checked").length == $(".check_item").length;
       $("#check_all").prop("checked",flag);
    });
    
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        //遍历被选中的的check_item
        $.each($(".check_item:checked"),function (index,item) {
            //得到要删除员工的名字，找到的所有祖先tr元素，在从祖先元素中找到第三个td元素，取其文体内容
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        })
            //去掉最后多余的逗号
            empNames = empNames.substring(0,empNames.length - 1);
            del_idstr = del_idstr.substring(0,del_idstr.length - 1);
            if(confirm("确认删除【"+empNames+"】吗")){
                $.ajax({
                    url:"${APP_PATH}/emps/deleteEmpById/"+del_idstr,
                    type:"POST",
                    data:"&_method=DELETE",
                    success:function (data) {
                        alert(data.msg);
                        to_page(currentPage);
                    }
                })
            }
    });
</script>
</body>
</html>
