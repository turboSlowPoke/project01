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
    <link href="css/mdb.min.css" rel="stylesheet">
    <!-- Your custom styles (optional) -->
    <link href="css/style.css" rel="stylesheet"> </head>

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
                    <a class="nav-link waves-effect " href="/">Главная </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link waves-effect " href="/about">О нас</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link waves-effect" href="/contacts">Контакты</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link waves-effect" href="/faq">FAQ</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="py-5"></div>
<main>

    <div class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <#if error??>
                                   <p class="lead text-danger">Не верные логин/пароль</p>
                    </#if>
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
                        <button type="submit" class="btn btn-primary">Войти</button>
                        <a class="btn btn-danger" href="/oauth2/authorization/google" title="Авторизоваться через Google" data-toggle="tooltip" data-placement="bottom">Google</a><br>
                    </form>
                </div>
                <div class="col-md-4"></div>
            </div>
        </div>
    </div>

</main>

<footer class="page-footer text-center font-small mt-4 wow fadeIn fixedFooterForBigScreen">
    <!--Call to action-->
    <div class="footerUpSide">
        <!--/.Call to action-->
        <hr class="my-4">
        <!-- Social icons -->
        <div class="pb-4 footerMiddleSide">
            <a href="https://vk.com/potvneskazut">                 <i class="fab fa-vk mr-3"></i>             </a>
            <a href="https://www.youtube.com/channel/UCZNqVOAdOpUfbv4PLePXebQ">                 <i class="fab fa-youtube mr-3"></i>             </a>
            <a href="https://t.me/potvneskazut"><i class="fab fa-telegram mr-3"></i></a>
            <a href="https://www.instagram.com/kyzminpotv/"><i class="fab fa-instagram mr-3"></i></a>
            <a href="https://viuly.io/channel/95347"><i class="fab fa-vine"></i></a>
        </div>
    </div>

    <!-- Social icons -->
    <!--Copyright-->
    <div class="footerDownSide py-3" > © 2018 Copyright:
        <a href="#"> potvneskazut.ru </a>
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