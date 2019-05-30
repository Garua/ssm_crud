<%--
  Created by IntelliJ IDEA.
  User: 呱呱呱
  Date: 2019/5/25
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%-- 不以/开始的相对路径,找资源时,以当前资源的路径为基准
      以/开始的相对路径,找资源时,以服务器的路径为标准(http://localhost:3306)
      --%>
    <title>员工列表显示</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
        System.out.println(request.getContextPath());
    %>
    <%--  也可以用${APP_PATH}  --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/bootstrap.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/jq/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="${pageContext}/bootstrap/bootstrap.js"></script>
</head>
<body>
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
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>

    <%--  显示表格数据  --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <td>#</td>
                    <td>empName</td>
                    <td>gender</td>
                    <td>email</td>
                    <td>deptName</td>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender=="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-pencil"
                                                                         aria-hidden="true"></span>编辑
                            </button>
                            <button class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash"
                                                                        aria-hidden="true"></span>删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>


            </table>

        </div>

    </div>
    <%--  显示分页信息  --%>
    <div class="row">
        <%--        分页文字信息   --%>
        <div class="col-md-6">
            当前第${pageInfo.pageNum}页,总共有${pageInfo.pages}页,总记录数:${pageInfo.total}
        </div>
        <%--       分页条     --%>
        <div class="col-md-6">
            <nav aria-label="...">
                <ul class="pagination">
                    <li <c:if test="${pageInfo.pageNum == 1}">class="disabled"</c:if>>
                        <a <c:if test="${pageInfo.pageNum != 1}">href="${APP_PATH}/emps/showEmps?pn=1" </c:if>>首页 </a>
                    </li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/emps/showEmps?pn=${pageInfo.pageNum - 1}" aria-label="Previous"><span
                                    aria-hidden="true">&laquo;</span></a>
                        </li>
                    </c:if>
                    </li>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <%--                  这里( <li <c:)必须有一个空格，不然样式不对      --%>
                        <li <c:if test="${page_Num == pageInfo.pageNum}">class="active" </c:if>>
                            <a <c:if test="${page_Num != pageInfo.pageNum}">href="${pageContext.request.contextPath}/emps/showEmps?pn=${page_Num}" </c:if>>${page_Num}<span
                                    class="sr-only"></span>
                            </a>
                        </li>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li><a href="${APP_PATH}/emps/showEmps?pn=${pageInfo.pageNum + 1}" aria-label="Next"><span
                                aria-hidden="true">&raquo;</span></a></li>
                    </c:if>
                    <li <c:if test="${pageInfo.pageNum == pageInfo.pages}">class="disabled"</c:if>>
                        <a <c:if test="${pageInfo.pageNum != pageInfo.pages}">href="${APP_PATH}/emps/showEmps?pn=${pageInfo.pages}" </c:if>>尾页 </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

</div>
</body>
</html>
