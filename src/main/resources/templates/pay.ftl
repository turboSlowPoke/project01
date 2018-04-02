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
  <!-- Navbar -->
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar">
    <div class="container">
      <!-- Brand -->
      <a class="navbar-brand" target="_blank"> <strong>MDB</strong> </a>
      <!-- Collapse -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
      <!-- Links -->
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <!-- Left -->
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="#">Home <span class="sr-only">(current)</span> </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">About MDB</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="https://mdbootstrap.com/getting-started/" target="_blank">Free download</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="https://mdbootstrap.com/bootstrap-tutorial/" target="_blank">Free tutorials</a>
          </li>
        </ul>
        <!-- Right -->
        <ul class="navbar-nav nav-flex-icons">
          <li class="nav-item">
            <a href="#" class="nav-link border border-light rounded" target="_blank" data-toggle="modal" data-target="#basicModal"> <i class="fa fa-sign-in"></i>Войти </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <div class="py-5"></div>
  <main>
    <#if user?? && service!="fail">
            <div class="py-5">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <img class="card-img-top py-5 mx-auto w-25" src="https://pingendo.com/assets/photos/wireframe/photo-1.jpg" alt="Card image cap">
                                <div class="card-body">
                                    <h5 class="card-title">Ваша покупка: ${service} </h5>
                                    <p class="card-text">Далее вы будете переадресованы на сайт Advcash, для проведения оплаты</p>
                                    <button autofocus type="submit" class="btn btn-primary">Продолжить</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    <#else>
              <div class="py-5">
                  <div class="container">
                      <div class="row">
                          <div class="col-md-12">
                              <div class="card">
                                  <img class="card-img-top py-5 mx-auto w-25" src="https://pingendo.com/assets/photos/wireframe/photo-1.jpg" alt="Card image cap">
                                  <div class="card-body">
                                      <h5 class="card-title">Ошибка: не корректные параметры!</h5>
                                      <form action="${closeLink}">
                                          <button type="submit" class="btn btn-secondary" data-dismiss="modal">Вернуться</button>
                                      </form>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>
    </#if>
  </main>
  <footer class="page-footer text-center font-small mt-4 wow fadeIn fixed-bottom">
    <!--Call to action-->

    <!--/.Call to action-->

    <!-- Social icons -->
    <!--Copyright-->
    <div class="footer-copyright py-3"> © 2018 Copyright:
      <a href="https://mdbootstrap.com/bootstrap-tutorial/" target="_blank"> MDBootstrap.com </a>
    </div>
    <!--/.Copyright-->
  </footer>
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
</body>

</html>