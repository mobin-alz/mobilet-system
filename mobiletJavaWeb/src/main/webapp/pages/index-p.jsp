<%@page import="java.util.Optional"%>
<%@page import="java.util.List"%>
<%@page import="Entity.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mobilet_controller.MobiletSystem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!-----Banner-->
<section class="mb-4">

    <div class="row">
        <div class="col-12">
            <div class="owl-carosel-box owl-carousel owl-theme">
                <div class="box">
                    <a href="index.jsp?path=/laptop/external"> <img
                            src="assets/img/Banners/banner1.jpg" alt="">
                    </a>
                </div>
                <div class="box">
                    <a href="index.jsp?path=/laptop/external"> <img
                            src="assets/img/Banners/banner2.jpg" alt="">
                    </a>
                </div>

                <div class="box">
                    <a href="index.jsp?path=/digital/watch"> <img
                            src="assets/img/Banners/banner3.jpg" alt="">
                    </a>
                </div>
            </div>
        </div>
    </div>

</section>
<!-- محصولات مربوط به موبایل-->
<section>
    <div class="container">
        <div class="row">
            <div class="title-mobile mb-4 d-flex">
                <h5 class="d-inline-block w-100">بیشترین تخفیف های گوشی موبایل</h5>
                <a href="index2.html" class="d-inline-block w-100 text-end">مشاهده
                    همه<i class="bi bi-arrow-bar-left px-2 text-black-50"
                          aria-hidden="true"> </i>
                </a>
            </div>
        </div>
    </div>
</section>

<section style="margin-bottom: 85px;">
    <div class="mobile-product">
        <div class="container">
            <div class="row">
                <%
                    List<Product> mps = MobiletSystem.getBestProduct("mobile");
                    if (mps.size() > 0) {
                        for (Product p : mps) {
                            double priceVal = Double.valueOf(p.getQuantities("price").get(1));
                            double offVal = Double.valueOf(p.getQuantities("off").get(1));
                %>

                <div class="col-md-3 col-sm-6  mb-3 mb-md-0">
                    <div class="product-item p-3 bg-white rounded" id="<%=p.getID()%>">
                        <div class="off">
                            <%=p.getQuantities("off").get(0)%>
                            <%=p.getQuantities("off").get(1)%>
                            <%=p.getQuantities("off").get(2)%>
                        </div>
                        <figure
                            class="w-100 position-relative overflow-hidden border-bottom pb-1">
                            <img src="assets/img/<%=p.getType()%>/<%=p.getImg()%>" alt=""
                                 class="d-table mx-auto">
                            <figcaption class="position-absolute w-100 h-100 text-center">
                                <ul class="p-0">
                                    <li class="d-inline-block"><a
                                            href="index.jsp?path=/<%=p.getType()%>/<%=p.getID()%>"
                                            class="d-inline-block rounded"> <i class="bi bi-eye">
                                            </i>
                                        </a></li>
                                    <li class="d-inline-block"><a
                                            href="index.jsp?path=/like&id=/<%=p.getType()%>/<%=p.getID()%>"
                                            class="d-inline-block rounded"> <i class="bi bi-heart">
                                            </i>
                                        </a></li>
                                </ul>
                            </figcaption>
                        </figure>
                        <h6 class="my-3 ">
                            <%=p.getTitle("persian")%>
                        </h6>
                        <div class="price-txt mb-3">
                            <span class="p-1 text-primary"> <%=p.getSubtype()%>
                            </span>
                        </div>
                        <div class="product-price d-flex">
                            <p class="d-inline-block w-100">
                                <b> <%=MobiletSystem.formatPrice((double) Math.round(priceVal * (100 - offVal) / 100))%>
                                </b>
                            </p>
                            <del class="d-inline-block w-100 text-end">
                                <%=MobiletSystem.formatPrice(priceVal)%>
                            </del>
                        </div>
                        <a href="index.jsp?path=/<%=p.getType()%>/<%=p.getID()%>"
                           class="text-success">ثبت سفارش</a>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <label>محصولی یافت نشد</label>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</section>


<section>
    <div class="container">
        <div class="row">
            <div class="title-mobile mb-4 d-flex">
                <h5 class="d-inline-block w-100">پرفروش ترین های لپ تاپ</h5>
                <a href="index2.html" class="d-inline-block w-100 text-end mt-2">مشاهده
                    همه<i class="bi bi-arrow-bar-left px-2 text-black-50"
                          aria-hidden="true"> </i>
                </a>
            </div>
        </div>
    </div>
</section>

<section style="margin-bottom: 110px;">
    <div class="laptop-product mt-2">
        <div class="container">
            <div class="row">
                <%
                    List<Product> lps = MobiletSystem.getBestProduct("laptop");
                    if (lps.size() > 0) {
                        for (Product p : lps) {
                            double priceVal = Double.valueOf(p.getQuantities("price").get(1));
                            double offVal = Double.valueOf(p.getQuantities("off").get(1));
                %>

                <div class="col-md-3 col-sm-6  mb-3 mb-md-0">
                    <div class="product-item p-3 bg-white rounded"
                         id="<%=p.getID()%>">
                        <div class="off">
                            <%=p.getQuantities("off").get(0)%>
                            <%=p.getQuantities("off").get(1)%>
                            <%=p.getQuantities("off").get(2)%>
                        </div>
                        <figure
                            class="w-100 position-relative overflow-hidden border-bottom pb-1">
                            <img src="assets/img/<%=p.getType()%>/<%=p.getImg()%>" alt=""
                                 class="d-table mx-auto">
                            <figcaption class="position-absolute w-100 h-100 text-center">
                                <ul class="p-0">
                                    <li class="d-inline-block"><a
                                            href="index.jsp?path=/<%=p.getType()%>/<%=p.getID()%>"
                                            class="d-inline-block rounded"> <i class="bi bi-eye">
                                            </i>
                                        </a></li>
                                    <li class="d-inline-block"><a
                                            href="index.jsp?path=/like&id=/<%=p.getType()%>/<%=p.getID()%>"
                                            class="d-inline-block rounded"> <i class="bi bi-heart">
                                            </i>
                                        </a></li>
                                </ul>
                            </figcaption>
                        </figure>
                        <h6 class="my-3 ">
                            <%=p.getTitle("persian")%>
                        </h6>
                        <div class="price-txt mb-3">
                            <span class="p-1 text-primary"> <%=p.getSubtype()%>
                            </span>
                        </div>
                        <div class="product-price d-flex">
                            <p class="d-inline-block w-100">
                                <b> <%=MobiletSystem.formatPrice((double) Math.round(priceVal * (100 - offVal) / 100))%>
                                </b>
                            </p>
                            <del class="d-inline-block w-100 text-end">
                                <%=MobiletSystem.formatPrice(priceVal)%>
                            </del>
                        </div>
                        <a href="index.jsp?path=/<%=p.getType()%>/<%=p.getID()%>"
                           class="text-success">ثبت سفارش</a>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <label>محصولی یافت نشد</label>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</section>

<section style="margin-bottom: 95px;">
    <div class="container">
        <div class="row">
            <div class="col-md-3 col-sm-6  mb-3 mb-md-0">
                <img src="assets/img/photo_2023-12-13_20-50-46.jpg" alt=""
                     class="rounded">
            </div>
            <div class="col-md-3 col-sm-6  mb-3 mb-md-0">
                <img src="assets/img/2.jpg" alt="" class="rounded">
            </div>
            <div class="col-md-3 col-sm-6  mb-3 mb-md-0">
                <img src="assets/img/3.jpg" alt="" class="rounded">
            </div>
            <div class="col-md-3 col-sm-6  mb-3 mb-md-0">
                <img src="assets/img/4.jpg" alt="" class="rounded">
            </div>
        </div>
    </div>
</section>

<section>
    <div class="container">
        <div class="row">
            <div class="title-mobile mb-4 d-flex">
                <h5 class="d-inline-block w-100">دسته بندی های پربازدید همه
                    محصولات</h5>
                <a href="index2.html" class="d-inline-block w-100 text-end mt-2">مشاهده
                    همه<i class="bi bi-arrow-bar-left px-2 text-black-50"
                          aria-hidden="true"> </i>
                </a>
            </div>
        </div>
    </div>
</section>

<section style="margin-bottom: 95px;">
    <div class="more-rate-bx">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="cat-carousel-box owl-carousel owl-theme">
                        <div class="item col-md-3 col-sm-6  mb-3 mb-md-0">
                            <div class="item-product bg-white p-3 rounded-circle shadow-sm">
                                <img src="assets/img/products/pr1.jpg" alt=""
                                     class="rounded-circle">
                            </div>
                            <h6 class="text-center py-3">ساعت هوشمند</h6>
                        </div>
                        <div class="item col-md-3 col-sm-6  mb-3 mb-md-0">
                            <div class="item-product bg-white p-3 rounded-circle shadow-sm">
                                <img src="assets/img/products/pr2.jpg" alt=""
                                     class="rounded-circle">
                            </div>
                            <h6 class="text-center py-3">لوازم برقی</h6>
                        </div>
                        <div class="item col-md-3 col-sm-6  mb-3 mb-md-0">
                            <div class="item-product bg-white p-3 rounded-circle shadow-sm">
                                <img src="assets/img/products/pr3.jpg" alt=""
                                     class="rounded-circle">
                            </div>
                            <h6 class="text-center py-3">هدفون</h6>
                        </div>
                        <div class="item col-md-3 col-sm-6  mb-3 mb-md-0">
                            <div class="item-product bg-white p-3 rounded-circle shadow-sm">
                                <img src="assets/img/products/pr4.png" alt=""
                                     class="rounded-circle">
                            </div>
                            <h6 class="text-center py-3">هندزفر بی سیم</h6>
                        </div>

                        <div class="item col-md-3 col-sm-6  mb-3 mb-md-0">
                            <div class="item-product bg-white p-3 rounded-circle shadow-sm">
                                <img src="assets/img/products/3.jpg" alt=""
                                     class="rounded-circle">
                            </div>
                            <h6 class="text-center py-3">شارژر</h6>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>