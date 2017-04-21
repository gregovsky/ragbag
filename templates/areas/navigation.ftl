[#assign page = cmsfn.page(content)]
[#assign mainArea = cmsfn.contentByPath(page.@path + "/main")!]


<div id="navigation">

    <div class="navbar navbar-default navbar__initial navbar-fixed-top scrollspy_menu" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="http://www.ragbag.cz"><img src="${ctx.contextPath}/.resources/ragbag/webresources/img/logo_ragbag.png" alt="Ragbag logo" class="img-responsive"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="fullpage__nav nav navbar-nav navbar-right">

                    [#if mainArea?has_content && cmsfn.children(mainArea)?size > 0]
                        [#list cmsfn.children(mainArea) as row]
                            [#if row.toc?has_content ]
                                <li>
                                    <a href='#${row.toc?replace(" ","_")?replace("#","")}'>${row.toc!"NO_TOC_LABEL"}</a>
                                </li>
                            [/#if]
                        [/#list]
                    [/#if]

                    <li class="cart hide"  v-bind:class="{ show: cartApp.test != '' , disabled: cartApp.cart.length == 0 }">
                        <a href="#cart" >Košík
                            <span  v-if="cartApp.cart.length > 0" class="badge">{{ cartApp.cart.length }}</span>
                        </a>
                    </li>

                </ul>
            </div>
        </div>
    </div>



    <!-- Sidebar button open -->
    <div class="hidden sidebar__btn sidebar__btn_open">
        <span class="sidebar-btn__caption">Menu</span>
        <span class="oi oi-menu sidebar-btn__icon sidebar-btn-icon__unhover " title="Open menu" aria-hidden="true"></span>
        <span class="oi oi-arrow-left sidebar-btn__icon sidebar-btn-icon__hover" title="Open menu" aria-hidden="true"></span>
    </div>

    <!-- Sidebar menu -->
    <div class="sidebar__menu sidebar__menu_hidden scrollspy_menu">

        <!-- Sidebar button close -->
        <div class="sidebar__btn sidebar__btn_close">
            <span class="sidebar-btn__caption">Menu</span>
            <span class="oi oi-menu sidebar-btn__icon sidebar-btn-icon__unhover " title="Close menu" aria-hidden="true"></span>
            <span class="oi oi-arrow-right sidebar-btn__icon sidebar-btn-icon__hover" title="Close menu" aria-hidden="true"></span>
        </div>

        <!-- Sidebar brand name -->
        <div class="sidebar-menu__brand">
            <a class="navbar-brand" href="http://www.ragbag.cz">
                <img src="${ctx.contextPath}/.resources/ragbag/webresources/img/logo_ragbag.png" alt="Ragbag logo" class="img-responsive">
            </a>
        </div>

        <!-- Sidebar links -->
        <ul class="fullpage__nav sidebar-menu__ul nav">
            [#if mainArea?has_content && cmsfn.children(mainArea)?size > 0]
                [#list cmsfn.children(mainArea) as row]
                    [#if row.toc?has_content ]
                        <li>
                            <a href='#${row.toc?replace(" ","_")}'>${row.toc!"NO_TOC_LABEL"}</a>
                        </li>
                    [/#if]
                [/#list]
            [/#if]

        </ul>

    </div>

</div>