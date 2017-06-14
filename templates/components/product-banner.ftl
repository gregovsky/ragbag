[#compress]

[#if content.background?has_content && damfn.getAsset(content.background)?has_content]
    [#assign backgroundLink = damfn.getAssetLink(content.background)]
[/#if]


[#if content.product?has_content && cmsfn.contentById(content.product, "products")?has_content]
    [#assign product = cmsfn.contentById(content.product, "products")]
    [#assign productId = product.@id?substring(0,8)]
[/#if]


<div id="product_${productId}"
     class="site-wrapper [#if backgroundLink?has_content]withBackground[/#if]"
     style="background-image: url(${ctx.contextPath}/.resources/ragbag/webresources/img/bg-pattern.png), url(${backgroundLink!});"
     itemscope itemtype="http://schema.org/Product">


    <div id="[#if content.toc?has_content]${content.toc?replace(" ","_")?replace("#","")}[/#if]" class="anchor"></div>

    <div class="container">
        <div class="row">
            <div class="col-xs-12">


            </div>
        </div>

        <div class="row">


            <div class="col-sm-4">

                [#if product.images?has_content && product.images?size > 0]
                    <div id="carousel-image-${product.@name}" class="carousel slide productImage" data-ride="carousel" data-interval="">


                        <ol class="carousel-indicators">
                            [#list product.images as image]
                                [#if damfn.getAssetLink(image)?has_content]
                                     <li data-target="#carousel-image-${product.@name}" data-slide-to="${image_index}" class="[#if image_index == 0]active[/#if]"></li>
                                [/#if]
                            [/#list]
                        </ol>


                        <div class="carousel-inner" role="listbox">
                        [#list product.images as image]
                            [#if damfn.getAssetLink(image)?has_content]
                                <div class="item [#if image_index == 0]active[/#if]">
                                    <a href="${damfn.getAssetLink(image)!}" data-lightbox="images_${content.@id}" data-title="${product.name!}">
                                        <img src="${damfn.getAssetLink(image,"360x360")!}" alt="..." class="img-responsive" >
                                        <span itemprop="image" content="http://www.ragbag.cz${damfn.getAssetLink(image)!}"
                                    </a>
                                </div>
                            [/#if]
                        [/#list]
                        </div>
                    </div>
                [/#if]


            </div>

            <div class="col-sm-6 text-center product" rb-product="${product.name!}" rb-productId="${product.@id!}">


                <h2 class="heading" >${product.name!}</h2>
                <span itemprop="name" content="${product.seoName!product.name!}"></span>

                <p class="productDesc" itemprop="description">
                    ${product.desc!}
                </p>

                <div class="hide" v-bind:class="{ show: variants.length > 0 }">
                    <div class="productVariants">
                        <ul>
                            <li v-for="(item, index) in variants">
                                <button type="button" class="btn btn-primary variantButton" v-bind:class="{ active: item.selected }" v-on:click="variantButtonClick(index)" v-html="replaceItemVariant(item.variant)"></button>
                            </li>
                        </ul>
                    </div>
                    <div v-if="price > 0" class="productPrice">
                        {{ price }},-
                    </div>
                    <div v-else class="productPrice" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                        od {{ lovestPrice }},-
                        <span itemprop="price" content="300" v-bind:content="lovestPrice" ></span>
                        <span itemprop="priceCurrency" content="CZK"></span>
                        <span itemprop="availability" href="http://schema.org/InStock"></span>
                    </div>
                    <div class="productOrder">
                        <span>Koupit kusů:</span>
                        <input type="text" class="form-control pcsField" v-model="pcs" :disabled="price==0" />
                        <button type="button" class="btn addToCart"  v-on:click="addButtonClick()" :disabled="price==0">
                            <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
                        </button>
                    </div>
                </div>

            </div>


        </div>
    </div>
</div>

<script src="${cmsfn.link(content)?replace('.html','.js')}"></script>
[/#compress]
