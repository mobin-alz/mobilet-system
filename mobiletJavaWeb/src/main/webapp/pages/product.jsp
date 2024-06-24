
<%@page import="java.util.HashMap" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Optional" %>
<%@page import="Entity.Product" %>
<%@page import="mobilet_controller.MobiletSystem" %>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% String productID = (String) request.getAttribute("pid");
    if (productID == null) {
        productID = "1";
    }
    Product p = MobiletSystem.getProductByID(productID);
    MobiletSystem.error("product => name => " + p.getName() + "[" + productID + "]");
    Optional<String> show_get;
    Optional<Integer> p_count;
    if (MobiletSystem.hasCartOfProduct(request, productID)) {
        p_count = Optional.ofNullable(MobiletSystem.getCountInCart(request, productID));
    } else {
        p_count = Optional.ofNullable(null);
    }
    if (request.getParameter("show") != null) {
        show_get = Optional.ofNullable(request.getParameter("show"));
    } else {
        show_get = Optional.ofNullable(null);
    }
    ArrayList<ArrayList<String>> mainFeatures = p.getMainFeatures();
    HashMap<String, ArrayList<ArrayList<String>>> features = p.getFeatures();
    HashMap<String, ArrayList<String>> quantities = p.getQuantities();
%>
<!-- MAIN -->
<div class="max-w-[1440px] mx-auto px-3">
    <div class="flex gap-x-2 px-10 mt-5 md:mt-10">
        <div>
            <a href="index.jsp" class="hover:text-blue-500 transition text-sm opacity-70">خانه</a>
        </div>
        <div class="opacity-70">/</div>
        <div>
            <a href="index.jsp?path=/<%=p.getType()%>" class="hover:text-blue-500 transition text-sm opacity-70">
                <%=p.getType()%>
            </a>
        </div>
        <div class="opacity-70">/</div>
        <div>
            <a href="index.jsp?path=/<%=p.getType()%>/<%=p.getSubtype()%>" class="hover:text-blue-500 transition text-sm opacity-70">
                <%=p.getSubtype()%>
            </a>
        </div>
    </div>
    <div class="bg-white shadow-xl my-5 md:my-10 rounded-xl md:rounded-2xl p-3 md:p-5">
        <% if (show_get.isPresent()) { %>
        <% if (show_get.get().equals("1")) { %>
        <div class="text-center text-lg bg-green-200 opacity-100 mb-2"> محصول با موفقیت از سبد خرید حذف شد</div>
        <% }
            }%>
        <div class="p-3 w-11/12 mx-auto rounded-2xl">
            <form action="addToCard?pid=<%=p.getID()%>" method="post">  <div class="lg:flex">  <div class="w-full lg:w-1/3">  <div>
                            <div class="max-w-[300px] mx-auto">  <img  class="mySlides rounded-xl md:rounded-3xl"  src="assets/img/products/1.jpg"  style="width: 100%"  alt=""/>   <img  class="mySlides rounded-xl md:rounded-3xl"  src="assets/img/products/2.jpg"  style="width: 100%; display: none"  alt=""/>
                                <img  class="mySlides rounded-xl md:rounded-3xl"  src="assets/img/products/3.jpg"  style="width: 100%; display: none"  alt=""/>   <img  class="mySlides rounded-xl md:rounded-3xl"  src="assets/img/products/4.jpg"  style="width: 100%; display: none"  alt="">  </div>  </div>  </div>   <div class="w-full lg:w-2/3 mt-5 md:mt-0">  <div id="likeButton">
                            <span class="flex items-center pr-20 pb-2">
                                <svg
                                    onclick="showAlertAddToFavorit(this)"
                                    class="h-7 w-7 text-blue-500 hover:text-blue-600 fill-current transition cursor-pointer inline"
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24">
                                    <path
                                        d="M12.76 3.76a6 6 0 0 1 8.48 8.48l-8.53 8.54a1 1 0 0 1-1.42 0l-8.53-8.54a6 6 0 0 1 8.48-8.48l.76.75.76-.75zm7.07 7.07a4 4 0 1 0-5.66-5.66l-1.46 1.47a1 1 0 0 1-1.42 0L9.83 5.17a4 4 0 1 0-5.66 5.66L12 18.66l7.83-7.83z"
                                        fill='gray' />
                                </svg>
                            </span>
                        </div>
                        <div class="opacity-80 text-lg font-semibold">
                            <%=p.getTitle("persian")%>
                        </div>
                        <div class="opacity-50 text-xs mt-2 mb-4">
                            <%=p.getTitle("english")%>
                        </div>
                        <div class="md:flex sm:pr-7">
                            <div class="md:w-2/3">
                                <div class="flex items-center">
                                    <div class="opacity-70 text-sm mb-1">رنگ بندی:</div>
                                    <div class="flex flex-wrap">
                                        <div class="flex items-center gap-x-2">
                                            <div class="flex w-max">
                                                <%
                                                    for (String color : p.getColors()) {
                                                %>
                                                <div class="inline-flex items-center">
                                                    <label
                                                        class="relative flex cursor-pointer items-center rounded-full p-3"
                                                        for="<%=color%>"> 
                                                        <input
                                                            id="<%=color%>"
                                                            value="<%=color%>"
                                                            name="color"
                                                            type="radio"
                                                            class="before:content[''] peer relative h-7 w-7 cursor-pointer appearance-none rounded-full border border-blue-gray-200 bg-<%=color%>-500 text-<%=color%>-500 transition-all before:absolute before:top-2/4 before:left-2/4 before:block before:h-12 before:w-12 before:-translate-y-2/4 before:-translate-x-2/4 before:rounded-full before:bg-blue-gray-500 before:opacity-0 before:transition-opacity hover:before:opacity-10"
                                                            checked />
                                                        <div
                                                            class="pointer-events-none absolute top-2/4 left-2/4 -translate-y-2/4 -translate-x-2/4 text-<%=color%>-500 opacity-0 transition-opacity peer-checked:opacity-100">
                                                            <svg
                                                                xmlns="http://www.w3.org/2000/svg"
                                                                class="h-3.5 w-3.5"
                                                                viewBox="0 0 16 16"
                                                                fill="currentColor">
                                                                <circle
                                                                    data-name="ellipse"
                                                                    cx="8"
                                                                    cy="8"
                                                                    r="8"></circle>
                                                            </svg>
                                                        </div>
                                                    </label>
                                                </div>
                                                <% } %>
                                            </div>
                                        </div>
                                    </div>
                                </div> 
                                <div>
                                    <div class="mt-4 mb-2 opacity-80 text-sm font-semibold">
                                        ویژگی های محصول:</div>
                                        <%
                                            System.out.println("info => mainFeatures is ok");
                                            for (ArrayList<String> feature : mainFeatures) {
                                        %>
                                    <div class="flex flex-col gap-y-2 text-xs">
                                        <div class=" flex items-center">
                                            <h3 class="opacity-60 ml-1">
                                                <%=feature.get(0)%>
                                                :
                                            </h3>
                                            <div class="opacity-80">
                                                <div class="text-right">
                                                    <%=feature.get(1)%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                            <div class="md:w-2/5 mt-5 md:mt-0">
                                <div class="pb-5 rounded-2xl shadow-xl border">
                                    <div class="flex justify-between px-3 py-5">
                                        <div class="text-right opacity-80 text-sm flex flex-col gap-y-6">
                                            <%
                                                for (String qk : quantities.keySet()) {
                                                    ArrayList<String> feature = quantities.get(qk);
                                            %>
                                            <div>
                                                <%=feature.get(0)%>
                                                :
                                            </div>
                                            <% } %>
                                            <div>تعداد:</div>
                                        </div>
                                        <div
                                            class="text-left opacity-70 text-sm flex flex-col gap-y-6">
                                            <%
                                                for (String qk : quantities.keySet()) {
                                                    ArrayList<String> feature = quantities.get(qk);
                                            %>
                                            <div dir='rtl'>
                                                <%=feature.get(1)%>
                                                <%=feature.get(2)%>
                                            </div>
                                            <% }%>
                                            <input
                                                type="hidden"
                                                name="type"
                                                value="<%=p.getType()%>" />
                                            <div
                                                class="flex text-sm sm:text-sm items-center justify-center lg:justify-start">
                                                <div class="flex items-center justify-center select-none">
                                                    <%
                                                        if (!p_count.isPresent()) {
                                                    %>
                                                    <div class="quantity flex items-center">
                                                        <input
                                                            name="quantity"
                                                            class="w-12 h-7 mx-2 text-center border focus:outline-none rounded-lg"
                                                            type="number"
                                                            min="1"
                                                            step="1"
                                                            value="1"
                                                            readonly>
                                                    </div>
                                                    <%
                                                    } else {
                                                    %>
                                                    <label>
                                                        <%=p_count.get()%>
                                                    </label>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <span class="flex justify-center items-center opacity-90">
                                        <%
                                            if (!p_count.isPresent()) {
                                        %>
                                        <button
                                            type="submit"
                                            class="px-7 py-2 text-center text-white bg-blue-500 align-middle border-0 rounded-lg shadow-md text-sm">افزودن
                                            به سبد خرید</button>
                                            <%
                                            } else {
                                            %>
                                        <label>قبلا به سبد خرید اضافه شده است</label>
                                        <button
                                            type="submit"
                                            class="px-7 py-2 text-center text-white bg-red-500 align-middle border-0 rounded-lg shadow-md text-sm">حذف
                                            از سبد خرید</button>
                                            <% } %>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form> 
            <div class="flex justify-around my-5">
                <div class="flex flex-col items-center justify-center">
                    <div>
                        <img
                            src="assets/img/services/cash-on-delivery.svg"
                            alt=""/>
                    </div>
                    <div class="opacity-70 text-xs">پرداخت در محل</div>
                </div>
                <div class="flex flex-col items-center justify-center">
                    <div>
                        <img
                            src="assets/img/services/days-return.svg"
                            alt=""/>
                    </div>
                    <div class="opacity-70 text-xs">قابل برگشت</div>
                </div>
                <div class="flex flex-col items-center justify-center">
                    <div>
                        <img
                            src="assets/img/services/express-delivery.svg"
                            alt=""/>
                    </div>
                    <div class="opacity-70 text-xs">ارسال سریع</div>
                </div>
                <div class="flex flex-col items-center justify-center">
                    <div>
                        <img
                            src="assets/img/services/original-products.svg"
                            alt=""/>
                    </div>
                    <div class="opacity-70 text-xs">ضمانت کالا</div>
                </div>
            </div>
            <!-- TABS -->
            <div class="mx-auto">
                <div class="border-b border-gray-200 mb-4">
                    <ul
                        class="flex justify-center flex-wrap -mb-px text-center"
                        id="myTab"
                        data-tabs-toggle="#myTabContent"
                        role="tablist">
                        <%
                            System.out.println("info => infos is ok");
                            HashMap<String, String> infos = p.getInfos();
                            String active = "details";
                            for (String key : infos.keySet()) {
                        %>
                        <li
                            class="mr-2"
                            role="presentation">
                            <button
                                class='inline-block text-gray-500 hover:text-gray-600 hover:border-gray-300 rounded-t-lg py-4 px-4 text-sm font-medium text-center border-transparent border-b-2 <%=key.equals(active) ? "active" : ""%>'
                                id="<%=key%>-tab"
                                data-tabs-target="#<%=key%>"
                                type="button"
                                role="tab"
                                aria-controls="<%=key%>"
                                aria-selected="<%=(Boolean.toString((key.equals(active))))%>">
                                <%=infos.get(key)%>
                            </button>
                        </li>
                        <% } %>
                    </ul>
                </div>
                <div id="myTabContent">
                    <div
                        class="bg-gray-50 p-5 rounded-xl"
                        id="details"
                        role="tabpanel"
                        aria-labelledby="details-tab">
                        <span class="border-b-blue-500 border-b"> مشخصات فنی محصول
                        </span>
                        <div class="text-gray-500 text-sm grid grid-cols-1 gap-x-3">
                            <b class="text-gray-500 text-sm grid grid-cols-1 gap-x-3">ویژگی‌ها
                            </b>
                            <%
                                System.out.println("info => description is ok");
                                for (String fk : features.keySet()) {
                                    ArrayList<ArrayList<String>> featurePart = features.get(fk);
                            %>

                            [<%=fk%>]
                            <%
                                for (ArrayList<String> feature : featurePart) {
                            %>
                            <div class="flex flex-col gap-y-2 text-xs">
                                <div class=" flex items-center">
                                    <h3 class="opacity-60 ml-1">
                                        <%=feature.get(0)%>
                                        :
                                    </h3>
                                    <div class="opacity-80">
                                        <div class="text-right">
                                            <%=feature.get(1)%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr/>
                            <% } %>

                            <% }%>

                            <hr />
                        </div>
                    </div>
                    <div
                        class="bg-gray-50 p-4 rounded-xl hidden"
                        id="about"
                        role="tabpanel"
                        aria-labelledby="about-tab">
                        <span class="border-b-blue-500 border-b"> معرفی کوتاه محصول
                        </span>
                        <p class="text-gray-500 text-sm leading-7 mt-3 justify-center">
                            <%=p.getAbout()%>
                        </p>
                    </div>
                    <div
                        class="bg-gray-50 p-4 rounded-xl hidden"
                        id="test"
                        role="tabpanel"
                        aria-labelledby="test-tab">
                        <div class="flex flex-col items-start gap-y-4">
                            <span class="border-b-blue-500 border-b"> بررسی تخخصی </span>
                        </div>
                        <div class="md:flex gap-3">
                            <p class="text-gray-500 text-sm leading-7 mt-3">
                                <%=p.getExpertAbout()%>
                            </p>
                            <img
                                class="max-w-[320px] w-full mx-auto rounded-3xl"
                                src="assets/img/products/<?= $product['info']['test']['image'] ?>"
                                alt=""/>
                        </div>
                    </div>
                    <%

                    %>
                    <div
                        class="bg-gray-50 p-4 rounded-xl hidden"
                        id="commentsBuy"
                        role="tabpanel"
                        aria-labelledby="commentsBuy-tab">
                        <span class="border-b-blue-500 border-b"> دیدگاه های محصول
                        </span>
                        <p class="text-gray-500 text-sm"></p>
                        <div
                            class="flex flex-col py-4 px-4 mx-auto my-6 max-w-7xl rounded-2xl bg-white">
                            <!-- UO COMMENTS -->
                            <div>
                                <div>دیدگاه ها</div>
                            </div>
                            <!-- COMMENT -->
                            <% String msColor;
                                ArrayList<HashMap<String, String>> comments = p.getComments();
                                for (HashMap<String, String> comment : comments) {
                                    String name = comment.get("name");
                                    String text = comment.get("text");
                                    Double rate = Double.valueOf(comment.get("rate"));
                                    if (rate < 1.6) {
                                        msColor = "red";
                                    } else if (rate < 3.2) {
                                        msColor = "yellow";
                                    } else {
                                        msColor = "green";
                                    }
                            %>
                            <div class="bg-gray-50 rounded-xl px-3 sm:px-5 py-3 my-2">
                                <div class="flex flex-col items-stat gap-y-2">
                                    <div class="flex items-center">
                                        <div
                                            class="text-<?= msColor ?>-400 bg-<?= msColor ?>-100 px-1 rounded-md text-sm">
                                            <%=rate%>
                                        </div>
                                        <span
                                            class="text-<?= msColor ?>-400 bg-<?= msColor ?>-100 px-1 w-24 rounded-md text-sm text-center">
                                            <%=msColor == "green" ? "پیشنهاد شده" : "پیشنهاد نمی‌کنم"%>
                                        </span>
                                        <hr />
                                        <div class="text-xs opacity-60 pr-1">
                                            ارسال شده توسط
                                            <%=name%>
                                        </div>
                                    </div>

                                </div>
                                <div>
                                    <div class="opacity-60 text-sm py-3">
                                        <%=text%>
                                    </div>

                                </div>
                            </div>
                            <%                                 }%>
                            <p></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>