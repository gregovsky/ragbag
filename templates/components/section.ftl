[#compress]

[#include "../../../btk/includes/ftls/divClass.inc.ftl"]

[#assign page = cmsfn.page(content)]

[#if (content.@depth - page.@depth) == 2]
<div class="site-wrapper">
    <div class="container">
[/#if]


    [#if content.title?has_content]
        [#if content.titleSize?has_content && content.titleSize != "-"]
            [#assign titleSize = content.titleSize]
        [/#if]
        <div class="row">
            <div class="col-xs-12">
                <${titleSize!"h2"} class="heading"><span class="text-primary">${content.title}</span></${titleSize!"h2"}>
            </div>
        </div>
    [/#if]

    [#if !(content.layout?has_content)]
      [#assign colums = ["col-xs-12"]]
    [#else]
      [#assign colums = content.layout?split(",")]
    [/#if]

    <div class="${divClass!}">

      [#if colums?has_content ]
        [#assign total = colums?size!0]
        [#list colums as component]
          <div class="${component}">
            [@cms.area name="col"+(component_index+1) contextAttributes={"index":component_index,"total":total,"parity":(component_index % 2 == 0)?string("even","odd"),"has_next":component_has_next}/]
          </div>
        [/#list]
      [/#if]

    </div>


[#if (content.@depth - page.@depth) == 2]
    </div>
</div>
[/#if]
[/#compress]