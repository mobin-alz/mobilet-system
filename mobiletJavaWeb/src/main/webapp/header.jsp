<%@page import="java.util.Optional"%>
<%@page import="mobilet_controller.MobiletSystem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fa" dir="rtl">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- <link rel="stylesheet" href="assets/css/bootstrap.rtl.css"> -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap.rtl.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap-icons.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.css">
        <link rel="stylesheet" href="assets/css/owl.theme.default.css">
        <!-- TABS -->
        <link rel="stylesheet" href="assets/css/flowbite.min.css" />

        <link rel="stylesheet" href="assets/css/font.css">
        <link rel="stylesheet" href="style.css">
        <title>سایت فروشگاهی لوازم جانبی موبایل و لپ تاپ</title>

    </head>

    <body>

        <header>
            <div id="responsive_Menu_Btn">
                <span></span> <span></span> <span></span>
            </div>
            <div class="responsive-menu-container w-100 bg-white p-4">
                <div id="responsive_Menu_Btn" class="close_responsive_Menu">
                    <span></span> <span></span>
                </div>
                <%
                    Optional<Integer> mustLogin = Optional.ofNullable(MobiletSystem.mustLogin(request));
                %>

                <%=MobiletSystem.showMenu(MobiletSystem.menu(request, response), Optional.ofNullable(null))%>
            </div>
            <header class="mb-5">
                <div class="top-menu position-relative">
                    <div class="container">
                        <span id="responsive_Menu_Btn"> <span></span> <span></span>
                            <span></span>
                        </span>
                        <div class="row">
                            <div class="col-md-3 col-sm-6 col-12 text-center">
                                <div class="logo-box">
                                    <a href="./index.jsp"> <img
                                            src="assets/img/Artboard 1@2x.png" alt="">
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-6 d-none d-md-block">
                                <div class="main-menu">
                                    <%=MobiletSystem.showMenu(MobiletSystem.menu(request, response), Optional.ofNullable(null))%>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 col-12">
                                <div class="top-access">
                                    <ul class="text-center p-0">
                                        <li class="d-inline-block  rounded py-2 me-2"
                                            style="border: 1px solid #034b6a; background-color: #eee;">
                                            <%
                                                if (!MobiletSystem.isUser(request)) {
                                            %> <a href="./index.jsp?path=/login" style="font-size: 13px;"
                                               class="text-black-50"> <i class="bi bi-person pe-1"></i>ورود
                                            </a> | <a href="./index.jsp?path=/register"
                                                      style="font-size: 13px;" class="text-black-50"> <i
                                                    class="bi bi-person-plus pe-1"></i>ثبت نام
                                            </a> <%
                                            } else {
                                            %> <a href="./index.jsp?path=/user/profile" style="font-size: 13px;"
                                               class="text-black-50"> <i class="bi bi-person-fill pe-1"></i>حساب
                                                کاربری
                                            </a> | <a href="./index.jsp?path=/logout" style="font-size: 13px;"
                                                      class="text-black-50"> <i class="bi bi-door-open pe-1"></i>خروج
                                            </a> <%
                                                }
                                            %>
                                        </li>

                                        <li data-bs-toggle="modal" data-bs-target="#exampleModal"
                                            class="d-inline-block"><a href="#"
                                                                  class=" d-inline-block" style="color: #034b6a;"
                                                                  data-bs-toggle="tooltip" data-bs-placement="top" title="جستجو"><i
                                                    class="bi bi-search"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="exampleModal" tabindex="-1"
                     aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-body">
                                <form action="">
                                    <input type="text" placeholder="جستجو کنید ...">
                                    <button>
                                        <i class="bi bi-search"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </header>