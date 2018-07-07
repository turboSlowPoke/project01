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
          Также вы можете войти через Google:
          <a class="btn btn-outline-red btn-sm" href="/oauth2/authorization/google" title="Авторизоваться через Google" data-toggle="tooltip" data-placement="bottom"><i class="fab fa-google-plus-g" aria-hidden="true"></i></a><br>
          Получить логин пароль в телеграм:
          <a class="btn btn-outline-blue btn-sm" href="#" title="Получить логин пароль у нашего бота" data-toggle="tooltip" data-placement="bottom"><i class="fab fa-telegram" aria-hidden="true"></i></a>
        </form>
      </div>
      <div class="modal-bottom">
        <button class="btn btn-default float-right btn-sm" type="button" data-dismiss="modal">Закрыть</button>
      </div>
    </div>
  </div>
</div>

<nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar">
    <div class="container-fluid">
        <a class="navbar-brand waves-effect" href="/#">
            <strong>
                <i class="fas fa-tv text-white" aria-hidden="true"></i>
                <i class="fas fa-chart-line text-white" aria-hidden="true"></i>
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
                      <a href="#" class="nav-link border border-light rounded" title="Войти в личный кабинет" data-toggle="modal" data-placement="bottom" data-target="#signInModal">
                          <i class="fas fa-sign-in-alt pr-2" aria-hidden="true"></i>кабинет
                      </a>
                  </li>
              </ul>
            </#if>
        </div>
    </div>
</nav>

<div class="wrapperheader">
    <div class="headerimagewrapper">
        <img class="imgForBigScreen" src="/img/shapka.jpg">
        <img class="imgForLittleScreen"  src="/img/shapka_obrez.jpg">
        <img class="imgForVeryBigScreen" src="/img/shpaka_for_very_big_screen.jpg">
    </div>
</div>


  <main>
    <div class="container">
      <!--Section: Main info-->
      <section class="mt-5 wow fadeIn">
        <!--Grid row-->
        <div class="row">
          <!--Grid column-->
          <div class="col-md-6 mb-4">
            <div class="embed-responsive embed-responsive-16by9">
              <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/cXTThxoywNQ" allowfullscreen=""></iframe>
            </div>
          </div>
          <!--Grid column-->
          <!--Grid column-->
          <div class="col-md-6 mb-4">
            <!-- Main heading -->
              <strong>
                  Весь мир помешался на криптовалютах, а ты до сих пор не знаешь с какой стороны к ним подойти?
                  Боишься, что начинать уже поздно и твои деньги улетят в трубу?
                  <hr>
                  Меня зовут Кирилл Кузьмин и я могу научить тебя как заработать свои первые токены без рисков и вложений.
                  На моем канале ты найдешь много полезной и интересной информации о мире криптовалют.
                  Развиваться в этой сфере я начал еще в 19 лет, а в 20 уже заработал свой первый миллион, с удовольствием делюсь полученными знаниями и опытом с желающими увеличить свой доход.
              </strong>
              </p>
              <!-- Main heading -->
              <hr>
              <p>
                  <strong>
                      Новости, обзоры монет, платформ и все виды заработка на Blokchain, о которых не скажут по ТВ!<br>
                      Для тех, кто не готов тратить свое время на поиск и обработку огромного количества информации,
                      мы с командой подготовили обучение, где просто и доступно расскажем как  зарабатывать от 500$ в месяц, проводя время в своих любимых соцсетях.
                  </strong>
              </p>
            <!-- CTA -->
            <a href="#" class="btn btn-grey btn-md" data-toggle="modal" data-placement="bottom" data-target="#signInModal">присоединиться <i class="fas fa-sign-in-alt pl-2" aria-hidden="true"></i></a>
          </div>
          <!--Grid column-->
        </div>
        <!--Grid row-->
      </section>
      <!--Section: Main info-->
      <hr class="my-5">
      <!--Section: Not enough-->
      <section class="wow">
        <h3 class="h3 text-center mb-5 ">Цены</h3>
        <div class="py-5 bg-secondary wow ">
          <div class="container">
            <div class="row wow fadeIn">
              <div class="p-3 align-self-center col-md-6">
                <div class="card">
                  <div class="card-header wow">
                    <div class="container">
                      <div class="row">
                        <div class="col-md-3">
                          <img class="img-fluid " src="img/img_for_sales.jpg">
                        </div>
                        <div class="col-md-9">
                          <h3>Сигналы</h3>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="card-block p-5">
                    <p>Наши супер сигналы бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла
                      бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла</p>
                    <hr>
                    <a href="#" class="btn btn-dark" data-toggle="modal" data-placement="bottom" data-target="#signInModal"><b>$10</b>&nbsp; купить</a>
                  </div>
                </div>
              </div>
              <div class="p-3 align-self-center col-md-6">
                <div class="card">
                  <div class="card-header align-content-center">
                    <div class="container">
                      <div class="row">
                        <div class="col-md-3">
                          <img class="img-fluid " src="img/img_for_sales.jpg">
                        </div>
                        <div class="col-md-9">
                          <h3>Обучение</h3>
                        </div>
                      </div>
                    </div>


                  </div>
                  <div class="card-block p-5">
                    <p>Наш супер курс  бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла
                      бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла</p>
                    <hr>
                    <a href="#" class="btn btn-dark" data-toggle="modal" data-placement="bottom" data-target="#signInModal"><b>$20&nbsp;</b> купить</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!--Section: Not enough-->
      <hr class="mb-5">
      <!--Section: More-->
      <section class="wow">
        <h2 class="my-5 h3 text-center">Я в соцсетях:</h2>
          <div class="container">
              <div class="row">
                  <div class="col-md-1"></div>
                  <div class="col-md-4">
                      <div class="row">
                          <div class="col-2">
                              <i class="fab fa-vk fa-2x mb-1 blue-text" aria-hidden="true"></i>
                          </div>
                          <div class="col-10 mb-2">
                              <h5 class="feature-title font-bold mb-1">Группа вконтакте</h5>
                              <p class="grey-text mt-2">Ежедневный новостной дайджест и конкурсы с приятными призами. </p>
                          </div>
                      </div>
                  </div>
                  <div class="col-md-2"></div>
                  <div class="col-md-4">
                      <div class="row">
                          <div class="col-2">
                              <i class="fab fa-youtube fa-2x mb-1 red-text" aria-hidden="true"></i>
                          </div>
                          <div class="col-10 mb-2">
                              <h5 class="feature-title font-bold mb-1">Канал на youtube</h5>
                              <p class="grey-text mt-2">Все о криптовалютах и биткоине, а так же обзоры перспективных альткоинов.</p>
                          </div>
                      </div>
                  </div>
                  <div class="col-md-1"></div>
              </div>
              <div class="row">
                  <div class="col-md-1"></div>
                  <div class="col-md-4">
                      <div class="row">
                          <div class="col-2">
                              <i class="fab fa-telegram fa-2x mb-1 indigo-text" aria-hidden="true"></i>
                          </div>
                          <div class="col-10 mb-2">
                              <h5 class="feature-title font-bold mb-1">Канал в телеграм</h5>
                              <p class="grey-text mt-2">Бесплатные айрдропы, легкие деньги без вложений. </p>
                          </div>
                      </div>
                  </div>
                  <div class="col-md-2"></div>
                  <div class="col-md-4">
                      <div class="row">
                          <div class="col-2">
                              <i class="fab fa-instagram fa-2x mb-1 blue-grey-text" aria-hidden="true"></i>
                          </div>
                          <div class="col-10 mb-2">
                              <h5 class="feature-title font-bold mb-1">Я в инстаграм</h5>
                              <p class="grey-text mt-2">Немного обо мне и моей жизни</p>
                          </div>
                      </div>
                  </div>
                  <div class="col-md-1"></div>
              </div>
          </div>
      </section>
    </div>
  </main>
  <!--Main layout-->
  <!--Footer-->
  <footer class="page-footer text-center font-small mt-4 wow fadeIn">
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
            <a href="#">
                <i class="fab fa-vk mr-3"></i>
            </a>
            <a href="#">
                <i class="fab fa-youtube mr-3"></i>
            </a>
            <a href="#">
                <i class="fab fa-telegram mr-3"></i>
            </a>
            <a href="#">
                <i class="fab fa-instagram mr-3"></i>
            </a>
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