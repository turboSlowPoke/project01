<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>По ТВ не скажут</title>
    <link rel="icon" href="/img/icon.png">
  <!-- Font Awesome -->

  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
  <!-- Bootstrap core CSS -->
  <link href="/css/bootstrap.min.css" rel="stylesheet">
  <!-- Material Design Bootstrap -->
  <link href="/css/mdb.css" rel="stylesheet">
  <!-- Your custom styles (optional) -->
  <link  href="/css/style.css" rel="stylesheet">
</head>

<body>

<nav class="navbar fixed-top navbar-expand-lg navbar-dark navAboutPage scrolling-navbar">
    <div class="container-fluid">
        <a class="navbar-brand waves-effect" href="/#" target="_blank">
            <strong>
                <i class="fas fa-tv" aria-hidden="true"></i>
                <i class="fas fa-chart-line" aria-hidden="true"></i>
            </strong>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link waves-effect" href="/">Главная  </a>
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
                   <li class="nav-item active grey darken-3 rounded rounded-2 mr-3">
                       <b class="nav-link waves-effect" ">
                       <i class="fas fa-user indigo-text mr-1" aria-hidden="true"></i>
                       <span class="sr-only">(current)</span>
                  <#if user.login??>${user.login}
                  <#elseif user.userData??&&user.userData.telegramNikcName??>
                      ${user.userData.telegramNikcName}
                  <#elseif user.userData.firstName??>${user.userData.firstName}
                  </#if>
                       </b>
                   </li>
                   <li class="nav-item">
                       <a href="/logout" class="nav-link border border-light rounded waves-effect">
                           <i class="fas fa-sign-out-alt orange-text mr-1" aria-hidden="true"></i>Выйти</a>
                   </li>
               </ul>
            <#else>
              <ul class="navbar-nav nav-flex-icons">
                  <li class="nav-item pr-lg-3">
                      <a href="#" class="nav-link"  title="Авторизоваться через Google" data-toggle="tooltip" data-placement="bottom">
                          <i class="fab fa-google" aria-hidden="true"></i>
                      </a>
                  </li>
                  <li class="nav-item">
                      <a href="#" class="nav-link border border-light rounded" title="Войти в личный кабинет" data-toggle="modal" data-placement="bottom" data-target="#signInModal">
                          <i class="fas fa-sign-in-alt pr-2" aria-hidden="true"></i>кабинет
                      </a>
                  </li>
              </ul>
            </#if>
        </div>
    </div>
</nav>

<hr class="mt-5">
<a class="btn btn-primary mt-5" href="/lk/list_my_homeworks"><i class="fas fa-arrow-circle-left"></i> список ваших ДЗ</a><br>
<a class="btn btn-primary" href="/lk"><i class="fas fa-arrow-circle-left"></i> личный кабинет</a>

<#if homework??>
<main class="mt-3">
    <div class="container">
        <div class="row">
            <div class="card">
                <div class="card-header text-center">
                    <i class="fas fa-chalkboard-teacher text-info mr-3 " aria-hidden="true"></i>Домашняя работа
                </div>
                <div class="card-body">
                    <div class="table-wrapper-2">
                        <table class="table table-responsive-md">
                            <tr>
                                <th scope="row">${homework.id}</th>
                                <td>${homework.dateTimeOfCreation}</td>
                                <td>${homework.name}</td>
                                <td><#if homework.rating??>${homework.rating}<#else>не проверено</#if></td>
                                <td><form action="/lk/delete_homework" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="hidden" name="id" value="${homework.id}">
                                    <a class="text red-text" href="#" onclick="this.parentNode.submit()" title="Удалить! Внимание удаление не отменить!" data-toggle="tooltip" data-placement="bottom"><i class="fas fa-times-circle" aria-hidden="true"></i></a>
                                </form></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="card">
                <div class="card-header"> Текст</div>
                <div class="card-body"><#if homework.body??>${homework.body}</#if> </div>
            </div>
        </div>
        <div class="row">
            <div class="card mt-3">
                <div class="card-header">Изображения</div>
                <div class="card-body">
                    <#if homework.files??>
                        <#list homework.files as file>
                            <img class="img-fluid my-2 py-2 border-default" src="/homeworkfiles/${file}">
                        </#list>
                    </#if>
                </div>
            </div>
        </div>
    </div>

</main>
<#else>
<p class="lead m-5 pt-5">Такого задания не существует</p>
</#if>


<footer class="text-center font-small mt-4 wow fadeIn fixedFooterForBigScreen">
    <!--Call to action-->
    <div class="footerUpSide">
        <hr class="my-4">
        <!--/.Call to action-->
        <!-- Social icons -->
        <div class="pb-4 footerMiddleSide text-white">
            <a href="https://vk.com/potvneskazut"><i class="fab fa-vk mr-3 text text-white"></i></a>
            <a href="https://www.youtube.com/channel/UCZNqVOAdOpUfbv4PLePXebQ"><i class="fab fa-youtube mr-3 text text-white"></i></a>
            <a href="https://t.me/potvneskazut"><i class="fab fa-telegram mr-3 text text-white"></i></a>
            <a href="https://www.instagram.com/kyzminpotv/"><i class="fab fa-instagram mr-3 text text-white"></i></a>
            <a href="https://viuly.io/channel/95347"><i class="fab fa-vine text text-white"></i></a
        </div>
    </div>

    <!-- Social icons -->
    <!--Copyright-->
    <div class="footerDownSide py-3 text-white" > © 2018 Copyright:
        <a href="#" class="text-white"> potvneskazut.ru </a>
    </div>
    <!--/.Copyright-->
</footer>

  <!-- JQuery -->
  <script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="/js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="/js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="/js/mdb.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <!-- Initializations -->
<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
</script>
</body>

</html>