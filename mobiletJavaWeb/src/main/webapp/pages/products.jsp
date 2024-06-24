<%@page import="java.util.List"%>
<%@page import="Entity.Product"%>
<%@page import="java.util.Optional"%>
<%@page import="mobilet_controller.MobiletSystem" %>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String subtype = (String) request.getAttribute("subtype");
    String type = (String) request.getAttribute("type");

    List<Product> data = MobiletSystem.getProductsByTypeAndSubType(type, subtype);
%>
<section style="margin-bottom: 85px;">
    <div class="mobile-product">
        <div class="container">
            <div class="row">                
                <%
                    if (data.size() > 0) {
                        for (Product p : data) {
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
                        <figure class="w-100 position-relative overflow-hidden border-bottom pb-1">
                            <img src="assets/img/<%=p.getType()%>/<%=p.getImg()%>" alt="" class="d-table mx-auto">
                            <figcaption class="position-absolute w-100 h-100 text-center">
                                <ul class="p-0">
                                    <li class="d-inline-block">
                                        <a href="index.jsp?path=/<%=p.getType()%>/<%=p.getID()%>" class="d-inline-block rounded">
                                            <i class="bi bi-eye">
                                            </i>
                                        </a>
                                    </li>
                                    <li class="d-inline-block">
                                        <a href="index.jsp?path=/like&id=/<%=p.getType()%>/<%=p.getID()%>" class="d-inline-block rounded">
                                            <i class="bi bi-heart"></i>
                                        </a>
                                    </li>
                                </ul>
                            </figcaption>
                        </figure>
                        <h6 class="my-3 ">
                            <%=p.getTitle("persian")%>
                        </h6>
                        <div class="price-txt mb-3">
                            <span class="p-1 text-primary"> 
                                <%=p.getSubtype()%>
                            </span>
                        </div>
                        <div class="product-price d-flex">
                            <p class="d-inline-block w-100">
                                <b> 
                                    <%=MobiletSystem.formatPrice((double) Math.round(priceVal * (100 - offVal) / 100))%>
                                </b>
                            </p>
                            <del class="d-inline-block w-100 text-end">
                                <%=MobiletSystem.formatPrice(priceVal)%>
                            </del>
                        </div>
                        <a href="index.jsp?path=/<%=p.getType()%>/<%=p.getID()%>" class="text-success">ثبت سفارش</a>
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