<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  
  <title>ТВ не скажет</title>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
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
          <!--<div class="form-check">-->
          <!--<input type="checkbox" class="form-check-input" id="exampleCheck1">-->
          <!--<label class="form-check-label" for="exampleCheck1">Check me out</label>-->
        <!--</div>-->
          <button type="submit" class="btn btn-primary btn-sm">Войти</button>
          <hr class="my-1">
          Также вы можете войти черз Google:
          <a class="btn btn-outline-red btn-sm" href="oauth2/authorization/google" title="Авторизоваться через Google" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-google" aria-hidden="true"></i></a><br>
          Получить логин пароль в телеграм:
          <a class="btn btn-outline-blue btn-sm" href="#" title="Получить логин пароль у нашего бота" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-telegram" aria-hidden="true"></i></a>
        </form>
      </div>
      <div class="modal-bottom">
        <button class="btn btn-default float-right btn-sm" type="button" data-dismiss="modal">Закрыть</button>
      </div>
    </div>
  </div>
</div>

  <nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar">
    <div class="container">
      <a class="navbar-brand" href="#" >
        <strong>
          <i class="fa fa-television" aria-hidden="true"></i>
          <i class="fa fa-line-chart" aria-hidden="true"></i>
        </strong>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="/">Главаная </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/about">О нас</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/contacts">Контакты</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/faq">FAQ
              <br> </a>
          </li>
        </ul>
        <ul class="navbar-nav nav-flex-icons">
          <li class="nav-item pr-lg-3">
            <a href="#" class="nav-link"  title="Авторизоваться через Google" data-toggle="tooltip" data-placement="bottom">
              <i class="fa fa-google" aria-hidden="true"></i>
            </a>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link border border-light rounded" title="Войти в личный кабинет" data-toggle="modal" data-placement="bottom" data-target="#signInModal">
              <i class="fa fa-sign-in pr-2" aria-hidden="true"></i>кабинет
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <img class="img-fluid header-img big-screen " src="img/shapka.jpg">
<div class="background-header little-screen">
  <img class="img-fluid little-screen" src="./img/shapka_test.png">
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
            <h3 class="h3 mb-3">О нас</h3>
            <p>This template is created with Material Design for Bootstrap (
              <strong>MDB</strong> ) framework.</p>
            <p>Read details below to learn more about MDB.</p>
            <!-- Main heading -->
            <hr>
            <p>
              <strong>400+</strong> material UI elements,
              <strong>600+</strong> material icons,
              <strong>74</strong> CSS animations, SASS files, templates, tutorials and many more.
              <strong>Free for personal and commercial use.</strong>
            </p>
            <!-- CTA -->
            <a href="#" class="btn btn-grey btn-md">присоединиться <i class="fa fa-sign-in pl-2" aria-hidden="true"></i></a>
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
        <div class="p-5 bg-secondary wow ">
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
                          <h1><sup>$</sup> 10</h1>
                          <h3>Сигналы</h3>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="card-block p-5">
                    <p>Наши супер сигналы бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла
                      бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла</p>
                    <hr>
                    <a href="#" class="btn btn-dark">купить</a>
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
                          <h1><sup>$</sup> 20</h1>
                          <h3>Обучение</h3>
                        </div>
                      </div>
                    </div>


                  </div>
                  <div class="card-block p-5">
                    <p>Наш супер курс  бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла
                      бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла</p>
                    <hr>
                    <a href="#" class="btn btn-dark">купить</a>
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
        <h2 class="my-5 h3 text-center">Мы в соцсетях:</h2>
        <!--row 1-->
        <div class="row features-small mt-4 wow fadeIn">
          <div class="col-xl-4 col-lg-6 col-md-4"></div>
          <div class="col-xl-4 col-lg-6">
            <div class="row">
              <div class="col-2">
                <i class="fa fa-vk fa-2x mb-1 blue-text" aria-hidden="true"></i>
              </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">Группа вконтакте</h5>
                <p class="grey-text mt-2">We care about reliability. If you have any questions - do not hesitate to contact us. </p>
              </div>
            </div>
          </div>
          <div class="col-xl-4 col-lg-6"></div>
        </div>
        <!--row 2-->
        <div class="row features-small mt-4 wow fadeIn">
          <div class="col-xl-4 col-lg-6"></div>
          <div class="col-xl-4 col-lg-6">
            <div class="row">
              <div class="col-2">
                <i class="fa fa-youtube-play fa-2x mb-1 red-text" aria-hidden="true"></i>
              </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">Канал на youtube</h5>
                <p class="grey-text mt-2">We care about reliability. If you have any questions - do not hesitate to contact us. </p>
              </div>
            </div>
          </div>
          <div class="col-xl-4 col-lg-6"></div>
        </div>
        <!--row 3-->
        <div class="row features-small mt-4 wow fadeIn">
          <div class="col-xl-4 col-lg-6"></div>
          <div class="col-xl-4 col-lg-6">
            <div class="row">
              <div class="col-2">
                <i class="fa fa-telegram fa-2x mb-1 indigo-text" aria-hidden="true"></i>
              </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">Канал в телеграм</h5>
                <p class="grey-text mt-2">We care about reliability. If you have any questions - do not hesitate to contact us. </p>
              </div>
            </div>
          </div>
          <div class="col-xl-4 col-lg-6"></div>
        </div>
        <!--row 4-->
        <div class="row features-small mt-4 wow fadeIn">
          <div class="col-xl-4 col-lg-6"></div>
          <div class="col-xl-4 col-lg-6">
            <div class="row">
              <div class="col-2">
                <i class="fa fa-instagram fa-2x mb-1 blue-grey-text" aria-hidden="true"></i>
              </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">Мы в инстаграм</h5>
                <p class="grey-text mt-2">We care about reliability. If you have any questions - do not hesitate to contact us. </p>
              </div>
            </div>
          </div>
          <div class="col-xl-4 col-lg-6"></div>
        </div>
      </section>
    </div>
  </main>
  <!--Main layout-->
  <!--Footer-->
  <footer class="page-footer text-center font-small mt-4 wow fadeIn">
    <!--Call to action-->
    <div class="pt-4">
      <a class="btn btn-outline-white" href="#" role="button">Присоединиться &nbsp; &nbsp; &nbsp; &nbsp;
        <i class="fa fa-sign-in ml-2"></i>
      </a>
    </div>
    <!--/.Call to action-->
    <hr class="my-4">
    <!-- Social icons -->
    <div class="pb-4">
      <a href="#">
        <i class="fa fa-vk mr-3"></i>
      </a>
      <a href="#">
        <i class="fa fa-youtube mr-3"></i>
      </a>
      <a href="#">
        <i class="fa fa-telegram mr-3"></i>
      </a>
      <a href="#">
        <i class="fa fa-instagram mr-3"></i>
      </a>
    </div>
    <!-- Social icons -->
    <!--Copyright-->
    <div class="footer-copyright py-3"> © 2018 Copyright:
      <a href="#"> ontvnotshow.com </a>
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