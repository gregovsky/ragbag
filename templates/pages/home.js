
var cartApp = new Vue({
el: '#cartApp',
data: {
cart: JSON.parse(localStorage.getItem('cart')),
test: 'testik',
showAddressForm: false,
shippingOptions: shippingOptions,
},
methods: {

addToCartFunction: function(id,name,variant,price,pcs){
this.cart.push({id:id,name:name,variant:variant,price:price,pcs:pcs});
localStorage.setItem('cart', JSON.stringify(this.cart));
//console.log(this.cart);
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
return total;
},

}
});


var navigation = new Vue({
el: '#navigation'
});




