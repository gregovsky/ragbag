var cartApp = new Vue({
    el: '#cartApp',
    data: {
        cart: JSON.parse(localStorage.getItem('cart')),
        test: 'testik',
        shippingOptions: shippingOptions,
        selectedDelivery: -1,
        finalCheckMessages: [],
        user: (localStorage.getItem('user') != 'null' ? JSON.parse(localStorage.getItem('user')) : {} ),
        mgnl_friendly_json: null,
        showModal: false,
        modalHeader: "",
        modalBody: "",
        discountCode: "",
        discount: 0,
        discountPerc: 0,
    },
    methods: {

        addToCartFunction: function(id,name,variant,price,pcs){
            this.cart.push({id:id,name:name,variant:variant,price:price,pcs:pcs});
            localStorage.setItem('cart', JSON.stringify(this.cart));
        },

        dropCart: function(){
            this.cart = [];
            localStorage.setItem('cart', JSON.stringify(this.cart));
        },

        removeFromCart: function(i) {
            if (i > -1) {
                this.cart.splice(i, 1);
                localStorage.setItem('cart', JSON.stringify(this.cart));
            }
        },

        inCartValue: function(){
            var total = 0;
            for( let [index, item] in this.cart){
                total += this.cart[index].price * this.cart[index].pcs;
            }
            if(this.discountPerc > 0){
                this.discount = Math.floor((total / 100) * this.discountPerc);
            }
            if(this.discount > 0) {
                total -= this.discount;
            }
            return total;
        },

        shippingPrice: function(){
            if ( this.selectedDelivery > -1){
                var shipping = this.shippingOptions[this.selectedDelivery];
                if( this.inCartValue() < shipping.freeFrom  ){
                    return shipping.price;
                } else {
                    return 0;
                }
            } else {
                return 0;
            }
        },

        finalCheck: function() {
            var finalCheckMessages = [];

            if(this.selectedDelivery == -1) {
                finalCheckMessages.push("Vyberte způsob doručení.");
            }
            if(this.user.name == '') {
                finalCheckMessages.push("Zadejte prosím Vaše jméno.");
            }
            if(this.user.street == '') {
                finalCheckMessages.push("Zadejte prosím Vaši ulici.");
            }
            if(this.user.city == '') {
                finalCheckMessages.push("Zadejte prosím Vaše město.");
            }
            if(this.user.zip == '') {
                finalCheckMessages.push("Zadejte prosím Vaše PSC.");
            }
            if(this.user.email == '') {
                finalCheckMessages.push("Zadejte prosím Vaš e-mail.");
            }
            if(this.user.phone == '') {
                finalCheckMessages.push("Zadejte prosím Vaše mobilní číslo.");
            }

            if(finalCheckMessages.length > 0) {
                this.finalCheckMessages = finalCheckMessages;
                return false;
            } else {
                return true;
            }
        },

        sendOrder: function() {


            if( this.finalCheck()) {

                localStorage.setItem('user', JSON.stringify(this.user));

                var url = "http://localhost:8080/magnoliaAuthor/.rest/nodes/v1/orders";

                this.mgnl_friendly_json = mgnl_rest_friendly_flatten({cart: this.cart,
                                                    shipping: this.shippingOptions[this.selectedDelivery].name,
                                                    shippingPrice: this.shippingPrice(),
                                                    total: this.inCartValue(),
                                                    discount: this.discount,
                                                    totalWithShipping: (this.inCartValue() + this.shippingPrice()),
                                                    discountCode: this.discountCode,
                                                    user: this.user});


                this.$http.put(url,this.mgnl_friendly_json).then( function(response) {
                        if (response.status == 200) {
                            console.log("odeslano");
                            this.dropCart();
                            window.scrollTo(0, 0);
                            this.displayModal("Děkujeme","Vaše objednávka byla úspěšně odeslána.");
                        }
                    }, function(response) {
                        console.log("error status",response.status);
                        this.displayModal("Chyba","Bohužel se Vaši objednávku nepodařilo odeslat (kód chyby: "+response.status+"). Prosím zkuste to znovu později nebo nás kontaktujte přímo. Děkujeme.");
                    }
                );

            }

        },

        displayModal: function(modalHeader,modalBody) {
            this.modalHeader = modalHeader;
            this.modalBody = modalBody;
            this.showModal = true;
        },

        checkDiscount: function(){

            var url = "http://localhost:8080/magnoliaAuthor/.rest/nodes/v1/discountCodes/"+this.discountCode.toUpperCase()+"?depth=0&excludeNodeTypes=undefined&includeMetadata=false";

            this.$http.get(url).then( function(response) {
                // success callback
                if (response.status == 200) {

                    var node = response.body;
                    var properties = node.properties;

                    properties.forEach( function(item) {

                        if(item.name == "discount" && item.values[0] > 0) {
                            cartApp.discount = item.values[0];
                            cartApp.discountPerc = 0;
                        }
                        if(item.name == "discountPerc" && item.values[0] > 0) {
                            cartApp.discountPerc = item.values[0];
                            cartApp.discount = 0;
                        }

                    });

                    if( this.discount > 0 || this.discountPerc > 0){
                        this.displayModal("Sleva","Gratulujeme, máte slevu "+( this.discount > 0 ? this.discount+",-" : this.discountPerc+"%")+".");
                    }
                }

            }, function (response) {
                this.displayModal("Neplatný kód","Bohužel tento kód se nepodařilo ověřit.");
            });
        },

    }
});


var navigation = new Vue({
    el: '#navigation'
});

Vue.component('modal', {
    template:   '<transition name="modal">'+
                    '<div class="modal-mask">'+
                        '<div class="modal-wrapper">'+
                            '<div class="modal-container">'+
                                '<div class="modal-header">'+
                                    '<slot name="header"><h3>{{ cartApp.modalHeader }}</h3></slot>'+
                                    '<button type="button" class="close" @click="$emit(\'close\')"><span aria-hidden="true">&times;</span></button>' +
                                '</div>'+
                                '<div class="modal-body">'+
                                    '<slot name="body">{{ cartApp.modalBody }}</slot>'+
                                '</div>'+
                            '</div>'+
                        '</div>'+
                    '</div>'+
                '</transition>'
})




