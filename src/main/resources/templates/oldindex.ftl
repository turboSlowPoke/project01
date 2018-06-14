<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>Material Design Bootstrap</title>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <!-- Bootstrap core CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <!-- Material Design Bootstrap -->
  <link href="css/mdb.min.css" rel="stylesheet">
  <!-- Your custom styles (optional) -->
  <link href="css/style.min.css" rel="stylesheet"> </head>

<body>
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Авторизация</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span> </button>
            </div>
            <div class="modal-body">
                <form action="/login" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group">
                        <label for="exampleInputLogin">Логин</label>
                        <input type="text" name="username" class="form-control" id="exampleInputLogin" placeholder="login">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Пароль</label>
                        <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="password">
                    </div>
                <#--<div class="form-check">
                    <input type="checkbox" class="form-check-input" id="exampleCheck1">
                    <label class="form-check-label" for="exampleCheck1">Check me out</label>
                </div>-->
                    <button type="submit" class="btn btn-primary ">Submit</button>
                    <button class="btn btn-default" type="button" data-dismiss="modal">Закрыть</button>
                    <a text="Google" href="oauth2/authorization/google">Google</a>
                </form>
            </div>
        </div>
    </div>
</div>

  <!-- Navbar -->
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar">
    <div class="container">
      <!-- Brand -->
      <a class="navbar-brand" target="_blank"> <strong><i class="fa fa-line-chart" aria-hidden="true"></i></strong> </a>
      <!-- Collapse -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
      <!-- Links -->
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <!-- Left -->
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="#">Главная <span class="sr-only">(current)</span> </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" target="_blank">О нас</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" target="_blank">Контакты</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" target="_blank">FAQ</a>
          </li>
        </ul>
        <!-- Right -->
        <ul class="navbar-nav nav-flex-icons">
          <li class="nav-item">
            <a href="#" class="nav-link border border-light rounded" target="_blank" data-toggle="modal" data-target="#loginModal"> <i class="fa fa-sign-in"></i>Войти </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- Navbar -->

  <!--Carousel Wrapper-->
  <div id="carousel-example-1z" class="carousel slide carousel-fade" data-ride="carousel">
    <!--Indicators-->
    <#--<ol class="carousel-indicators">-->
      <#--<li data-target="#carousel-example-1z" data-slide-to="0" class="active"></li>-->
      <#--<li data-target="#carousel-example-1z" data-slide-to="1"></li>-->
      <#--<li data-target="#carousel-example-1z" data-slide-to="2"></li>-->
    <#--</ol>-->
    <!--/.Indicators-->
    <!--Slides-->
    <div class="carousel-inner" role="listbox">
      <!--First slide-->
      <div class="carousel-item active">
        <div class="view" style="background-image: url('/img/shapka.jpg'); background-repeat: no-repeat; background-size: cover;">
          <!-- Mask & flexbox options-->
          <div class="mask  d-flex justify-content-center align-items-center">
            <!-- Content -->
            <div class="text-center white-text mx-5 wow fadeIn ">
              <h1 class="mb-4"> <strong>По ТВ не покажут</strong> </h1>
              <p> <strong>бла1 бла1 бла1</strong> </p>
              <p class="mb-4 d-none d-md-block"> <strong>бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2  </strong> </p>
              <a target="_blank" href="https://mdbootstrap.com/bootstrap-tutorial/" class="btn btn-outline-white btn-lg">Start free tutorial <i class="fa fa-graduation-cap ml-2"></i> </a>
            </div>
            <!-- Content -->
          </div>
          <!-- Mask & flexbox options-->
        </div>
      </div>
      <!--/First slide-->
      <!--Second slide-->
      <#--<div class="carousel-item">-->
        <#--<div class="view" style="background-image: url('/img/shapka.jpg'); background-repeat: no-repeat; background-size: cover;">-->
          <#--<!-- Mask & flexbox options&ndash;&gt;-->
          <#--<div class="mask rgba-black-light d-flex justify-content-center align-items-center">-->
            <#--<!-- Content &ndash;&gt;-->
            <#--<div class="text-center white-text mx-5 wow fadeIn">-->
              <#--<h1 class="mb-4"> <strong>Learn Bootstrap 4 with MDB</strong> </h1>-->
              <#--<p> <strong>Best &amp; free guide of responsive web design</strong> </p>-->
              <#--<p class="mb-4 d-none d-md-block"> <strong>The most comprehensive tutorial for the Bootstrap 4. Loved by over 500 000 users. Video and written versions-->
                  <#--available. Create your own, stunning website.</strong> </p>-->
              <#--<a target="_blank" href="https://mdbootstrap.com/bootstrap-tutorial/" class="btn btn-outline-white btn-lg">Start free tutorial <i class="fa fa-graduation-cap ml-2"></i> </a>-->
            <#--</div>-->
            <#--<!-- Content &ndash;&gt;-->
          <#--</div>-->
          <#--<!-- Mask & flexbox options&ndash;&gt;-->
        <#--</div>-->
      <#--</div>-->
      <!--/Second slide-->
      <!--Third slide-->
      <#--<div class="carousel-item">-->
        <#--<div class="view" style="background-image: url('https://mdbootstrap.com/img/Photos/Others/images/47.jpg'); background-repeat: no-repeat; background-size: cover;">-->
          <#--<!-- Mask & flexbox options&ndash;&gt;-->
          <#--<div class="mask rgba-black-light d-flex justify-content-center align-items-center">-->
            <#--<!-- Content &ndash;&gt;-->
            <#--<div class="text-center white-text mx-5 wow fadeIn">-->
              <#--<h1 class="mb-4"> <strong>Learn Bootstrap 4 with MDB</strong> </h1>-->
              <#--<p> <strong>Best &amp; free guide of responsive web design</strong> </p>-->
              <#--<p class="mb-4 d-none d-md-block"> <strong>The most comprehensive tutorial for the Bootstrap 4. Loved by over 500 000 users. Video and written versions-->
                  <#--available. Create your own, stunning website.</strong> </p>-->
              <#--<a target="_blank" href="https://mdbootstrap.com/bootstrap-tutorial/" class="btn btn-outline-white btn-lg">Start free tutorial <i class="fa fa-graduation-cap ml-2"></i> </a>-->
            <#--</div>-->
            <#--<!-- Content &ndash;&gt;-->
          <#--</div>-->
          <#--<!-- Mask & flexbox options&ndash;&gt;-->
        <#--</div>-->
      <#--</div>-->
      <!--/Third slide-->
    </div>
    <!--/.Slides-->
    <!--Controls-->
   <#-- <a class="carousel-control-prev" href="#carousel-example-1z" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span> </a>
    <a class="carousel-control-next" href="#carousel-example-1z" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span> </a>-->
    <!--/.Controls-->
  </div>
  <!--/.Carousel Wrapper-->

  <!--Main layout-->
  <main>
    <div class="container">
      <section class="mt-5 wow fadeIn">
        <div class="row">
          <div class="col-md-6 mb-4">
            <img src="https://mdbootstrap.com/img/Marketing/mdb-press-pack/mdb-main.jpg" class="img-fluid z-depth-1-half" alt=""> </div>
          <div class="col-md-6 mb-4">
            <h3 class="h3 mb-3">Коротко о проекте</h3>
            <p>This template is created with Material Design for Bootstrap ( <strong>MDB</strong> ) framework.</p>
            <p>Read details below to learn more about MDB.</p>
            <!-- Main heading -->
            <hr>
            <p> <strong>400+</strong> material UI elements, <strong>600+</strong> material icons, <strong>74</strong> CSS animations, SASS files, templates, tutorials and many more. <strong>Free for personal and commercial use.</strong> </p>
            <!-- CTA -->
            <a target="_blank" href="#" class="btn btn-grey btn-md">Войти в личный кабинет <i class="fa fa-sign-in ml-1"></i> </a>
          </div>
          <!--Grid column-->
        </div>
      </section>
      <hr class="my-5">
      <section>
            <h3 class="h3 text-center mb-5">Услуги</h3>
            <div class="row wow fadeIn">
                <div class="col-lg-6 col-md-12 px-4">
                    <div style="height:30px"></div>
                    <div class="row">
                        <div class="col-1 mr-3"> <i class="fa fa-bell fa-2x blue-text"></i> </div>
                        <div class="col-10">
                            <h5 class="feature-title">Сигналы</h5>
                            <p class="grey-text">Наши сигналы бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла</p>
                        </div>
                    </div>
                    <div style="height:30px"></div>
                    <div class="row">
                        <div class="col-1 mr-3"> <i class="fa fa-graduation-cap fa-2x cyan-text"></i> </div>
                        <div class="col-10">
                            <h5 class="feature-title">Обучение</h5>
                            <p class="grey-text">Наше обучение бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла</p>
                    </div>
                    </div>
                </div>

                <div class="col-lg-6 col-md-12">
                    <p class="h5 text-center mb-4">Посмотрите видео....</p>
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/cXTThxoywNQ" allowfullscreen=""></iframe>
                    </div>
                </div>
                <!--/Grid column-->
            </div>
            <!--/Grid row-->
        </section>
      <hr class="my-5">
      <section>
        <h3 class="h3 text-center mb-5">Цены</h3>
        <div class="p-5 bg-secondary">
          <div class="container">
            <div class="row">
              <div class="p-3 align-self-center col-md-3">
                    <div class="card">
                        <div class="card-block p-5">
                            <h1><sup>$</sup> 75 </h1>
                            <h3><i class="fa fa-bell faa-ring animated mr-3 pink-text" ></i> Сигналы</h3>
                            <hr>
                            <p>Подписка один месяц</p>
                            <a href="#" class="btn btn-dark">Купить</a>
                        </div>
                    </div>
                </div>
              <div class="p-3 align-self-center col-md-3">
                <div class="card">
                  <div class="card-block p-5">
                    <h1><sup>$</sup> 75 </h1>
                    <h3><i class="fa fa-bell faa-ring animated mr-3 pink-text" ></i> Сигналы</h3>
                    <hr>
                    <p>Подписка два месяца</p>
                    <a href="#" class="btn btn-dark">Купить</a>
                  </div>
                </div>
              </div>
              <div class="p-3 align-self-center col-md-3">
                <div class="card">
                  <div class="card-block p-5">
                    <h1><sup>$</sup> 135 </h1>
                    <h3><i class="fa fa-bell faa-ring animated mr-3 pink-text" ></i> Сигналы</h3>
                    <hr>
                    <p>Подписка три месяца</p>
                    <a href="#" class="btn btn-dark">Купить</a>
                  </div>
                </div>
              </div>
              <div class="p-3 align-self-center col-md-3">
                    <div class="card">
                        <div class="card-block p-5">
                            <h1><sup>$</sup> 135 </h1>
                            <h3><i class="fa fa-graduation-cap faa-tada animated mr-3 purple-text"></i> Обучение</h3>
                            <hr>
                            <p>Супер пупер курс</p>
                            <a href="#" class="btn btn-dark">Купить</a>
                        </div>
                    </div>
                </div
            </div>
          </div>
        </div>
      </section>
      <hr class="mb-5">
      <section>
        <h2 class="my-5 h3 text-center">Мы в соцсетях:</h2>
        <!--First row-->
        <div class="row features-small mt-5 wow fadeIn">
          <div class="col-xl-4 col-lg-6"></div>
          <!--VK link-->
          <div class="col-xl-4 col-lg-6">
            <div class="row">
              <div class="col-2"> <i class="fa fa-vk fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
              <div class="col-10 mb-2 pl-3">
                <h5 class="feature-title font-bold mb-1">Группа в контакте</h5>
                <p class="grey-text mt-2">Три слова о грппе </p>
              </div>
            </div>

          </div>
          <div class="col-xl-4 col-lg-6"></div>

        </div>
        <!--Second row-->
        <div class="row features-small mt-4 wow fadeIn">
          <div class="col-xl-4 col-lg-6"></div>
            <!--Youtube link-->
          <div class="col-xl-4 col-lg-6">
                <div class="row">
                    <div class="col-2"> <i class="fa fa-youtube-play fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
                    <div class="col-10 mb-2">
                        <h5 class="feature-title font-bold mb-1">Наш канал на youtube</h5>
                        <p class="grey-text mt-2">три слова о канале</p>
                    </div>
                </div>
            </div>
          <div class="col-xl-4 col-lg-6"></div>
        </div>
        <!--3 row-->
        <div class="row features-small mt-4 wow fadeIn">
          <div class="col-xl-4 col-lg-6"></div>
            <!--Telegram  link-->
          <div class="col-xl-4 col-lg-6">
                  <div class="row">
                      <div class="col-2"> <i class="fa fa-telegram fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
                      <div class="col-10 mb-2">
                          <h5 class="feature-title font-bold mb-1">Наш канал в телеграм</h5>
                          <p class="grey-text mt-2">три слова о канале</p>
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
      <a class="btn btn-outline-white" href="#" target="_blank" role="button">Войти в личный кабинет <i class="fa fa-sign-in ml-2"></i> </a>
    </div>
    <!--/.Call to action-->
    <hr class="my-4">
    <!-- Social icons -->
    <#--<div class="pb-4">-->
      <#--<a href="https://www.facebook.com/mdbootstrap" target="_blank"> <i class="fa fa-facebook mr-3"></i> </a>-->
      <#--<a href="https://twitter.com/MDBootstrap" target="_blank"> <i class="fa fa-twitter mr-3"></i> </a>-->
      <#--<a href="https://www.youtube.com/watch?v=7MUISDJ5ZZ4" target="_blank"> <i class="fa fa-youtube mr-3"></i> </a>-->
      <#--<a href="https://plus.google.com/u/0/b/107863090883699620484" target="_blank"> <i class="fa fa-google-plus mr-3"></i> </a>-->
      <#--<a href="https://dribbble.com/mdbootstrap" target="_blank"> <i class="fa fa-dribbble mr-3"></i> </a>-->
      <#--<a href="https://pinterest.com/mdbootstrap" target="_blank"> <i class="fa fa-pinterest mr-3"></i> </a>-->
      <#--<a href="https://github.com/mdbootstrap/bootstrap-material-design" target="_blank"> <i class="fa fa-github mr-3"></i> </a>-->
      <#--<a href="http://codepen.io/mdbootstrap/" target="_blank"> <i class="fa fa-codepen mr-3"></i> </a>-->
    <#--</div>-->
    <!-- Social icons -->
    <!--Copyright-->
    <div class="footer-copyright py-3"> © 2018 Copyright:
      <a href="#" target="_blank"> По ТВ не покажут </a>
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
  <!-- Initializations -->
  <script type="text/javascript">
    // Animations initialization
    new WOW().init();
  </script>

  <#if loginModalIsActive??>
      <script type="text/javascript">
          $(window).on('load',function(){
              $('#loginModal').modal('show');
          });
      </script>
  </#if>
</body>

</html>