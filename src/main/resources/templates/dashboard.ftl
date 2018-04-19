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
  <link href="css/lk/style.css" rel="stylesheet">
  <link rel="stylesheet" href="css/lk/font-awesome-animation.min.css">
</head>

<body>
  <!--Main Navigation-->
  <header>
    <!-- Navbar -->
    <nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar">
      <div class="container-fluid">
        <!-- Brand -->
        <a class="navbar-brand waves-effect" href="#" target="_blank"> <strong class="blue-text">MDB</strong> </a>
        <!-- Collapse -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
        <!-- Links -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <!-- Left -->
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
              <a class="nav-link waves-effect" href="#">Главная <span class="sr-only">(current)</span> </a>
            </li>
            <li class="nav-item">
              <a class="nav-link waves-effect" href="#" target="_blank">О нас</a>
            </li>
            <li class="nav-item">
              <a class="nav-link waves-effect" href="#" target="_blank">Контакты</a>
            </li>
            <li class="nav-item">
              <a class="nav-link waves-effect" href="#" target="_blank">FAQ</a>
            </li>
          </ul>
          <!-- Right -->
          <ul class="navbar-nav nav-flex-icons">
            <li class="nav-item">
              <b class="nav-link waves-effect" ">
                  <i class="fa fa-user indigo-text mr-1" aria-hidden="true"></i>
                  <#if user.login??>${user.login}
                  <#elseif user.userData??&&user.userData.telegramNikcName??>
                    ${user.userData.telegramNikcName}
                  <#elseif user.userData.firstName??>${user.userData.firstName}
                  </#if>
              </b>
            </li>
            <li class="nav-item">
              <a href="/logout" class="nav-link border border-light rounded waves-effect">
                  <i class="fa fa-sign-out orange-text mr-1" aria-hidden="true"></i>Выйти</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <!-- Navbar -->
    <!-- Sidebar -->
    <div class="sidebar-fixed position-fixed ">

      <div class="list-group list-group-flush" id="mainNav">
        <a href="#subscription" class="list-group-item active waves-effect js-scroll-trigger"> <i class="fa fa-shopping-basket mr-3"></i>Подписки </a>
        <a href="#profile" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-user mr-3"></i>Профиль</a>
        <a href="#referals" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-table mr-3"></i>Реферальная программа</a>
        <a href="#bonus" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-map mr-3"></i>Бонусы</a>
      </div>
    </div>
    <!-- Sidebar -->
  </header>
  <!--Main Navigation-->
  <!--Main layout-->
  <main class="pt-5 mx-lg-5 m-lg-5">
      <#if user.telegramChatId??>
      <#else >
      <div class="container container-fluid">
          <div class="row wow fadeIn">
              <div class="col-md-1"></div>
              <div class="col-md-7">
                  <div class="card">
                      <div class="card-header text-center"><i class="fa fa-money text-success mr-3" aria-hidden="true"></i>Бонусы</div>
                      <div class="card-body text-center green lighten-5">
                          <table class="table">
                              <tbody>
                              <tr>
                                  <td><i class="fa fa-university fa-5x" aria-hidden="true"></i></td>
                                  <td class="lead">На вашем счету $$$ бонусов</td>
                              </tr>
                              </tbody>
                          </table>
                      </div>
                      <div class="card-footer text-center text-success">
                          Чуть позже вы сможете их выгодно потратить!
                      </div>
                  </div>
              </div>
              <div class="col-md-4"></div>
          </div>
      </div>
      </#if>

    <div class="modal fade" id="signalsWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-notify modal-info" role="document">
        <div class="modal-content">
          <div class="modal-header btn-pink">
            <p class="heading lead">Выберите период подписки на сигналы</p>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
          </div>
          <form class="form-group" action="/sendadvcash" method="post">
          <div class="modal-body text-center">
            <table class="table">
              <tbody>
              <tr>
                <td><i class="fa fa-bell faa-ring animated pink-text fa-5x" ></i></td>
                <td class="lead">
                  <div class="form-check">
                  <label class="form-check-label lead">
                    <input class="form-check-input" type="radio" name="service" id="exampleRadios1" value="signals01" checked>
                    Один месяц
                  </label>
                </div>
                  <div class="form-check">
                    <label class="form-check-label lead">
                      <input class="form-check-input" type="radio" name="service" id="exampleRadios2" value="signals02">
                      Два месяца
                    </label>
                  </div>
                  <div class="form-check">
                    <label class="form-check-label lead">
                      <input class="form-check-input" type="radio" name="service" id="exampleRadios3" value="signals03" >
                      Три месяца
                    </label>
                  </div>
                </td>
              </tr>
              </tbody>
            </table>
          </div>
          <div class="modal-footer text-center">
            <button class="btn btn-pink waves-effect focus" type="submit">Продолжить</button>
            <a role="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Отмена</a>
          </div>
          </form>
        </div>
        <!--/.Content-->
      </div>
    </div>
    <div class="modal fade" id="trainingWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-notify modal-info" role="document">
        <!--Content-->
        <div class="modal-content">
          <!--Header-->
          <div class="modal-header btn-purple">
            <p class="heading lead">Выберите период подписки на обучение</p>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
          </div>

          <form class="form-group" action="/sendadvcash" method="post">
            <!--Body-->
            <div class="modal-body text-center">
                <#if (trainingGroups??&&trainingGroups?size>0)>
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>
                                <i class="fa fa-graduation-cap faa-tada animated mr-3 purple-text fa-5x"></i></i>
                            </td>
                            <td class="lead">
                                <#list trainingGroups as group>
                                    <div class="form-check">
                                        <label class="form-check-label lead">
                                            <input class="form-check-input" type="radio" name="trainingid_${group.id}" id="exampleRadios11" value="true" checked>
                                            ${group.course.name} набор закроется  ${group.endSet}
                                        </label>
                                    </div>
                                </#list>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                <#else>
                <p class="lead ">На данный момент нет доступных курсов для записи</p>
                </#if>
            </div>
            <!--Footer-->
            <div class="modal-footer text-center">
              <#if (trainingGroups??&&trainingGroups?size>0)>
              <button class="btn btn-purple waves-effect focus" type="submit">Продолжить</button>
              </#if>
              <a role="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Отмена</a>
            </div>
          </form>
        </div>
        <!--/.Content-->
      </div>
    </div>
    <div class="modal fade" id="modalProfileFirstName" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header light-blue accent-1">
            <h5 class="modal-title white-text" id="exampleModalLabel"><i class="fa fa-user-circle  mr-3 " aria-hidden="true"></i> Смена имени</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span> </button>
          </div>
          <form action="/lk" method="post">
          <div class="modal-body">
            <div class="form-group">
              <input type="first_name" class="form-control" id="exampleInputLogin" placeholder="Введите имя">
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-info">Сохранить</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
          </div>
          </form>
        </div>
      </div>
    </div>
    <div class="modal fade" id="modalProfileLastName" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header light-blue accent-1">
            <h5 class="modal-title white-text" ><i class="fa fa-user-circle  mr-3 " aria-hidden="true"></i> Смена фамилии</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span> </button>
          </div>
          <form action="/lk" method="post">
            <div class="modal-body">
              <div class="form-group">
                <input type="first_name" class="form-control" placeholder="Введите фамилию">
              </div>
            </div>
            <div class="modal-footer">
              <button type="submit" class="btn btn-info">Сохранить</button>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="modal fade" id="modalProfilePassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header light-blue accent-1">
            <h5 class="modal-title white-text" ><i class="fa fa-user-circle  mr-3 " aria-hidden="true"></i> Смена пароля</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span> </button>
          </div>
          <form action="/lk" method="post">
            <div class="modal-body">
              <table class="table">
                <tbody>
                <tr>
                  <td><i class="fa fa-lock mr-1 fa-5x" aria-hidden="true"></i></td>
                  <td class="lead">
                    <div class="form-group">
                        <input class="form-control" type="password" name="password1" placeholder="Введите пароль">
                    </div>
                    <div class="form-group">
                        <input class="form-control" type="password" name="password2"  placeholder="Повторите пароль">
                    </div>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
            <div class="modal-footer">
              <button type="submit" class="btn btn-info">Сохранить</button>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="modal fade" id="modalProfileMail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header light-blue accent-1">
            <h5 class="modal-title white-text" ><i class="fa fa-user-circle  mr-3 " aria-hidden="true"></i> Смена почты</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span> </button>
          </div>
          <form action="/lk" method="post">
            <div class="modal-body">
              <table class="table">
                <tbody>
                <tr>
                  <td><i class="fa fa-envelope-o fa-5x mr-1" aria-hidden="true"></i></td>
                  <td class="lead">
                    <div class="form-group">
                      <input class="form-control" type="email" name="email" placeholder="Введите email">
                    </div>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
            <div class="modal-footer">
              <button type="submit" class="btn btn-info">Сохранить</button>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <section id="subscription"></section>
    <div class="container container-fluid mt-5">
      <div class="row wow fadeIn">
          <#--сигналы-->
        <div class="col-md-6 mb-4">
          <div class="card ">
            <div class="card-header text-center "><i class="fa fa-bell faa-ring animated mr-3 pink-text" ></i>Сигналы</div>
            <div class="card-body pink lighten-5">
              <table class="table">
                <tbody>
                <tr>
                  <td><i class="fa fa-clock-o fa-5x" aria-hidden="true"></i></td>
                  <td class="lead">
                  <#assign subscribeBotton="Продлить">
                  <#if user.subsribe??&&user.subsribe.endOfSignal??>
                    <#assign curentDate=.now?date temp=""+user.subsribe.endOfSignal endDate = temp?date("yyyy-MM-dd")>
                    <#if (curentDate<=endDate)>Ваша подписка истекает ${endDate}</#if>
                    <#if (curentDate>endDate)>Подписка истекла ${endDate}</#if>
                  <#else>Вы еще не оформили подписку <#assign subscribeBotton="Купить подписку">
                  </#if>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
            <div class="card-footer text-center ">
              <button type="button" class="btn btn-pink" data-toggle="modal" data-target="#signalsWindow">${subscribeBotton} </button>
            </div>
          </div>
        </div>
            <#--обучение-->
        <div class="col-md-6 mb-4">
          <div class="card ">
            <div class="card-header text-center "><i class="fa fa-graduation-cap faa-tada animated mr-3 purple-text"></i>Обучение</div>
            <div class="card-body purple lighten-5">
              <table class="table">
                <tbody>
                <tr>
                  <td>
                      <#if user.trainingGroup??><i class="fa fa-check-square fa-5x green-text" aria-hidden="true"></i></i>
                      <#else><i class="fa fa-exclamation-triangle fa-5x orange-text" aria-hidden="true"></i></#if>
                  </td>
                  <td class="lead">
                    <#assign trainingBotton="Записаться">
                    <#if user.trainingGroup??>
                      <#list user.trainingGroups as training>
                          Вы записаны на курс: ${training.course.name}
                      </#list>
                    <#else>Запишитесь на курс<#assign trainingBotton="Записаться"></#if>
                  </td>
                </tr>
                </tbody>
              </table>
              </div>
            <div class="card-footer text-center ">
              <button type="button" class="btn btn-purple" data-toggle="modal" data-target="#trainingWindow">${trainingBotton} </button>
            </div>
          </div>
          </div>
        </div>
      </div>

    <section id="profile"></section>
    <div class="container container-fluid">
      <div class="row wow fadeIn">
        <div class="col-md-12 mb-4">
          <div class="card"  >
            <div class="card-header text-center ">
              <i class="fa fa-user-circle text-info mr-3 " aria-hidden="true"></i>Ваш профиль
            </div>
            <div class="card-body blue lighten-5">
              <table class="table table-hover">
                <tbody >
                  <tr>
                    <th scope="row">Имя</th>
                    <td><#if user.userData??&&user.userData.firstName??>${user.userData.firstName}</#if></td>
                    <td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#modalProfileFirstName">Изменить</button></td>
                  </tr>
                  <tr>
                    <th scope="row">Фамилия</th>
                    <td><#if user.userData??&&user.userData.lastName??>${user.userData.lastName}</#if></td>
                    <td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#modalProfileLastName">Изменить</button></td>
                  </tr>
                  <tr>
                    <th scope="row"><i class="fa fa-lock mr-1" aria-hidden="true"></i>Пароль</th>
                    <td>*******</td>
                    <td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#modalProfilePassword">Изменить</button></td>
                  </tr>
                  <tr>
                    <th scope="row"><i class="fa fa-envelope-o mr-1" aria-hidden="true"></i>email</th>
                    <td><#if user.userData.email??>${user.userData.email}</#if></td>
                    <td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#modalProfileMail"><#if user.userData.email??>Изменить<#else>Указать</#if></button></td>
                  </tr>
                  <tr>
                    <th scope="row"><i class="fa fa-telegram text-primary mr-1" aria-hidden="true"></i> telegram</th>
                    <td>@telegramusername</td>
                    <td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#">Изменить</button></td>
                  </tr>
                </tbody>
                <!-- Table body -->
              </table>
              <!-- Table  -->
            </div>
          </div>
          <!--/.Card-->
        </div>
      </div>
    </div>

    <section id="referals"></section>
    <div class="container container-fluid ">
      <div class="row wow fadeIn">
        <div class="col-md-1"></div>
        <div class="col-md-7 mt-4">
          <div class="card">
            <div class="card-header text-center "><i class="fa fa-handshake-o mr-3 text-default" aria-hidden="true"></i>Рефералы</div>
            <div class="card-body cyan lighten-5">
              <table class="table table-hover">
                <tbody>
                <tr>
                  <th scope="row">Количество рефералов</th>
                  <td>....</td>
                </tr>
                <tr>
                  <th scope="row">Количество оплат</th>
                  <td>....</td>
                </tr>
                </tbody>
              </table>
            </div>
            <div class="card-footer text-center ">
              <button type="button" class="btn btn-default " data-toggle="modal" data-target="#">Пригласить</button>
            </div>
          </div>
        </div>
        <div class="col-md-4"></div>
      </div>
    </div>

    <section id="bonus"></section>
    <div class="container container-fluid">
      <div class="row wow fadeIn">
        <div class="col-md-1"></div>
        <div class="col-md-7">
          <div class="card">
            <div class="card-header text-center"><i class="fa fa-money text-success mr-3" aria-hidden="true"></i>Бонусы</div>
            <div class="card-body text-center green lighten-5">
              <table class="table">
                <tbody>
                <tr>
                  <td><i class="fa fa-university fa-5x" aria-hidden="true"></i></td>
                  <td class="lead">На вашем счету $$$ бонусов</td>
                </tr>
                </tbody>
              </table>
            </div>
            <div class="card-footer text-center text-success">
              Чуть позже вы сможете их выгодно потратить!
            </div>
          </div>
        </div>
        <div class="col-md-4"></div>
      </div>
    </div>

  </main>
  <!--Main layout-->
  <!--Footer-->
  <footer class="page-footer text-center font-small mt-4 wow fadeIn">
    <!--Call to action-->
    <div class="pt-4">
      <a class="btn btn-outline-white" href="https://mdbootstrap.com/getting-started/" target="_blank" role="button">Download MDB <i class="fa fa-download ml-2"></i> </a>
      <a class="btn btn-outline-white" href="https://mdbootstrap.com/bootstrap-tutorial/" target="_blank" role="button">Start free tutorial <i class="fa fa-graduation-cap ml-2"></i> </a>
    </div>
    <!--/.Call to action-->
    <hr class="my-4">
    <!-- Social icons -->
    <div class="pb-4">
      <a href="https://www.facebook.com/mdbootstrap" target="_blank"> <i class="fa fa-facebook mr-3"></i> </a>
      <a href="https://twitter.com/MDBootstrap" target="_blank"> <i class="fa fa-twitter mr-3"></i> </a>
      <a href="https://www.youtube.com/watch?v=7MUISDJ5ZZ4" target="_blank"> <i class="fa fa-youtube mr-3"></i> </a>
      <a href="https://plus.google.com/u/0/b/107863090883699620484" target="_blank"> <i class="fa fa-google-plus mr-3"></i> </a>
      <a href="https://dribbble.com/mdbootstrap" target="_blank"> <i class="fa fa-dribbble mr-3"></i> </a>
      <a href="https://pinterest.com/mdbootstrap" target="_blank"> <i class="fa fa-pinterest mr-3"></i> </a>
      <a href="https://github.com/mdbootstrap/bootstrap-material-design" target="_blank"> <i class="fa fa-github mr-3"></i> </a>
      <a href="http://codepen.io/mdbootstrap/" target="_blank"> <i class="fa fa-codepen mr-3"></i> </a>
    </div>
    <!-- Social icons -->
    <!--Copyright-->
    <div class="footer-copyright py-3"> © 2018 Copyright:
      <a href="https://mdbootstrap.com/bootstrap-tutorial/" target="_blank"> MDBootstrap.com </a>
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
  <script src="js/scrolling-nav.js"></script>
  <!-- Initializations -->
  <script type="text/javascript">
    // Animations initialization
        new WOW().init();
  </script>
  <!-- Charts -->


</body>

</html>