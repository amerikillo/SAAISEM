<%-- 
    Document   : barra
    Created on : 4/09/2014, 12:40:19 PM
    Author     : Sistemas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
        <meta charset="utf-8">
        <title>Bootply.com - Progress Bar</title>
        <meta name="generator" content="Bootply" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
        
        <!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        
        <!-- CSS code from Bootply.com editor -->
        
        <style type="text/css">
            .container {
    margin-top: 30px;
    width: 400px;
}
        </style>
    </head>
    <body>
        <div class="container">
    <div class="progress progress-striped active">
        <div class="bar" style="width: 0%;"></div>
    </div>
</div>
        
        <script type='text/javascript' src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>


        





        
        <!-- JavaScript jQuery code from Bootply.com editor  -->
        
        <script type='text/javascript'>
        
            $(document).ready(function(){

    var progress = setInterval(function() {
    var $bar = $('.bar');

    if ($bar.width()==400) {
        clearInterval(progress);
        $('.progress').removeClass('active');
    } else {
        $bar.width($bar.width()+40);
    }
    $bar.text($bar.width()/4 + "%");
}, 800);

});
        
        </script>
        
       
        
    </body>
</html>
