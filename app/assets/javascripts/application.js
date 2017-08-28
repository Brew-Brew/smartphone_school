// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require sweetalert2
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


//Override the default confirm dialog by rails

$.rails.allowAction = function(link){
  if (link.data("confirm") == undefined){
    return true;
  }
  $.rails.showConfirmationDialog(link);
  return true;
}

//User click confirm button
$.rails.confirmed = function(link){
  link.data("confirm", null);
  link.trigger("click.rails");
}

//Display the confirmation dialog
$.rails.showConfirmationDialog = function(link){
  var message = link.data("confirm");
  swal({
    title: message,
    type: 'warning',
    confirmButtonText: 'Sure',
    confirmButtonColor: '#2acbb3',
    showCancelButton: false
  }).then(function(e){
    $.rails.confirmed(link);
  });
};


var printIndex = document.getElementsByClassName("indexNum")
var slideIndex = 1;
showSlides(slideIndex);

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  printIndex.write("인덱스"+slideIndex);
  dots[slideIndex-1].className += " active";
}

   function btnClick1()
  {
     swal({
  title: "정답입니다!",
  text: "잘하셨어요! 다른 문제도 풀어봐요!",
  type: "success",
  confirmButtonText: "다음문제"
}).then(function(){
    showSlides(slideIndex += 1);
    

})
  }
          
   function btnClick2()
  {
     sweetAlert("분발하세요ㅠ", "다시 한번 풀어봐요!", "error");
  }   
    function change1(obj){
        obj.style.background = '#83c9b0';
        obj.style.color = 'white';
    }


  function btnClick3() {
           swal({
  title: "정답입니다!",
  text: "잘하셨어요! 모든 연습문제를 푸셨어요!",
  confirmButtonText: "종료하기"
}).then(function(){
    $('#practice').modal('hide');
   
})
}
$('table tr').each(function(){
  $(this).find('th').first().addClass('first');
  $(this).find('th').last().addClass('last');
  $(this).find('td').first().addClass('first');
  $(this).find('td').last().addClass('last');
});

$('table tr').first().addClass('row-first');
$('table tr').last().addClass('row-last');