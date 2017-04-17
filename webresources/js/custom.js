/*------------------------------------------------------------------
Project:        Wolfram
Author:         Yevgeny Simzikov
URL:            http://simpleqode.com/
                https://twitter.com/YevSim
                https://www.facebook.com/simpleqode
Version:        2.2.2
Created:        18/08/2014
Last change:    07/07/2016
-------------------------------------------------------------------*/

/* -------------------- *\
    GENERAL
\* -------------------- */

/**
 * Preloader
 */

$(window).load(function() {

    $('.preloader__img').fadeOut(500);
    setTimeout(function() {
        $('.preloader').addClass('active').delay(1000).fadeOut(500);
    }, 1000);

});


/**
 * Sidebar
 */

 $(function() {

    $(".sidebar__btn").on('click', function() {
        $(".sidebar__btn_open").toggleClass("show hidden");
        $(".sidebar__menu").toggleClass("sidebar__menu_hidden");
        return false;
    });

});


/**
 * Navbar
 */

// Collapse navbar back on a link click

$(function() {

    $('.navbar-collapse li > a').on('click', function() {
        if ($('.navbar-collapse').attr("aria-expanded")) {
            $('.navbar-collapse.in').collapse('hide');
        }
    });

});


/**
 * Isotope filtering
 */

$(function() {

    // init Isotope
    var $container = $('.portfolio__items').imagesLoaded( function() {
        $container.isotope({
            itemSelector: '.filter__item',
            layoutMode: 'fitRows'
        });
    });
    // filter items on button click
    $('.portfolio__nav > a').on('click', function() {
        var filterValue = $(this).attr('data-filter');
        $container.isotope({ filter: filterValue });
        return false;
    });

});


/**
 * Text rotator (requires morphext.js, morphext.css, animate.css)
 */

$(function() {

    if ( $(".js-rotating").length ) {
        $(".js-rotating").Morphext({
            animation: "fadeIn", // default "bounceIn"
            separator: "|", // default ","
            speed: 4000 // default 2000
        });
    }

});


/* -------------------- *\
    CLASSIC LAYOUT
\* -------------------- */

if ( $("body.classic").length ) {

    /**
     * Make navbar active 
     */

    $(function() {

        $("body").waypoint(function() {
            $(".navbar").toggleClass("navbar__initial");
            return false;
        }, { offset: "-20px" });

    });


    /**
     * Change sidebar link color
     */

    $(function() {

        $("body").waypoint(function() {
            $(".sidebar__btn").toggleClass("sidebar__btn_alt");
            return false;
        }, { offset: "-100%" });

    });


    /**
     * Smooth scroll to anchor
     */

    $(function() {

        $('a[href*="#"]:not([href="#"])').click(function() {

          if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
            
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');

              if (target.length) {
                $('html, body').animate({
                  scrollTop: target.offset().top
                }, 1000);
                return false;
              }

          }
        });

    });

}



/* -------------------- *\
    CROSSFADING & SLIDING LAYOUTS
\* -------------------- */

$(document).ready(function() {

    if( $("#fullpage").length ) {

        if ( $(".backstretch-carousel").length ) {

            // Init Backstretch

            $(".backstretch-carousel").backstretch([
                "assets/img/screen-bg_1.jpg",
                "assets/img/screen-bg_2.jpg",
                "assets/img/screen-bg_3.jpg",   
                "assets/img/screen-bg_4.jpg",   
                "assets/img/screen-bg_5.jpg",   
                "assets/img/screen-bg_6.jpg", 
                "assets/img/screen-bg_7.jpg" 
            ], {duration: 1000, fade: 700});

            // Pause Backstretch

            $(".backstretch-carousel").backstretch("pause");

        }

        var isToucheDevice = !!('ontouchstart' in window || navigator.maxTouchPoints);

        $('#fullpage').fullpage({

            // Plugin setup
            
            // Navigation
            anchors: ['welcome', 'about', 'portfolio', 'pricing', 'team', 'features', 'contact'],
            menu: '.fullpage__nav',
            slidesNavigation: 'true',

            // Custom selectors
            sectionSelector: '.site-wrapper',
            slideSelector: '.site-wrapper__slide',

            // Scrolling
            scrollOverflow: true,
            scrollOverflowOptions: {
              click: isToucheDevice
            },

            // Design
            paddingTop: '0',
            paddingBottom: '0',

            onLeave: function(index, nextIndex, direction){

                // Make navbar active after leaving 1st section

                if(index == 1 && nextIndex != 1){
                    $(".navbar").toggleClass("navbar__initial");
                }

                if(index != 1 && nextIndex == 1){
                    $(".navbar").toggleClass("navbar__initial");
                }

                // Change Backstretch image on fullPage scroll

                if ( $(".backstretch-carousel").length ) {

                    $(".backstretch-carousel").backstretch("show", nextIndex-1);

                }
            }

        });

    };

});