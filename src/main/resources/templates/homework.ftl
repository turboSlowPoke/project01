<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css">
</head>
<body>
<#if homework??>
    <div class="py-1 pt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <a class="btn btn-primary" href="/admin" >Вернуться к списку групп </a>
                    <h2>Домашняя работа ${homework.id} </h2>
                    <h3>user #${homework.user.id}
                         <#if homework.user.userData.telegramNikcName??>${user.userData.telegramNikcName}<#else>@null</#if>
                         <#if homework.user.userData.firstName??>${user.userData.firstName}<#else></#if></h3>
                    <#if homework.files??>
                        <#list homework.files as file>
                            <img src="/homeworkfiles/${file}">
                        </#list>
                    </#if>

                </div>
            </div>
        </div>
    </div>
</#if>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>