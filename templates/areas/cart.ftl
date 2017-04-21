<div id="cartApp">
    <div class="site-wrapper cart [#if !cmsfn.isEditMode()]hide[/#if]" v-bind:class="{ show: cart.length > 0 }" >
        <div id="cart" class="anchor"></div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12">


                    <h1 class="heading">
                        <span class="text-primary">Obsah košíku</span> - {{ inCartValue() }},-
                    </h1>

                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th class="col_conf"></th>
                                    <th>Zboží</th>
                                    <th>Varianta</th>
                                    <th>Ks</th>
                                    <th class="col_price">Cena za ks</th>
                                    <th class="col_price">Cena</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(item,index) in cart">
                                    <td class="col_conf">
                                        <button type="button" class="btn btn-danger btn-xs"  v-on:click="removeFromCart(index)"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                                    </td>
                                    <td>{{ item.name }} </td>
                                    <td>{{ item.variant }}</td>
                                    <td>{{ item.pcs }}</td>
                                    <td class="col_price">{{ item.price }},-</td>
                                    <td class="col_price">{{ item.pcs * item.price }},-</td>

                                </tr>

                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

            [#-- DISCOUNT CODES --]

            <div class="row">




                <div class="col-xs-12">


                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th class="col_conf"></th>
                                <th>Doručení</th>
                                <th class="col_price"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="col_conf">

                                </td>
                                <td>
                                    <div class="form-group">
                                        <label for="discountCode" class="sr-only">Slevový kód</label>
                                        <input type="text" name="discountCode" class="form-control discountCode" v-model="discountCode" placeholder="Slevový kód">
                                        <button type="button" class="btn btn-default" v-bind:disabled="discountCode == ''" v-on:click="checkDiscount()">Ověřit</button>
                                        <span class="help-block"></span>
                                    </div>
                                </td>
                                <td class="col_price"><span v-if="discount > 0">- {{ discount }},-</span></td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>

            </div>

            [#--SHIPPING --]
            <div class="row">


                <script>

                    [#assign shippingOptions = cmsfn.contentByPath("/","shippings")]
                    [@compress single_line=true]
                        [#if cmsfn.children(shippingOptions,"shipping")?size > 0]
                            [#assign shippingOptions = cmsfn.children(shippingOptions,"shipping")]
                        var shippingOptions = [
                            [#list shippingOptions as option]
                                [#if option_index != 0],[/#if]
                                {name:'${option.name!""}',price:${option.price!"0"},freeFrom:${option.freeFrom!"''"},bankInfo:'${option.bankInfo?string!"false"}'}
                            [/#list]
                        ]
                        [/#if]
                    [/@compress]

                </script>

                <div class="col-xs-12">


                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th class="col_conf"></th>
                                <th>Doručení</th>
                                <th class="col_price">Cena</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="(item,index) in shippingOptions">
                                <td class="col_conf">
                                    <label class="radio-inline">
                                        <input type="radio" name="inlineRadioOptions" id="selectedDelivery" v-bind:value="index" v-model="selectedDelivery">
                                    </label>
                                </td>
                                <td>{{ item.name }}
                                    <p class="small" v-if="item.freeFrom">[cena: {{item.price}},- / nebo 0,- při objednávce nad {{item.freeFrom}},-]</p>
                                    <p class="small" v-else>[cena: {{item.price}},-]</p>
                                </td>
                                <td class="col_price">{{ selectedDelivery == index ? shippingPrice()+',-' : '' }}</td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>

            </div>


            <div class="row">

                <div class="col-xs-12">

                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th class="col_conf"></th>
                                <th>Adresa</th>
                            </tr>
                            </thead>
                        </table>
                    </div>

                </div>

                <div class="col-sm-6">

                    <div class="form-group">
                        <label for="name" class="sr-only">Jméno a přijmení</label>
                        <input type="text" name="name" class="form-control" v-model="user.name" placeholder="Jméno a přijmení">
                        <span class="help-block"></span>
                    </div>

                    <div class="form-group">
                        <label for="name" class="sr-only">Ulice a číslo popisné</label>
                        <input type="text" name="street" class="form-control" v-model="user.street" placeholder="Ulice a číslo popisné">
                        <span class="help-block"></span>
                    </div>

                    <div class="form-group">
                        <label for="name" class="sr-only">Město</label>
                        <input type="text" name="city" class="form-control" v-model="user.city" placeholder="Město">
                        <span class="help-block"></span>
                    </div>

                    <div class="form-group">
                        <label for="name" class="sr-only">Psč</label>
                        <input type="text" name="zip" class="form-control" v-model="user.zip" placeholder="Psč">
                        <span class="help-block"></span>
                    </div>

                </div>

                <div class="col-sm-6">

                    <div class="form-group">
                        <label for="email" class="sr-only">E-mail</label>
                        <input type="email" name="email" class="form-control" v-model="user.email" placeholder="E-mail">
                        <span class="help-block"></span>
                    </div>

                    <div class="form-group">
                        <label for="email" class="sr-only">Mobil</label>
                        <input type="email" name="phone" class="form-control" v-model="user.phone" placeholder="Mobil">
                        <span class="help-block"></span>
                    </div>

                    <div class="form-group">
                        <label for="message" class="sr-only">Vzkaz</label>
                        <textarea name="message" class="form-control" rows="4" v-model="user.message" placeholder="Vzkaz"></textarea>
                        <span class="help-block"></span>
                    </div>

                </div>

            </div>
            <div class="row">

                <div class="col-md-6 col-md-offset-3 col-xs-12 text-center">

                    <h3 class="heading"><span class="text-primary">Cena celkem:</span></h3>

                    <div class="h1">{{ (inCartValue() + shippingPrice()) }} Kč</div>

                    <p>Koncová cena včetně DPH.</p>

                    <p>Ještě nám zbývá dořešit několik technických detailů spojených s rozjezdem fan shopu, proto budeme moci veškeré objednávky začít rozesílat až v týdnu od 1. Května. Děkujeme za pochopení.</p>

                    <button type="button" class="btn btn-success"  v-on:click="sendOrder()">Závazně objednat</button>


                </div>

            </div>

        </div>
    </div>

    <modal v-if="showModal" @close="showModal = false"></modal>
</div>