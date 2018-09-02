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
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <!-- Material Design Bootstrap -->
  <link href="css/mdb.css" rel="stylesheet">
  <!-- Your custom styles (optional) -->
  <link  href="css/style.css" rel="stylesheet">
</head>

<body>
<div class="modal fade" id="signInModal" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Авторизация</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span> </button>
            </div>
            <div class="modal-body">
                <form action="/login" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group row">
                        <label for="exampleInputLogin" class="col-sm-2 col-form-label">Логин: </label>
                        <div class="col-sm-9">
                            <input type="text" name="username" class="form-control" id="exampleInputLogin" placeholder="login" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="exampleInputPassword1" class="col-sm-2 col-form-label">Пароль:</label>
                        <div class="col-sm-9">
                            <input type="password" name="password" class="form-control"  id="exampleInputPassword1" placeholder="password" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-sm">Войти</button>
                    <hr class="my-1">
                    Вы можете войти через Google:
                    <a class="btn btn-outline-red btn-sm" href="oauth2/authorization/google" title="Авторизоваться через Google" data-toggle="tooltip" data-placement="bottom"><i class="fab fa-google-plus-g" aria-hidden="true"></i></a><br>
                    Получить логин пароль в телеграм:
                    <a class="btn btn-outline-blue btn-sm" href="${botLink}" title="Получить логин пароль у нашего бота" data-toggle="tooltip" data-placement="bottom"><i class="fab fa-telegram" aria-hidden="true"></i></a>
                </form>
            </div>
            <div class="modal-bottom">
                <button class="btn btn-default float-right btn-sm" type="button" data-dismiss="modal">Закрыть</button>
            </div>
        </div>
    </div>
</div>

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
                    <a class="nav-link waves-effect " href="/">Главная </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link waves-effect " href="/about">Обо мне</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link waves-effect" href="/contacts">Контакты</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link waves-effect active grey darken-3 rounded rounded-2" href="/faq">FAQ<span class="sr-only">(current)</span></a>
                </li>
            </ul>
            <#if user?? >
               <ul class="navbar-nav nav-flex-icons">
                   <li class="nav-item">
                       <b class="nav-link waves-effect" ">
                       <i class="fas fa-user indigo-text mr-1" aria-hidden="true"></i>
                       <a href="/lk" title="В личный кабинет" data-toggle="tooltip" data-placement="bottom">
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
              <#--<li class="nav-item">-->
              <#--<a href="/oauth2/authorization/google" class="nav-link"  title="Авторизоваться через Google" data-toggle="tooltip" data-placement="bottom">-->
              <#--<i class="fab fa-google-plus-g " aria-hidden="true"></i>-->
              <#--</a>-->
              <#--</li>-->
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


  <main class="py-5 my-5">
    <div class="container">
      <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
          <div class="card">
            <div class="card-header">
              <h3>Частые вопросы</h3>
            </div>
            <div class="card-body">
              <div class="list-group">
                <div  class="border border-1 p-1 mb-2">
                  <div class="d-flex w-100 justify-content-between">
                    <h4 class="mb-1">Как зарегистрироваться на сайте?</h4>
                  </div>
                    <ul>
                    <li>
                        Вы можете использовать один из ваших аккаунтов google для быстрой регистрации
                    </li>
                    <li>
                        так же Вы можете получить логин и пароль в нашем телеграм боте по ссылке <a href="${botLink}" target="_blank">${botLink}</a>
                    </li>
                    </ul>
                </div>
                <div class="border border-1 p-1 mb-2">
                  <div class="d-flex w-100 justify-content-between">
                    <h4 class="mb-1">Не переходит в телеграм бот с сайта. Что делать?</h4>
                  </div>

                  <p class="mb-1">Как многие знают - телеграм блокируется роскомнадзором. Для того чтобы обойти блокировку необходимо сделать пару простых действий.
                    <ol>
                    <li>добавить приложение <a href="https://chrome.google.com/webstore/detail/touch-vpn/bihmplhobchoageeokmgbdihknkjbknd?hl=ru" target="_blank">TouchVPN</a> в Chrome</li>
                    <li>после установки - нажать на иконку приложения в правом верхнем углу</li>
                    <li>в окне приложения необходимо вызвать дополнительные параметры нажатием трех полосок <i class="fas fa-bars"></i></li>
                    <li>выбираем параметр <b>auto-protect websites</b></li>
                    <li> в поле <b>url</b> вводим данные ссылки
                        <ul>
                            <li>telegram.org</li>
                            <li>t.me</li>
                            <li>web.telegram.com</li>
                        </ul>
                        и для каждой ссылки нажимаем кнопку <b>Add</b>, чтобы наши ссылки добавились в список исключения. После этого данные ссылки блокироваться не будут. Вы так же можете таким образом добавить другие нужные вам сайты, которые блокирует роскомнадзор.</li>
                    </ol>
                  </p>
                </div>
                <div  class="border border-1 p-1 mb-2">
                  <div class="d-flex w-100 justify-content-between">
                    <h4 class="mb-1">Что входит в Сигнал Бот?</h4>
                  </div>
                  <p class="mb-1">Данный бот включает в себя подписки на самые топовые источники, в том числе зарубежные, общей суммой в 0,3 BTC в год. Список будет пополняться, если мы найдем еще подходящие источники. Для вас эта сумма получается в разы дешевле, и неизменной.
                      <br>
                      Предлагаем вам несколько видов подписки:
                      <ul>
                        <li>1 месяц = 50$</li>
                        <li>3 месяца = 100$</li>
                        <li>6 месяцев = 150$</li>
                      </ul>
                    Абсолютно каждый игрок рынка должен иметь достоверные источники получения информации, и данный бот может им стать для вас.</p>
                </div>
                <div  class="border border-1 p-1 mb-2">
                  <div class="d-flex w-100 justify-content-between">
                    <h4 class="mb-1">Что входит в таблицу Баунти?</h4>
                  </div>
                  <p class="mb-1">В данную таблицу мы собрали для вас информацию о самых перспективных баунти-компаниях. Которая постоянно обновляется и включает в себя:
                      <ul>
                        <li>Условия для участия</li>
                        <li>Форма отчета</li>
                        <li>Начало и окончание баунти-компании</li>
                      </ul>
                    Используя данную таблицу вы экономите очень много нервов и времени, т. к. весь поиск и отбор мы сделали за вас <i class="fas fa-smile"></i>
                    </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-1"></div>
      </div>
    </div>
  </main>
  <!--Main layout-->
  <!--Footer-->
<footer class="page-footer text-center font-small mt-4 wow fadeIn ">
    <!--Call to action-->
    <div class="footerUpSide">
        <div class="pt-4">
            <a class="btn btn-grey" href="#" role="button" data-toggle="modal" data-placement="bottom" data-target="#signInModal">Присоединиться &nbsp; &nbsp; &nbsp; &nbsp;
                <i class="fas fa-sign-in-alt ml-2"></i>
            </a>
        </div>
        <!--/.Call to action-->
        <hr class="my-4">
        <!-- Social icons -->
        <div class="pb-4 footerMiddleSide">
            <a href="https://vk.com/potvneskazut">                 <i class="fab fa-vk mr-3"></i>             </a>
            <a href="https://www.youtube.com/channel/UCZNqVOAdOpUfbv4PLePXebQ">                 <i class="fab fa-youtube mr-3"></i>             </a>
            <a href="https://t.me/potvneskazut"><i class="fab fa-telegram mr-3"></i></a>
            <a href="https://www.instagram.com/kyzminpotv/"><i class="fab fa-instagram mr-3"></i></a><a href="https://viuly.io/channel/95347"><i class="fab fa-vine"></i></a>
        </div>
    </div>

    <!-- Social icons -->
    <!--Copyright-->
    <div class="footerDownSide py-3" > © 2018 Copyright:
        <a href="#"> potvneskazut.ru </a>
    </div>
    <!--/.Copyright-->
</footer>
  <!--/.Footer-->
  <!-- SCRIPTS -->
  <!-- JQuery -->
  <script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="js/mdb.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <!-- Initializations -->
  <script type="text/javascript">
    // Animations initialization
    new WOW().init();
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
  </script>
</body>

</html>