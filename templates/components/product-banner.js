[#if content.product?has_content && cmsfn.contentById(content.product, "products")?has_content]
    [#assign product = cmsfn.contentById(content.product, "products")]
    [#assign productId = product.@id?substring(0,8)]
[/#if]

var product_${productId} = new Vue({
    el: '#product_${productId}',
    data: {
        product: {id: '${product.@id}',name:'${product.name!product.@name}'},
        [#if product.variants?has_content && cmsfn.children(product.variants)?has_content]
        variants: [
        [#assign variants = cmsfn.children(product.variants)]
        [#list variants as variant]
            {variant:'${variant.variant!}',price:${variant.price!},onstock:${variant.onstock!},selected:false},
        [/#list]
        ],
        [/#if]
        lovestPrice: Infinity,
        price: 0,
        pcs: '',
    },
    mounted: function() {
        for( item in this.variants) {
            if( this.variants[item].price < this.lovestPrice) {
                this.lovestPrice = this.variants[item].price;
            }
        }
    },
    methods: {
        variantButtonClick: function (index) {
            for( item in this.variants) {
                this.variants[item].selected = false;
            }
            this.variants[index].selected = true;
            this.price = this.variants[index].price;
            this.pcs = 1;
        },

        addButtonClick: function() {
            var selected;
            for( let [index, item] in this.variants) {
                if(this.variants[index].selected == true) {
                    selected = index;
                }
            }
            if(selected){
                cartApp.addToCartFunction(this.product.id, this.product.name, this.variants[selected].variant, this.variants[selected].price, this.pcs);
            }
        },

        replaceItemVariant: function(variant){
            if (variant.indexOf('dámské') > -1){
                variant = variant.replace('dámské','<i class="fa fa-female" aria-hidden="true"></i>');
            }

            return variant;
        }
    },

});
