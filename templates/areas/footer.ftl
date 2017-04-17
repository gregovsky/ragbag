<footer>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-6">
                [#if content.desc?has_content]
                    ${cmsfn.decode(content).desc}
                [/#if]
            </div>
            <div class="col-xs col-sm-6">
                <div class="social__items">
                    [#--<a href="#" class="social__item">--]
                        [#--<i class="fa fa-twitter"></i>--]
                    [#--</a>--]
                    [#--<a href="#" class="social__item">--]
                        [#--<i class="fa fa-facebook"></i>--]
                    [#--</a>--]
                    [#--<a href="#" class="social__item">--]
                        [#--<i class="fa fa-google-plus"></i>--]
                    [#--</a>--]
                    [@cms.area name="links"/]
                </div>
            </div>
        </div>
    </div>
</footer>