<%--
  Created by IntelliJ IDEA.
  User: Xin
  Date: 2018/4/25
  Time: 8:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">

    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>员工列表</title>
</head>
<body>

<!-- create employee Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
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
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@whatever.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select"></select>
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

<!-- create employee Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改员工</h4>
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
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@whatever.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId"></select>
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


<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
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
    <div class="row">
        <div class="col-md-6" id="page_info_area">
        </div>

        <div class="col-md-6" id="page_nav_area">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                </ul>
            </nav>
        </div>
    </div>


</div>
<script type="text/javascript">
    $(function () {
       to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }
    
    function build_emps_table(result) {
        //先清空
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check-item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender === "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑")
                .attr("edit-id", item.empId);

            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除")
                .attr("delete-id", item.empId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);

            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }

    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum + "页，共"
            + result.extend.pageInfo.pages + "页，共"
            + result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.pages;
        currentPage = result.extend.pageInfo.pageNum;
    }

    function build_page_nav(result) {
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage === false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            })
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        }

        ul.append(firstPageLi).append(prePageLi);
        
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
            if (result.extend.pageInfo.pageNum === item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        });
        
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if (result.extend.pageInfo.hasNextPage === false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1)
            })
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }

        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    $("#emp_add_modal_btn").click(function () {

        reset_form("#empAddModal form");
        getDepts("#empAddModal select");

        $("#empAddModal").modal({
            //backdrop: "static"
        });
    });

    function getDepts(ele) {
        $(ele).empty();

        $.ajax({
           url: "${APP_PATH}/depts",
           type: "GET",
           success: function (result) {
               //console.log(result);

               $.each(result.extend.depts, function () {
                  var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                  optionEle.appendTo(ele);
               });
           }
        });
    }

    function show_validate_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");

        if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        } else {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }
    }

    function validate_add_form() {
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if (!regName.test(empName)) {
            //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合。");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合。");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }

        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确！");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确！");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    $("#emp_save_btn").click(function () {

        if (!validate_add_form()) {
            return false;
        }
        if (this.attr("ajax-va") == "error") {
            return false;
        }

        $.ajax({
            url: "${APP_PATH}/emps",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                //alert(result.msg);

                if (result.code == 100) {
                    $("#empAddModal").modal("hide");
                    to_page(totalRecord + 1);
                } else {
                    //console.log(result);
                    if (undefined != result.extend.errorFields.email) {
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });

    });

    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用。");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "fail");
                }
            }
        });
    });
    
    $(document).on("click", ".edit_btn", function () {
        getDepts("#empUpdateModal select");
        getEmp($(this).attr("edit-id"));

        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));

        $("#empUpdateModal").modal();
    });

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    $("#emp_update_btn").click(function () {
        // 验证邮箱
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确！");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(), // + "&_method=PUT"
            success: function (result) {
                $("#empUpdateModal").modal("hide");

                to_page(currentPage);
            }
        });
    });

    $(document).on("click", ".delete_btn", function () {
        // pop up confirm dialog
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if (confirm("确认删除【" + empName + "】吗？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + $(this).attr("delete-id"),
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }

    });

    $("#check_all").click(function () {
        $(".check-item").prop("checked", $(this).prop("checked"));
    });

    $(document).on("click", ".check-item", function () {

        $("#check_all").prop("checked", $(".check-item:checked").length == $(".check-item").length);
    });

    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check-item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ", ";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        empNames = empNames.substring(0, empNames.length - 2);
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);

        if (confirm("确认删除【" + empNames + "】吗？")) {

            $.ajax({
                url: "${APP_PATH}/emp/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    var totalRecord, currentPage;
</script>
</body>
</html>
