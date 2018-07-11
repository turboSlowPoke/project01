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
  <!-- Navbar -->
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

  <div class="py-5"></div>
  <main>

          <div class="py-5">
              <div class="container">
                  <div class="row">
                      <div class="col-md-12">
                          <div class="card">
                              <i class="fas fa-shopping-basket fa-5x"></i>
                              <div class="card-body">
                                  <form method="post" action="https://wallet.advcash.com/sci/">
                                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                      <input type="hidden" name="ac_account_email" value="mega_pokemon@mail.ru" />
                                      <input type="hidden" name="ac_sci_name" value="testBot" />
                                      <input type="hidden" name="ac_amount" value="${order.amount}" />
                                      <input type="hidden" name="ac_currency" value="USD" />
                                      <input type="hidden" name="ac_order_id" value="${order.id}" />
                                      <input type="hidden" name="ac_sign" value="${hash}" />
                                      <!-- Optional Fields -->
                                      <input type="hidden" name="ac_comments" value="${order.comment}" />
                                  <h5 class="card-title">Ваша покупка: ${order.comment} <#if trainingGroup??>, курс "${trainingGroup.course.name}"</#if> на сумму ${order.amount} </h5>
                                  <p class="card-text">Далее вы будете переадресованы на сайт Advcash, для проведения оплаты</p>
                                  <button autofocus type="submit" class="btn btn-primary">Продолжить</button>
                                  </form>
                                  <form method="post" action="/status">
                                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                      <input type="hidden" name="ac_src_wallet" value="U210987654321">
                                      <input type="hidden" name="ac_dest_wallet" value="U123456789012">
                                      <input type="hidden" name="ac_amount" value="${order.amount}">
                                      <input type="hidden" name="ac_merchant_currency" value="USD">
                                      <input type="hidden" name="ac_transfer" value="235f9d0b-b48f-462c-9949-621c4930490c">
                                      <input type="hidden" name="ac_sci_name" value="My Shop">
                                      <input type="hidden" name="ac_start_date" value="2012-06-23 12:30:00">
                                      <input type="hidden" name="ac_order_id" value="${order.id}">
                                      <input type="hidden" name="ac_transaction_status" value="COMPLETED">
                                      <input type="hidden" name="ac_comments" value="Comments">
                                      <button autofocus type="submit" class="btn btn-primary">Тест</button>
                                      <!-- Merchant custom fields -->
                                  </form>
                              </div>
                          </div>
                      </div>
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
              <a href="https://vk.com/potvneskazut"><i class="fab fa-vk mr-3"></i></a>
              <a href="https://www.youtube.com/channel/UCZNqVOAdOpUfbv4PLePXebQ"><i class="fab fa-youtube mr-3"></i></a>
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