
// 轮播图1
function pcBanner(){
    var mySwiper = new Swiper ('.pc-banner', {
        direction: 'horizontal',
        loop: true, // 循环模式选项
        slideActiveClass: 'swiper-slide-active',
        centeredSlides: true,
        slidesPerView: '2',
        spaceBetween: -200,//每个滑块距右边的距离
        autoplay: {
            delay: 3000,
            stopOnLastSlide: false,
            disableOnInteraction: false,
        },
        pagination: {
            el: '.swiper-pagination'
        },
    })
}

function banner(){
    var mySwiper = new Swiper ('.banner', {
        direction: 'horizontal',
        loop: true, // 循环模式选项
        autoplay:true,
        // 如果需要分页器
        pagination: {
            el: '.swiper-pagination'
        },
    })
}

/* 轮播图2 */
function swiper2(){
    var mySwiper = new Swiper ('.swiper-container2', {
        direction: 'horizontal',
        loop: true, // 循环模式选项
        // autoplay:true,
        // 如果需要分页器
        pagination: {
            el: '.swiper-pagination'
        },
    })
}

/* 轮播图3 */
function swiper3(){
    var mySwiper = new Swiper('.swiper-container3', {
        direction: 'horizontal',
        loop: true, // 循环模式选项
        slideActiveClass: 'swiper-slide-active',
        centeredSlides: true,
        slidesPerView: '2',
        spaceBetween: -200,//每个滑块距右边的距离
        autoplay: {
            delay: 3000,
            stopOnLastSlide: false,
            disableOnInteraction: false,
        },
        pagination: {
            el: '.swiper-pagination'
        },

    })
}
 //tab切换
 function tab(){
    $('.tab-nav a').click(function(){
        $(this).addClass('tab-active').siblings().removeClass('tab-active');
        $('.aui-nav-list-tab>div:eq('+$(this).index()+')').show().siblings().hide();
    })
 }


/* 
select级联
*/
function select(){
    var stateSelect = document.getElementById('selector1');
    var citySelect = document.getElementById('selector2');
    var perName = document.getElementsByClassName('per-name2')[0];
    var perText = document.getElementById('per-text');

    var citys = {
        '地点': ['固原市', ''],
        '主题': ['汉语言文化', '', ''],
        '时间': ['2019-05', '2019-04', '2019-03'],
        '状态': ['未授权', '已授权']
    };
    stateSelect.addEventListener('change', function(e) {
        citySelect.options.length = 0;
        if (stateSelect.selectedIndex) {
            perName.style.cssText = "opacity:1";
            perText.innerHTML = stateSelect.value +'&nbsp;&nbsp;:';

            var cityArr = citys[stateSelect.value];
            for (var i = 0; i < cityArr.length; i++) {
                citySelect.add(new Option(cityArr[i]));
            }
        }else{
            perName.style.cssText = "opacity:0";
        }
    });
}