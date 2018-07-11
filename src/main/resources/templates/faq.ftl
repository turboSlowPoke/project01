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
                    <a class="btn btn-outline-blue btn-sm" href="https://t.me/potvneskazutbot" title="Получить логин пароль у нашего бота" data-toggle="tooltip" data-placement="bottom"><i class="fab fa-telegram" aria-hidden="true"></i></a>
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
                    <a class="nav-link waves-effect " href="/about">О нас</a>
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
                <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                  <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">Вопрос 1</h5>
                  </div>
                  <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
                  <small>Donec id elit non mi porta.</small>
                </a>
                <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                  <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">Вопрос 2</h5>
                  </div>
                  <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
                  <small class="text-muted">Donec id elit non mi porta.</small>
                </a>
                <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                  <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">Вопрос 3</h5>
                  </div>
                  <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
                  <small class="text-muted">Donec id elit non mi porta.</small>
                </a>
                <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                  <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">Вопрос 4</h5>
                  </div>
                  <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
                  <small class="text-muted">Donec id elit non mi porta.</small>
                </a>
                <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                  <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">Вопрос 5</h5>
                  </div>
                  <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
                  <small class="text-muted">Donec id elit non mi porta.</small>
                </a>
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