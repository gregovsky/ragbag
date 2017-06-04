<html>
<header>

</header>
<body>
    <h1>Objednavka z ragbag.cz (${order!})</h1>

    <h3>Objednané zboží:</h3>

    [#if data?has_content]
        [#if data.cart?has_content && data.cart?size > 0]
            <table width="100%">
                <thead>
                    <tr style="background-color: #dddddd; border-bottom: 2px solid #000000;">
                        <td style="border-bottom: 2px solid #000000; padding: 8px; text-transform: uppercase;">zboží</td>
                        <td style="border-bottom: 2px solid #000000; padding: 8px; text-transform: uppercase;">varianta</td>
                        <td style="border-bottom: 2px solid #000000; padding: 8px; text-transform: uppercase;">ks</td>
                        <td style="border-bottom: 2px solid #000000; padding: 8px; text-transform: uppercase;">cena</td>
                    </tr>
                </thead>
                <tbody>
                [#list data.cart as cartitem]
                    <tr style="[#if cartitem?is_even_item]background-color: #efefef;[/#if]">
                        <td style="padding: 8px;">${cartitem.name}</td>
                        <td style="padding: 8px;">${cartitem.variant}</td>
                        <td style="padding: 8px;">${cartitem.pcs}</td>
                        <td style="padding: 8px;">${cartitem.price * cartitem.pcs?number},-</td>
                    </tr>
                [/#list]
                </tbody>
                <tfoot>
                    [#if data.discountCode?has_content]
                    <tr style="background-color: #dddddd;">
                        <td colspan="3" style="padding: 8px; text-transform: uppercase;">Sleva</td>
                        <td style="padding: 8px;">${data.discount},-</td>
                    </tr>
                    [/#if]
                    <tr style="background-color: #dddddd;">
                        <td colspan="3" style="padding: 8px; text-transform: uppercase;">${data.shipping}</td>
                        <td style="padding: 8px;">${data.shippingPrice},-</td>
                    </tr>
                    <tr style="background-color: #dddddd;">
                        <td colspan="3" style="padding: 8px; text-transform: uppercase;">Celkem</td>
                        <td style="padding: 8px; font-weight: bold;">${data.totalWithShipping},-</td>
                    </tr>
                </tfoot>
            </table>
        [/#if]

        [#if data.shippingBankInfo?has_content && data.shippingBankInfo == "true"]
            <div style="border: 2px solid #bd0039; padding:8px;">Vybrali jste platbu předem, proto prosím zašlete částku ${data.totalWithShipping},- na účet 2701224807/2010 s variabilním symbolem ${order!} nejpozději do 7mi dnů. Až po přijetí platby Vám zašleme zboží. Děkujeme</div>
        [/#if]

        <h3>Adresa pro doručení:</h3>
        <div>
            <p><lable>Jméno a přijmení:</lable>${data.user.name}</p>
            <p><lable>Ulice a č. popisné:</lable>${data.user.street}</p>
            <p><lable>Město:</lable>${data.user.city}</p>
            <p><lable>PSČ:</lable>${data.user.zip}</p>
            <p><lable>Email:</lable>${data.user.email}</p>
            <p><lable>Mobil:</lable>${data.user.phone}</p>
            <p><lable>Zpráva:</lable>${data.user.message}</p>
        </div>

        <div>
            Pokud některé z údajů nesouhlasí, prosím kontaktujte nás na ragbagcz@gmail.com nebo +420776503701.
        </div>
        <div>
            Děkujeme za Vaši objednávku.
        </div>

    [/#if]
</body>
</html>
