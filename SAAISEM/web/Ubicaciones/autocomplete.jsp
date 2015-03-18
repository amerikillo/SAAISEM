<%-- 
    Document   : autocomplete
    Created on : 23/12/2013, 08:10:17 AM
    Author     : CEDIS TOLUCA3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <meta charset="utf-8">
    <link rel="shortcut icon" type="image/ico" href="img/Logo GNK claro2.jpg">
    <title>Marbetes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta content="Plugin Gratis para autocompletar un input con jQuery y Ajax" name="description" />
    <!-- Cargar CSS aquí -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="css/flat-ui.css" rel="stylesheet">
    <link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/gnkl_style_default.css" rel="stylesheet">
    
        <link rel="stylesheet" href="js_auto/jquery-ui.css">
        <script src="js_auto/jquery-1.9.1.js"></script>
        <script src="js_auto/jquery-ui.js"></script>
        <link rel="stylesheet" href="js_auto/style.css">
        <title>JSP Page</title>
    <script>
 /* $(function() {
    var availableTags = [
      "ActionScript",
      "AppleScript",
      "Asp",
      "BASIC",
      "C",
      "C++",
      "Clojure",
      "COBOL",
      "ColdFusion",
      "Erlang",
      "Fortran",
      "Groovy",
      "Haskell",
      "Java",
      "JavaScript",
      "Lisp",
      "Perl",
      "PHP",
      "Python",
      "Ruby",
      "Scala",
      "Scheme"
    ];
    alert(availableTags);
    $( "#tags" ).autocomplete({
      source: availableTags
    });
  });*/
  </script>
</head>
<body>
 
<div>
  <label>Tags: </label>
  <input id="tags" onKeyUp="Unidad()">
</div>
 
    <script src="js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="js/jquery.ui.touch-punch.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.placeholder.js"></script>

    <!-- scripts aquí para mejorar rendimiento -->
    <script>
      	$("footer").load("footer.html");
    </script>
           
    <script>
        function Unidad(){
           var text = $("#tags").val();
           var dir = 'jsp/consultas.jsp?ban=28&text='+text+''
                    $.ajax({
                        url: dir,
                        type: 'json',
                        async: false,
                        success: function(data){
                            MostrarDatos(data);
                        }, 
                                error: function() {
                            alert("Ha ocurrido un error");	
                        }
                    });
                   function MostrarDatos(data){
                       var x = 0;
                       var unid="unid";
                       var json = JSON.parse(data);
                       for(var i = 0; i < json.length; i++) {
                           x++;
                           var uni = json[i].unidad;
                           //var c = unid+x;
                           if (x < json.length){
                               if (x == 1){
                                   var unid1 = uni;
                               }else if (x == 2){
                               var unid2 = uni;
                               }else if (x == 3){
                               var unid3 = uni;
                               }else if (x == 4){
                               var unid4 = uni;
                               }else if (x == 5){
                               var unid5 = uni;
                               }else if (x == 6){
                               var unid6 = uni;
                               }else if (x == 7){
                               var unid7 = uni;
                               }else if (x == 8){
                               var unid8 = uni;
                               }else if (x == 9){
                               var unid9 = uni;
                               }
                           }else{
                              var unid10 = uni;
                           }
                           if (json.length == 1){
                               var availableTags = [unid10];
                           }else if (json.length == 2){
                               var availableTags = [unid1,unid10];
                           }else if (json.length == 3){
                               var availableTags = [unid1,unid2,unid10];
                           }else if (json.length == 4){
                               var availableTags = [unid1,unid2,unid3,unid10];
                           }else if (json.length == 5){
                               var availableTags = [unid1,unid2,unid3,unid4,unid10];
                           }else if (json.length == 6){
                               var availableTags = [unid1,unid2,unid3,unid4,unid5,unid10];
                           }else if (json.length == 7){
                               var availableTags = [unid1,unid2,unid3,unid4,unid5,unid6,unid10];
                           }else if (json.length == 8){
                               var availableTags = [unid1,unid2,unid3,unid4,unid5,unid6,unid7,unid10];
                           }else if (json.length == 9){
                               var availableTags = [unid1,unid2,unid3,unid4,unid5,unid6,unid7,unid8,unid10];
                           }else if (json.length == 10){
                               var availableTags = [unid1,unid2,unid3,unid4,unid5,unid6,unid7,unid8,unid9,unid10];
                           } 
                               
                           
                           
                           $( "#tags" ).autocomplete({
                               source: availableTags
                           }); 

                       } 
                       
        }
        
        };
    
    </script>
    
    
    </body>
</html>
