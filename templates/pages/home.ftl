<!DOCTYPE html>
[#compress]
<html xml:lang="${cmsfn.language()}" lang="${cmsfn.language()}">
   <head>
        [@cms.page /]
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>${content.windowTitle!content.title!}</title>
        <meta name="description" content="${content.description!""}" />
        <meta name="keywords" content="${content.keywords!""}" />
        <meta name="author" content="RagBag">

        ${resfn.css(["/ragbag/webresources/plugins/lightbox/css/lightbox.min.css",
                     "/ragbag/webresources/plugins/font-awesome/css/font-awesome.min.css",
                     "/ragbag/webresources/plugins/open-iconic/css/open-iconic-bootstrap.css",
                     "/ragbag/webresources/plugins/vue-animate/vue-animate.min.css",
                     "/ragbag/webresources/css/.*.css"])!}

        ${resfn.js(["/ragbag/webresources/js/jquery.min.js",
                    "/ragbag/webresources/js/vue.min.js",
                    "/ragbag/webresources/js/vue-resource.min.js"])!}

        <link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Oswald:400,700,300' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Anton|Comfortaa|Gruppo" rel="stylesheet">


        [@cms.area name="headerScripts"/]

   </head>
   <body class="classic home ${cmsfn.language()}" data-spy="scroll" data-target=".scrollspy_menu">
       [@cms.area name="bodyBeginScripts"/]

        [#if !cmsfn.isEditMode()]
        <div class="preloader">
          <img src="${ctx.contextPath}/.resources/ragbag/webresources/img/preloader.gif" alt="Loading..." class="preloader__img">
        </div>
        [/#if]

        [@cms.area name="navigation" /]

        [@cms.area name="intro" /]

        [@cms.area name="main"/]

        [@cms.area name="cart"/]

        [@cms.area name="footer"/]

        ${resfn.js(["/ragbag/webresources/js/bootstrap.js",
                  "/ragbag/webresources/plugins/smoothscroll/smoothscroll.min.js",
                  "/ragbag/webresources/plugins/waypoints/jquery.waypoints.min.js",
                  "/ragbag/webresources/plugins/imagesloaded/imagesloaded.pkgd.min.js",
                  "/ragbag/webresources/plugins/isotope/isotope.pkgd.min.js",
                  "/ragbag/webresources/plugins/lightbox/js/lightbox.min.js",
                  "/ragbag/webresources/js/custom.js",
                  "/ragbag/webresources/js/mgnl_rest_friendly_flatten.js",
                  "/ragbag/webresources/js/shop.js"])!}

       [@cms.area name="bodyEndScripts"/]

   </body>
</html>
[/#compress]
