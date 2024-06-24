var swiper = new Swiper(".slide-container1", {
  slidesPerView: 4,
  spaceBetween: 16,
  sliderPerGroup: 4,
  loop: false,
  centerSlide: "true",
  fade: "true",
  grabCursor: "true",
  rtl: true,
  pagination: {
    el: ".swiper-pagination",
    clickable: true,
    dynamicBullets: true,
  },
  navigation: {
    nextEl: ".swiper-button-prev",
    prevEl: ".swiper-button-next",
  },
  breakpoints: {
    0: {
      slidesPerView: 2.2,
      spaceBetween: 4,
    },
    400: {
      slidesPerView: 2.5,
      spaceBetween: 6,
    },
    600: {
      slidesPerView: 3.6,
      spaceBetween: 8,
    },
    900: {
      slidesPerView: 4.5,
      spaceBetween: 16,
    },
    1060: {
      slidesPerView: 6,
      spaceBetween: 16,
    },
  },
});
