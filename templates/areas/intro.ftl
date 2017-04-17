
[#if content.background?has_content && damfn.getAssetLink(content.background)?has_content]
    [#assign background = "background-image: url("+ctx.contextPath+"/.resources/ragbag/webresources/img/bg-pattern.png), url("+damfn.getAssetLink(content.background)+");"]
[/#if]

<div class="welcome_classic" id="welcome" style="${background!}">
    <div class="welcome-classic__inner">
        <div class="container">
            <div class="row">
                <div class="col-xs-12">

                    <!-- Pre heading -->
                    <p class="heading__pre">
                        <img src="${ctx.contextPath}/.resources/ragbag/webresources/img/logo_ragbag.png">
                    </p>

                    <!-- Heading -->
                    <h1 class="heading heading_lg">
                        <span class="text-primary">Přerov Mammoths</span> fan shop
                    </h1>



                </div>
            </div>
        </div>
    </div>
</div>
