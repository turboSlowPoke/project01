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
                    <a class="btn btn-primary" href="/admin/unchecked_homeworks" >Вернуться к списку непроверенных ДЗ </a>
                    <h2>Домашняя работа id= ${homework.id} оценка: <#if homework.rating??>${homework.rating}<#else> не проверено</#if></h2>
                    <h3>user
                    <#if homework.user??>#${homework.user.id}
                        <#if homework.user.userData.telegramNikcName??>${user.userData.telegramNikcName}<#else>@null</#if>
                        <#if homework.user.userData.firstName??>${user.userData.firstName}<#else></#if>
                    </h3></#if>
                    <h3>Группа:
                        <#if homework.trainingGroup??>
                            #${homework.trainingGroup.id},
                             ${homework.trainingGroup.name},
                             <#if homework.trainingGroup.telegramName??>${homework.trainingGroup.telegramName}</#if>
                        </#if>
                    </h3>
                </div>
            </div>
        </div>
    </div>
<#if homework.body??>
    <div class="card p-2">
        <div class="card-body">
            ${homework.body}
        </div>
    </div>
</#if>
    <#if homework.files??>
        <div class="container">
            <#list homework.files as file>
                <div class="row pt-2">
                    <div class="col-md-12">
                        <img class="img-fluid" src="/homeworkfiles/${file}">
                    </div>
                </div>
            </#list>
        </div>
    </#if>
    <div class="container pt-3">
        <div class="row">
            <div class="col-md-5"></div>
            <div class="col-md-2">
                <form action="/admin/homework/${homework.id}">
                    <input type="number" class="form-control bfh-number" name="rating">
                    <button type="submit">Оценить</button>
                </form>
            </div>
            <div class="col-md-5"></div>
        </div>
    </div>

</#if>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>