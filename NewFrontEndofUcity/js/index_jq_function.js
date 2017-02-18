$(function () { $(".lavaLamp").lavaLamp({ fx: "backout", speed: 700 }) });

$(document).ready(function () {
  //the navigation is selected to change color
  $("#navigation_list01").mouseover(function () {
    $("#navigation_list01").css("color", "#f9fff9");
  });
  $("#navigation_list01").mouseout(function () {
    $("#navigation_list01").css("color", "#70706e");
  });
  $("#navigation_list02").mouseover(function () {
    $("#navigation_list02").css("color", "#f9fff9");
  });
  $("#navigation_list02").mouseout(function () {
    $("#navigation_list02").css("color", "#70706e");
  });
  $("#navigation_list03").mouseover(function () {
    $("#navigation_list03").css("color", "#f9fff9");
  });
  $("#navigation_list03").mouseout(function () {
    $("#navigation_list03").css("color", "#70706e");
  });
  $("#navigation_list04").mouseover(function () {
    $("#navigation_list04").css("color", "#f9fff9");
  });
  $("#navigation_list04").mouseout(function () {
    $("#navigation_list04").css("color", "#70706e");
  });
  $("#navigation_list05").mouseover(function () {
    $("#navigation_list05").css("color", "#f9fff9");
  });
  $("#navigation_list05").mouseout(function () {
    $("#navigation_list05").css("color", "#70706e");
  });
  $("#navigation_list06").mouseover(function () {
    $("#navigation_list06").css("color", "#f9fff9");
  });
  $("#navigation_list06").mouseout(function () {
    $("#navigation_list06").css("color", "#70706e");
  });

  //end of the navigation is selected to change color


  //the Pictures be hidden
  $("#U_news_image01").mouseover(function () {
    $(".U_news_div").css("background-color", "#727272");
    $(".U_news_div").css("border-color", "#4c4c4c");
    $("#U_news_image01").css("color", "white");
    $("#U_news_image01").css("background-color", "#f8b042");
    $("#U_news_image01").css("border-color", "#f05b23");
});
$("#U_news_image01").mouseout(function () {
    $(".U_news_div").css("background-color", "#727272");
    $(".U_news_div").css("border-color", "#4c4c4c");
    $("#U_news_image01").css("color", "black");
    $("#U_news_image01").css("background-color", "#f8b042");
    $("#U_news_image01").css("border-color", "#f05b23");
});

  $("#U_news_image02").mouseover(function () {
    $(".U_news_div").css("background-color", "#727272");
    $(".U_news_div").css("border-color", "#4c4c4c");
    $("#U_news_image02").css("color", "white");
    $("#U_news_image02").css("background-color", "#f8b042");
    $("#U_news_image02").css("border-color", "#f05b23");
});
$("#U_news_image02").mouseout(function () {
    $(".U_news_div").css("background-color", "#727272");
    $(".U_news_div").css("border-color", "#4c4c4c");
    $("#U_news_image02").css("color", "black");
    $("#U_news_image02").css("background-color", "#f8b042");
    $("#U_news_image02").css("border-color", "#f05b23");
});

  $("#U_news_image03").mouseover(function () {
    $(".U_news_div").css("background-color", "#727272");
            
    $(".U_news_div").css("border-color", "#4c4c4c");
    $("#U_news_image03").css("background-color", "#f8b042");
    $("#U_news_image03").css("color", "white");
    $("#U_news_image03").css("border-color", "#f05b23");
  });

$("#U_news_image03").mouseout(function () {
    $(".U_news_div").css("background-color", "#727272");

    $(".U_news_div").css("border-color", "#4c4c4c");
    $("#U_news_image03").css("background-color", "#f8b042");
    $("#U_news_image03").css("color", "black");
    $("#U_news_image03").css("border-color", "#f05b23");
});
  $("#U_news_image04").mouseover(function () {
    $(".U_news_div").css("background-color", "#727272");
    $(".U_news_div").css("border-color", "#4c4c4c");
    $("#U_news_image04").css("color", "white");
    $("#U_news_image04").css("background-color", "#f8b042");
    $("#U_news_image04").css("border-color", "#f05b23");
});
$("#U_news_image04").mouseout(function () {
    $(".U_news_div").css("background-color", "#727272");
    $(".U_news_div").css("border-color", "#4c4c4c");
    $("#U_news_image04").css("color", "black");
    $("#U_news_image04").css("background-color", "#f8b042");
    $("#U_news_image04").css("border-color", "#f05b23");
});
  //end of the Pictures be hidden 

  //The pictures is change the color
  isImageHide = 0;
  $("#U_news_image01").click(function () {
    $(".hidden_news_son").hide("slow");
    if (isImageHide != 1) {
      $(".hidden_news_son01").show("slow");
      isImageHide = 1;
    }
    else
      isImageHide = 0;
  });
  $("#U_news_image02").click(function () {
    $(".hidden_news_son").hide("slow");
    if (isImageHide != 2) {
      $(".hidden_news_son02").show("slow");
      isImageHide = 2;
    }
    else
      isImageHide = 0;
  });
  $("#U_news_image03").click(function () {
    $(".hidden_news_son").hide("slow");
    if (isImageHide != 3) {
      $(".hidden_news_son03").show("slow");
      isImageHide = 3;
    }
    else
      isImageHide = 0;
  });
  $("#U_news_image04").click(function () {
    $(".hidden_news_son").hide("slow");
    if (isImageHide != 4) {
      $(".hidden_news_son04").show("slow");
      isImageHide = 4;
    }
    else
      isImageHide = 0;
  });
  //end of The pictures is change the color

});