<!-- 设置不要忽略EL表达式 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云🖊记</title>
    <link href="static/css/note.css" rel="stylesheet">
    <link href="static/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="static/sweetalert/sweetalert2.min.css" rel="stylesheet">
    <script src="static/js/jquery-1.11.3.js"></script>
    <script src="static/bootstrap/js/bootstrap.js"></script>
    <script src="static/sweetalert/sweetalert2.min.js"></script>
    <!-- 引入工具类js文件，那么在其他页面就不用再引入了 -->
    <script src="static/js/util.js"></script>
    <!-- 富文本编辑器 配置文件 -->
    <script type="text/javascript" src="static/ueditor/ueditor.config.js"></script>
    <!-- 富文本编辑器 源码文件 -->
    <script type="text/javascript" src="static/ueditor/ueditor.all.js"></script>
    <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
            background: url(static/images/bg.gif) repeat;
        }
    </style>
</head>

<body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" style="font-size:25px" href="">云🖊记</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li <c:if test="${menu_page=='index'}">class="active"</c:if>><a href="index"><i
                            class="glyphicon glyphicon-cloud"></i>&nbsp;主&nbsp;&nbsp;页</a>
                    </li>
                    <li <c:if test="${menu_page=='note'}">class="active"</c:if>><a href="note?actionName=view"><i
                            class="glyphicon glyphicon-pencil"></i>&nbsp;发布云记</a></li>
                    <li <c:if test="${menu_page=='type'}">class="active"</c:if>><a href="type?actionName=list"><i
                            class="glyphicon glyphicon-list"></i>&nbsp;类别管理</a></li>
                    <li <c:if test="${menu_page=='user'}">class="active"</c:if>><a href="user?actionName=userCenter"><i
                            class="glyphicon glyphicon-user"></i>&nbsp;个人中心</a>
                    <li <c:if test="${menu_page=='report'}">class="active"</c:if>><a href="report?actionName=info"><i
                            class="glyphicon glyphicon-signal"></i>&nbsp;数据报表</a></li>
                </ul>
                <%-- 查询表单 --%>
                <form class="navbar-form navbar-right" role="search" method="post" action="index">
                    <div class="form-group">
                        <%-- 隐藏域，设置用户行为 --%>
                        <input type="hidden" name="actionName" value="searchTitle">
                        <input type="text" name="title" class="form-control" placeholder="搜索云记" value="${title}">
                    </div>
                    <button type="submit" class="btn btn-default">查询</button>
                </form>

            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row-fluid">
            <div class="col-md-3">
                <div class="data_list">
                    <div class="data_list_title"><span class="glyphicon glyphicon-user"></span>&nbsp;个人中心&nbsp;&nbsp;&nbsp;&nbsp;<a
                            href="user?actionName=logout">退出</a></div>
                    <div class="userimg">
                        <%-- 头像是通过请求后台加载的，所有要请求后台  和 个人中心里加载头像是一样的--%>
                        <img src="user?actionName=userHead&imageName=${user.head}">
                    </div>
                    <div class="nick">${user.nick}</div>
                    <div class="mood">(${user.mood})</div>
                </div>

                <div class="data_list">
                    <div class="data_list_title">
					    <span class="glyphicon glyphicon-calendar">
					    </span>&nbsp;云记日期
                    </div>

                    <div>
                        <ul class="nav nav-pills nav-stacked">
                            <c:forEach items="${dataInfo}" var="item">
                                <li>
                                    <a href="index?actionName=searchDate&date=${item.groupName}">${item.groupName}
                                        <span class="badge">${item.noteCount}</span>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <div class="data_list">
                    <div class="data_list_title">
					<span class="glyphicon glyphicon-list-alt">
					</span>&nbsp;云记类别
                    </div>

                    <div>
                        <ul id="typeUl" class="nav nav-pills nav-stacked">
                            <c:forEach items="${typeInfo}" var="item">
                                <li id="li_${item.typeId}">
                                    <a href="index?actionName=searchType&typeId=${item.typeId}"><span
                                            id="sp_${item.typeId}">${item.groupName}</span>
                                        <span class="badge">${item.noteCount}</span>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
        <%-- 这里是需要改变的右侧页面 -- --------- --%>
        <%-- 动态包含页面 --%>
        <%-- 云记列表 --%>
        <%--        <jsp:include page="note/list.jsp"></jsp:include>--%>
        <%--个人中心--%>
        <%--        <jsp:include page="user/info.jsp"></jsp:include>--%>
        <%-- 类型列表、类别管理 --%>
        <%--        <jsp:include page="type/list.jsp"></jsp:include>--%>

        <%-- 通过后台设置动态显示的页面，通过包含加载进来，如：新增一个IndexServlet控制器，在里面设置请求域参数，然后再重新请求转发 --%>
        <%-- 如果获取到后台设置的值，则显示; 如果未获取到，则设置默认 --%>
        <c:if test="${empty changePage}">
            <jsp:include page="note/list.jsp"></jsp:include>
        </c:if>

        <c:if test="${!empty changePage}">
            <jsp:include page="${changePage}"></jsp:include>
        </c:if>
    </div>

</body>
</html>
