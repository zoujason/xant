// global variables
var isIE8 = false;
var isIE9 = false;
var $windowWidth;
var $windowHeight;
var $pageArea;
var isMobile = false;

//Main Function
var Main = function () {
    //function to detect explorer browser and its version
    var runInit = function () {
        if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)) {
            var ieversion = new Number(RegExp.$1);
            if (ieversion == 8) {
                isIE8 = true;
            } else if (ieversion == 9) {
                isIE9 = true;
            }
        }
        if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
            isMobile = true;
        };
    };
    //function to reduce the size of the Main Menu
    var runNavigationToggler = function () {
        $('.clip-chevron-right-views').css({
            'display':'none'
        });
        $('.navigation-toggler').on('click', function () {
            if (!$('body').hasClass('navigation-small')) {
                $('body').addClass('navigation-small');
                $('.clip-chevron-left-views').css({
                    'display':'none'
                });
                $('.clip-chevron-right-views').css({
                    'display':'inline-block'
                });
            } else {
                $('body').removeClass('navigation-small');
                $('.clip-chevron-right-views').css({
                    'display':'none'
                });
                $('.clip-chevron-left-views').css({
                    'display':'inline-block'
                });
            };
        });
    };
    //function to activate the 3rd and 4th level menus
    var runNavigationMenu = function () {
        $('.main-navigation-menu li.active').addClass('open');
        $('.main-navigation-menu > li a').on('click', function () {
            if ($(this).parent().children('ul').hasClass('sub-menu') && ((!$('body').hasClass('navigation-small') || $windowWidth < 767) || !$(this).parent().parent().hasClass('main-navigation-menu'))) {
                if (!$(this).parent().hasClass('open')) {
                    $(this).parent().addClass('open');
                    $(this).parent().parent().children('li.open').not($(this).parent()).not($('.main-navigation-menu > li.active')).removeClass('open').children('ul').slideUp(200);
                    $(this).parent().children('ul').slideDown(200, function () {
                        runContainerHeight();
                    });
                } else {
                    if (!$(this).parent().hasClass('active')) {
                        $(this).parent().parent().children('li.open').not($('.main-navigation-menu > li.active')).removeClass('open').children('ul').slideUp(200, function () {
                            runContainerHeight();
                        });
                    } else {
                        $(this).parent().parent().children('li.open').removeClass('open').children('ul').slideUp(200, function () {
                            runContainerHeight();
                        });
                    }
                }
            }
        });
    };
    //function to adapt the Main Content height to the Main Navigation height
    var runContainerHeight = function () {
        mainContainer = $('.main-content > .container');
        mainNavigation = $('.main-navigation');
        if ($pageArea < 760) {
            $pageArea = 760;
        }
        if (mainContainer.outerHeight() < mainNavigation.outerHeight() && mainNavigation.outerHeight() > $pageArea) {
            mainContainer.css('min-height', mainNavigation.outerHeight());
        } else {
            mainContainer.css('min-height', $pageArea);
        };
        if ($windowWidth < 768) {
            mainNavigation.css('min-height', $windowHeight - $('body > .navbar').outerHeight());
        }
        $("#page-sidebar .sidebar-wrapper").css('height', $windowHeight - $('body > .navbar').outerHeight()).scrollTop(0).perfectScrollbar('update');
    };

    return {
        //main function to initiate template pages
        init: function () {
            runInit();
            runNavigationToggler();
            runNavigationMenu();
        }
    };
}();
