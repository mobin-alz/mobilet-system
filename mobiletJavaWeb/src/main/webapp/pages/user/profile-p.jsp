<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<section>
   <div class="container">
      <div class="page-body bg-white p-3 rounded">
         <div class="row">
            <div class="col-12">
               <nav class="navbar navbar-expand-lg navbar-light bg-light">
                  <div class="container-fluid">
                  <a class="navbar-brand" href="./index.jsp?path=/user"><i class="bi bi-person"></i></a>
                     <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false"
                        aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                     </button>
                     <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav">
                           <a class="nav-link active" href="./index.jsp?path=/user/profile">پروفایل</a>
                           <a class="nav-link" href="./index.jsp?path=/purchaseHistory">سوابق پرداخت</a>
                           <a class="nav-link" href="./index.jsp?path=/favorits">علاقمندی ها</a>
                           <a class="nav-link" href="./index.jsp?path=/logout">خروج</a>
                        </div>
                     </div>
                  </div>
               </nav>
            </div>
         </div>
         <div class="user-profile-content p-3 border rounded mt-3">
            <div class="row justify-content-center">
               <div class="col-md-6 mb-2 mb-md-0">
                  <form action="">
                     <input type="text" placeholder="نام" value="آیدا">
                     <input type="text" placeholder="نام خانوادگی" value="نوبهار">
                     <input type="email" placeholder="ایمیل" value="info@test.ir">
                     <input type="password" placeholder="کلمه عبور" value="12345678">
                     <input type="password" placeholder="تکرار کلمه عبور">
                  </form>
               </div>
               <div class="col-md-6">
                  <form action="">
                     <div class="profile-pic-set d-flex mb-2 border-bottom">
                        <img src="assets/img/userAvatar.png" alt="" class="rounded" style="width: 55px; height: 60px;">
                        <label for="profilepic" class="w-100 py-3 ms-3"><i class="bi bi-camera fs-5"></i>&nbsp;انتخاب
                           تصویر پروفایل</label>
                        <input type="file" id="profilepic" class="d-none">
                     </div>
                     <input type="text" placeholder="آدرس شما ...">
                     <textarea placeholder="شرح حال من ..."></textarea>
                     <button>ذخیره اطلاعات حساب</button>
                  </form>
               </div>
            </div>
         </div>
      </div>
   </div>
</section>