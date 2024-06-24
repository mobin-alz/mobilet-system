
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
	return new bootstrap.Tooltip(tooltipTriggerEl)
});

jQuery('.responsive-menu-container ul li').has('ul').append("<span class='resp-menu-ul-show'><i class='bi bi-caret-down-fill'></i></span>");

jQuery('.responsive-menu-container ul li span.resp-menu-ul-show').click(function () {
	jQuery(this).prev('ul').slideToggle();
	jQuery(this).find('i').toggleClass('bi-caret-down-fill');
	jQuery(this).find('i').toggleClass('bi-caret-up-fill');
});

jQuery('#responsive_Menu_Btn').click(function () {
	jQuery('.responsive-menu-container').toggleClass('responsive-menu-show');
	jQuery('body,html').toggleClass('overflow-hidden');
});

jQuery('.close_responsive_Menu').click(function () {
	jQuery('.responsive-menu-container').removeClass('responsive-menu-show');
	jQuery('body,html').removeClass('overflow-hidden');
});


jQuery('.owl-carosel-box').owlCarousel({
    loop:true,
    margin:10,
    rtl:true,
    autoplay:true,
    responsiveClass:true,
    responsive:{
        0:{
            items:1,
        },
        600:{
            items:1,
        },
        1000:{
            items:1,
        }
    }
});



jQuery('.cat-carousel-box').owlCarousel({
    loop:true,
    margin:10,
    rtl:true,
    nav:false,
    autoplay:true,
    dots:true,
    responsiveClass:true,
    responsive:{
        0:{
            items:3,
        },
        600:{
            items:5,
        },
        1000:{
            items:5,
        }
    }
});