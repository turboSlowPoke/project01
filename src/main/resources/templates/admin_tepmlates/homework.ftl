<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>По ТВ не скажут</title>
    <link rel="icon" href="/img/icon.png">

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="/css/mdb.min.css" rel="stylesheet">
    <!-- Your custom styles (optional) -->
    <link href="/css/style.css" rel="stylesheet">
</head>
<body>
<header class="mb-3">
    <nav class="navbar fixed-top navbar-expand-lg navAboutPage navbar-dark scrolling-navbar">
        <div class="container-fluid">
            <a class="navbar-brand waves-effect" href="/#">
                <strong>
                    Админский кабинет
                </strong>
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link waves-effect active grey darken-3 rounded rounded-2" href="/">Главная <span class="sr-only">(current)</span> </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link waves-effect" href="/about">О нас</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link waves-effect" href="/contacts">Контакты</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link waves-effect" href="/faq">FAQ</a>
                    </li>
                </ul>
            <#if user?? >
               <ul class="navbar-nav nav-flex-icons">
                   <li class="nav-item">
                       <b class="nav-link waves-effect" ">
                       <a href="/lk" title="В личный кабинет" data-toggle="tooltip" data-placement="bottom">
                           <i class="fas fa-user indigo-text mr-1" aria-hidden="true"></i>
                           <#if user.login??>${user.login}
                           <#elseif user.userData??&&user.userData.telegramNikcName??>
                               ${user.userData.telegramNikcName}
                           <#elseif user.userData.firstName??>${user.userData.firstName}
                           </#if>
                       </a>
                       </b>
                   </li>
                   <li class="nav-item">
                       <a href="/logout" class="nav-link border border-light rounded waves-effect">
                           <i class="fas fa-sign-out-alt orange-text mr-1" aria-hidden="true"></i>Выйти</a>
                   </li>
               </ul>
            <#else>
              <ul class="navbar-nav nav-flex-icons ">
                  <li class="nav-item">
                      <b class="nav-link waves-effect" ">
                      <a href="#" title="В личный кабинет" data-toggle="tooltip" data-placement="bottom">
                          <i class="fas fa-user indigo-text mr-1" aria-hidden="true"></i>
                          admin
                      </a>
                      </b>
                  </li>
                  <li class="nav-item">
                      <a href="/logout" class="nav-link border border-light rounded waves-effect">
                          <i class="fas fa-sign-out-alt orange-text mr-1" aria-hidden="true"></i>Выйти</a>
                  </li>
              </ul>
            </#if>
            </div>
        </div>
    </nav>
</header>
<a class="btn btn-primary" href="/admin/training/homeworks">Вернуться к списку непроверенных ДЗ </a>

<#if homework??>
    <div class="py-1 pt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <table class="table border border-info">
                                <thead>
                                <h3>Домашняя работа</h3>
                                <tr>
                                    <th>#id</th>
                                    <th>дата набора</th>
                                    <th>название</th>
                                    <th>#id название группы</th>
                                    <th>#id @telegram юзера</th>
                                </tr>
                                </thead>
                                <tr>
                                    <td>${homework.id}</td>
                                    <td>${homework.dateTimeOfCreation?date("yyyy-MM-dd")}</td>
                                    <td><#if homework.name??>${homework.name}</#if></td>
                                    <td>#${homework.trainingGroup.id} ${homework.trainingGroup.name}</td>
                                    <td>#<${homework.user.id} <#if homework.user.userData.telegramNikcName??>${homework.user.userData.telegramNikcName}</#if></td>
                                </tr>
                            </table>
                        </div>
                        <div class="card-body">
                            <#if homework.body??>
                                <div class="card mt-2">
                                    <div class="card-body">
                                        ${homework.body}
                                    </div>
                                </div>
                            </#if>
                            <#if homework.files??>
                                <div class="container">
                                    <#list homework.files as file>
                                        <div class="row ье-2">
                                            <div class="col-md-12">
                                                <img class="img-fluid" src="/homeworkfiles/${file}">
                                            </div>
                                        </div>
                                    </#list>
                                </div>
                            </#if>
                        </div>
                        <div class="card-footer">
                            <form action="/admin/homework/${homework.id}">
                                <div class="form-group">
                                    <label>Выберите оценку</label>
                                    <input type="number" class="form-control bfh-number" name="rating">
                                </div>
                                <button type="submit">Готово</button>
                            </form>
                        </div>
                    </div>
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