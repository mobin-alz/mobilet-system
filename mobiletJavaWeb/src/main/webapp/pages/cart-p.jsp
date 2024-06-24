<%@page import="java.util.HashMap"%>
<%@page import="java.util.Optional"%>
<%@page import="mobilet_controller.MobiletSystem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    Double totalPrice = 0.0;
    HashMap<String, String> requests = MobiletSystem.getRequests(request);
%>
<!-- MAIN -->
<div class="max-w-[1440px] mx-auto px-3">
    <div class="bg-white shadow-xl my-10 rounded-xl md:rounded-2xl p-3 md:p-5">
        <div class="relative overflow-x-auto rounded-2xl border">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500">
                <thead class="hidden md:table-header-group text-xs text-gray-700 bg-gray-50">
                    <tr class="text-center justify-items-center">
                        <th scope="col" class="px-16 py-3">
                            <span class="sr-only">تصویر</span>
                        </th>
                        <th scope="col" class="md:pr-6 py-3">
                            نام محصول
                        </th>
                        <th scope="col" class="pr-10 py-3">
                            تعداد
                        </th>
                        <th scope="col" class="px-6 py-3">
                            قیمت
                        </th>
                        <th scope="col" class="px-6 py-3">
                            دستورات
                        </th>
                    </tr>
                </thead>
                <tbody class="grid grid-cols-1 sm:grid-cols-2 md:contents gap-5 text-center">
                    <% for (String pid : requests.keySet()) {
                            String[] info = requests.get(pid).split("-");
                            String quantity = info[0];
                            String color = info[1];
                            String name = info[2];
                            Double price = Double.valueOf(info[3]);
                    %>
                    <tr class="bg-white border-b hover:bg-gray-50 grid grid-cols-1 justify-items-center md:table-row">
                        <td class="p-4">
                            <img src="assets/img/<?= $value['type'] ?>/<?= $value['img'] ?>"
                                 class="w-48 md:w-32 max-w-full max-h-full rounded-lg" alt="">
                        </td>
                        <td class="md:pr-6 py-4 text-sm opacity-90 text-gray-900">
                            <%=name%>
                        </td>
                        <td class="px-6 py-4">
                            <div class="quantity flex text-center items-center">
                                <input class="w-12 h-8 mx-2 text-center border focus:outline-none rounded-lg" type="number" min="1"
                                       step="1" value="<%=quantity%>" readonly>
                            </div>
                        </td>
                        <td class="px-6 py-4 text-sm opacity-90 text-gray-900">
                            <%= MobiletSystem.formatPrice(price)%>
                        </td>
                        <td class="px-6 py-4">
                            <a href="index.jsp?path=deleteFromCart&pid=<%=pid%>&back=/cart" class=" text-red-600">حذف</a>
                        </td>
                    </tr>
                    <%
                            totalPrice += price;
                        }%>
                </tbody>
            </table>
        </div>
        <div class="border shadow-xl rounded-2xl mx-auto max-w-xl mt-7 flex flex-col gap-y-5 py-5 px-5 md:px-20">
            <div class="flex justify-between">
                <div>
                    قیمت کل:
                </div>
                <div class="flex gap-x-1">
                    <div>
                        <%=totalPrice%>
                    </div>
                    <div>
                        تومان
                    </div>
                </div>
            </div>
            <div class="flex justify-between">
                <div>
                    حمل و نقل:
                </div>
                <div class="flex gap-x-1">
                    <div>
                        40,000
                    </div>
                    <div>
                        تومان
                    </div>
                </div>
            </div>            
            <div class="flex justify-between">
                <div class="text-red-600">
                    مجموع نهایی:
                </div>
                <div class="flex gap-x-1">
                    <div>
                        <%=MobiletSystem.formatPrice(totalPrice+40E3)%>
                    </div>
                    <div>
                        تومان
                    </div>
                </div>
            </div>
        </div>
        <a href="./checkout.html" class="flex justify-center items-center opacity-90 my-5">
            <button
                class="px-7 py-2 text-center text-white bg-blue-500 align-middle border-0 rounded-lg shadow-md text-sm">تایید و
                پرداخت</button>
        </a>
    </div>
</div>