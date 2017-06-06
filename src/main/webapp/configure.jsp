<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="titleBar.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>configure</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/common.css">
        <link rel="stylesheet" href="css/accountsetting.css">
    </head>
    <body>
        <main class="container">
            <div class="row title">
                <div class="col-md-7 smalltitle">
                    <img src="img/configure.png" alt="">
                    <strong>一二级指标配置</strong>
                </div>
                <div class="col-md-5 text-right back">
                    <a href="teachingRoutine.html">返回>></a>
                </div>
            </div>

            <div class="row content">
                <div class="col-md-4">
                    <div class="configure">
                        <div class="theme text-left">
                            <img src="img/v1.png" alt="">
                            <span>一级指标</span>
                            <div class="pull-right">
                                <i class="fa fa-plus"></i>
                            </div>
                        </div>

                        <div class="configure-content">
                            <table class="table table-bordered">
                                <tr><td>
                                        <div class="pull-left"><strong>教学工作量</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>教学常规</strong><span>40分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>教学建设</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>其它</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="configure">
                        <div class="theme text-left">
                            <img src="img/v2.png" alt="">
                            <span>二级指标</span>
                            <div class="pull-right">
                                <i class="fa fa-plus"></i>
                            </div>
                        </div>

                        <div class="configure-content">
                            <table class="table table-bordered table-hover">
                                <tr><td>
                                        <div class="pull-left"><strong>教学工作量</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>教学常规</strong><span>40分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>教学建设</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="configure">
                        <div class="theme text-left">
                            <img src="img/workcotent.png" alt="">
                            <span>工作内容</span>
                            <div class="pull-right">
                                <i class="fa fa-plus"></i>
                            </div>
                        </div>

                        <div class="configure-content">
                            <table class="table table-bordered table-hover">
                                <tr><td>
                                        <div class="pull-left"><strong>教学工作量</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>教学常规</strong><span>40分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>教学建设</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                            </table>
                        </div>
                    </div>
                </div>


            </div>

            <div class="text-center">
                <button type="button" class="btn btn-primary" id="submit">保存并返回</button>
            </div>


        </main>

        <!-- <div class="configure">
                
        </div> -->

    </body>
    <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="js/configure.js"></script>
</html>
