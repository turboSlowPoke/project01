<!DOCTYPE html>
<html>

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

<header>
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

<hr class="my-5">
<a class="btn <#if isMain??>btn-outline-primary<#else>btn-primary</#if>" href="/admin">Статистика</a>
<a class="btn <#if isSignals??>btn-outline-primary<#else>btn-primary</#if>" href="/admin/signals">Сигналы</a>
<a class="btn <#if isTraining??>btn-outline-primary<#else>btn-primary</#if>" href="/admin/training">Обучение</a>
<a class="btn btn-primary" href="/lk">Рефералка</a>
<a class="btn btn-primary" href="/lk">Контент</a>
<hr class="my-5">

<#--Статистика-->
<#if isMain??>
<div class="container">
    <div class="row">
        <div class="col-md12">
            <div class="card">
                <div class="card-header"> Статистика</div>
                <div class="card-body">
                    <p>Юзеров в базе = ${countAllUsers}</p>
                    <p>Активных подписок на сигналы = ${countActiveSubscribe}</p>
                    <p>Оплативших обучение = ${countUsersWithTraining}</p>
                </div>
            </div>
        </div>
    </div>
</div>
</#if>
<#--Сигналы-->
<#if isSignals??>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <#if signalsSended??>
                        <div class="card-header text-success"> Сигнал отправлен ${signalsSended} юзерам </div>
                    <#else>
                        <div class="card-header text-success"> Отправить сигнал </div>
                    </#if>
                    <div class="card-body">
                        <form id="signalsForm" method="post" action="/admin/send_signal">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="form-group"> <label>Заголовок</label>
                                <input name="header" type="text" class="form-control" id="signalHeader">
                            </div>
                            <div class="form-group"> <label>Текст сигнала</label>
                                <textarea name="body" class="form-control" id="signalBody" rows="7"></textarea>
                            </div>
                            <button type="submit">Отправить</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</#if>
<#--Обучение-->
<#if isTraining??>
    <a class="btn <#if isMainTraining??>btn-outline-info<#else>btn-info</#if> btn-sm" href="/admin/training">Основное</a>
    <a class="btn <#if isGroupTraining??>btn-outline-info<#else>btn-info</#if> btn-sm" href="/admin/training/group">Группы</a>
    <hr class="my-3">
    <#--основное-->
    <#if isMainTraining??>
    <#--Список групп-->
    <#if trainingGroupList?? && (trainingGroupList?size > 0)>
    <div class="container my-2">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">Список групп</div>
                    <div class="card-body">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>id</th>
                                <th class="w-25">дата</th>
                                <th>Название</th>
                                <th>Студетны</th>
                                <th> Ссылка</th>
                            </tr>
                            </thead>
                            <tbody>
                                <#list trainingGroupList as group>
                                <tr>
                                    <td>${group.id}</td>
                                    <td>${group.startSet} - ${group.endSet}</td>
                                    <td><#if group.name??>${group.name}</#if></td>
                                    <td><#if group.users??>${group.users?size}</#if></td>
                                    <th>
                                        <#if (group.users?? && group.users?size>0)>
                                            <a href="/admin/group/${group.id}" class="text text-success">подробнее</a>
                                        <#else>
                                        <a href="/admin/training/delete_group/${group.id}" class="text text-danger">Удалить</a>
                                        </#if>
                                    </th>
                                </tr>
                                </#list>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <hr class="my-2">
    </#if>
    <#--Список курсов-->
    <#if (coursesList?? && coursesList?size>0)>
    <div class="container my-2">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">Курсы</div>
                    <div class="card-body">
                        <table class="table">
                            <thead>
                            <tr>
                                <th class="w-25">id</th>
                                <th>Название</th>
                                <th>Описание</th>
                                <th>Стоимость</th>
                                <th>Удалить</th>
                            </tr>
                            </thead>
                            <tbody>
                                <#list coursesList as course>
                                <tr>
                                    <td>${course.id}</td>
                                    <td>${course.name}</td>
                                    <td>${course.description}</td>
                                    <td>${course.amount}</td>
                                    <th> <a href="/admin/training/delete_course/${course.id}" class="text text-danger">удалить</a> </th>
                                </tr>
                                </#list>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <hr class="my-2">
    </#if>
    <#--создание группы и курса-->
    <div class="container">
        <div class="row">
        <#--создать группу-->
            <div class="col-md-6">
                <div class="card border border-primary">
                    <div class="card-header">Создать группу</div>
                    <div class="card-body">
                        <form method="post" action="/admin/training/createGroup">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="form-group"><label>Выберите курс</label>
                                <select required name="courseId" class="form-control">
                    <#list coursesList as course>
                        <option value="${course.id}">${course.name}</option>
                    </#list>>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Название группы</label>
                                <input name="name" type="text" required class="form-control">
                            </div>
                            <div class="form-group">
                                <label>Дата начала набора</label>
                                <input name="startSet" type="date" class="form-control" required> </div>
                            <div class="form-group">
                                <label>Дата конца набора</label>
                                <input name="endSet" type="date" class="form-control" required> </div>
                            <button type="submit">Создать</button>
                        </form>
                    </div>
                </div>
            </div>
        <#--создать курс-->
            <div class="col-md-6">
                <div class="card border border-primary">
                    <div class="card-header">Создать курс</div>
                    <div class="card-body">
                        <form id="createTrainingGroup" method="post" action="/admin/training/createCourse">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="form-group">
                                <label>Название курса</label>
                                <input name="name" type="text" required class="form-control">
                            </div>
                            <div class="form-group"> <label>Описание</label>
                                <textarea name="description" class="form-control" rows="7"></textarea>
                            </div>
                            <div class="form-group"> <label>Стоимость</label>
                                <input required type="number" class="form-control bfh-number" name="amount">
                            </div>
                            <button type="submit">Создать</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</#if>
    <#--группы-->
    <#if isGroupTraining??>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <form id="formSelectGroup">
                    <div class="form-group">
                        <label for="selectGroupList">Выберите группу</label>
                        <select name="groupId" class="form-control" id="selectGroupList" onchange="selectGroupFunction()">
                            <#list trainingGroupList as group>
                                <option value="${group.id}">
                                    <table>
                                        <td>#${group.id}</td>
                                        <td class="text text-success">${group.startSet} - ${group.endSet}</td>
                                        <td class="text text-info"><#if group.name??>${group.name}</#if></td>
                                        <td class="text text-primary"><#if group.users??>${group.users?size}</#if></td>
                                    </table>
                                </option>
                            </#list>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-info">Открыть</button>
                </form>
                <script>
                    function selectGroupFunction() {
                        var form = document.getElementById("formSelectGroup");
                        var x = document.getElementById("selectGroupList").value;
                        form.action="/admin/training/group/"+x;
                    }
                </script>
            </div>
        </div>
    </div>
    </#if>

</#if>
<#--Домашние работы-->
<#if isHomeWorks??>

</#if>




  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>

</html>