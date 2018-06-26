<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css">
</head>
<body>

<div class="py-1 pt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h3>Список заявок на выплату работ</h3>
                <a class="btn btn-primary" href="/admin" >Вернуться </a>
                     <#if payOutOrderList?? >
                             <table class="table">
                                 <thead>
                                 <tr>
                                     <th class="w-25">#id</th>
                                     <th>дата создания</th>
                                     <th>сумма</th>
                                     <th>@telegram юзера</th>
                                     <th>advcash</th>
                                     <th>ссылка</th>
                                 </tr>
                                 </thead>
                                 <tbody>
                                   <#list payOutOrderList as payOutOrder>
                                   <tr>
                                       <td>${payOutOrder.id}</td>
                                       <td>${payOutOrder.createDate?date("yyyy-MM-dd")}</td>
                                       <td>${payOutOrder.user.bonusWallet.usdBonus}</td>
                                       <td><#if payOutOrder.user.userData.telegramNikcName??>${payOutOrder.user.userData.telegramNikcName}</#if></td>
                                       <td><#if payOutOrder.user.userData.advcash??>${payOutOrder.user.userData.advcash}</#if></td>
                                       <td><a href="/admin/close_pay_out_order/${payOutOrder.id}">закрыть</a>
                                       </td>
                                   </tr>
                                   </#list>
                                 </tbody>
                             </table>
                     </#if>

            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>