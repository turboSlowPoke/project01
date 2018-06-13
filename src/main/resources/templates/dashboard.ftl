<!DOCTYPE html>
<html lang="ru">

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

  <header>
    <!-- Navbar -->
    <nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar">
      <div class="container-fluid">
        <!-- Brand -->
        <a class="navbar-brand waves-effect" href="/#" target="_blank"> <strong class="blue-text">MDB</strong> </a>
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
        <a href="#subscription1" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-shopping-basket mr-3"></i>Подписки</a>
        <#if (user.trainingGroups?? && user.trainingGroups?size > 0)><a href="#homework" class="list-group-item  waves-effect js-scroll-trigger"> <i class="fa fa-file mr-3"></i>Домашние задания</a></#if>
        <a href="#profile" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-user mr-3"></i>Профиль</a>
        <a href="#referals" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-table mr-3"></i>Реферальная программа</a>
        <a href="#bonusWallet" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-map mr-3"></i>Бонусы</a>
      </div>
    </div>
    <!-- Sidebar -->
  </header>

  <main class="pt-5 mx-lg-5 m-lg-5">
      <#if userHash??>
      <div class="modal fade" id="botLinkModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-notify modal-info" role="document">
              <div class="modal-content">
                  <div class="modal-header btn-pink">
                      <p class="heading lead">Внимание!</p>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
                  </div>
                      <div class="modal-body text-center green lighten-5">
                          Присоедитесь к нашему боту в telegram <i class="fa fa-telegram" aria-hidden="true"></i>
                          , перейдя по <a href="${botLink}?start=${userHash}"> ссылке </a>.
                      </div>
                      <div class="modal-footer text-center">
                          <a role="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Закрыть</a>
                      </div>
                  </form>
              </div>
              <!--/.Content-->
          </div>
      </div>
      </#if>
      <#if paidOrder??>
      <div class="modal fade" id="paidOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-notify modal-info" role="document">
              <div class="modal-content">
                  <div class="modal-header btn-pink">
                      <p class="heading lead"></p>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
                  </div>
                  <div class="modal-body text-center green lighten-5">
                      Ваш заказ ${paidOrder.comment} успешно оплачен.
                  </div>
                  <div class="modal-footer text-center">
                      <a role="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Закрыть</a>
                  </div>
                  </form>
              </div>
              <!--/.Content-->
          </div>
      </div>
      </#if>
      <#if succes??>
         <div class="modal fade" id="succesWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-notify modal-info" role="document">
                        <div class="modal-content">
                            <div class="modal-header btn-pink">
                                <p class="heading lead"></p>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
                            </div>
                            <div class="modal-body text-center green lighten-5">
                                ${succes}
                            </div>
                            <div class="modal-footer text-center">
                                <a role="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Закрыть</a>
                            </div>
                            </form>
                        </div>
                        <!--/.Content-->
                    </div>
                </div>

      </#if>
      <#if (user.trainingGroups?? && user.trainingGroups?size > 0)>
      <div class="modal fade" id="homeworkWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-notify modal-info" role="document">
              <div class="modal-content">
                  <div class="modal-header btn-pink">
                      <p class="heading lead">Домашнее задание</p>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
                  </div>
                  <form class="form-group" action="/lk" method="post" enctype="multipart/form-data">
                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                      <div class="modal-body text-center">
                          <table class="table">
                              <tbody>
                              <tr>
                                  <td><i class="fa fa-file faa-ring animated pink-text fa-5x" ></i></td>
                                  <td class="lead">
                                      <input type="file" multiple name="image" class="form-control-file">
                                      <textarea class="form-control-plaintext pt-2" placeholder="введите текс" name="body"></textarea>
                                  </td>
                              </tr>
                              </tbody>
                          </table>
                      </div>
                      <div class="modal-footer text-center">
                          <button class="btn btn-pink waves-effect focus" type="submit">Отправить</button>
                          <a role="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Отмена</a>
                      </div>
                  </form>
              </div>
              <!--/.Content-->
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
          <form class="form-group" action="/payment" method="post">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          <div class="modal-body text-center">
            <table class="table">
              <tbody>
              <tr>
                <td><i class="fa fa-bell faa-ring animated pink-text fa-5x" ></i></td>
                <td class="lead">
                  <div class="form-check">
                  <label class="form-check-label lead">
                    <input class="form-check-input" type="radio" name="purchase" value="signals01" checked>
                    Один месяц
                  </label>
                </div>
                  <div class="form-check">
                    <label class="form-check-label lead">
                      <input class="form-check-input" type="radio" name="purchase" value="signals02">
                      Два месяца
                    </label>
                  </div>
                  <div class="form-check">
                    <label class="form-check-label lead">
                      <input class="form-check-input" type="radio" name="purchase" value="signals03" >
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

          <form class="form-group" action="/payment" method="post">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <input type="hidden" name="method" value="subscribeTraining"/>
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
                                            <input type="hidden" name="purchase" value="training">
                                            <input class="form-check-input" type="radio" name="trainingGroupId" id="exampleRadios11" value="${group.id}">
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
              <button class="btn btn-purple waves-effect focus" type="submit">Оплатить и записаться</button>
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
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <input type="text" required name="firstName" class="form-control" id="exampleInputLogin" placeholder="Введите имя">
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
               <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="text" required name="lastName" class="form-control" placeholder="Введите фамилию">
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
          <form action="/lk" method="post" id="changePassword">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <div class="modal-body">
              <table class="table">
                <tbody>
                <tr>
                  <td><i class="fa fa-lock mr-1 fa-5x" aria-hidden="true"></i></td>
                  <td class="lead">
                    <div class="form-group">
                        <input class="form-control" type="password" name="password1" placeholder="Введите пароль" required id="password1">
                    </div>
                    <div class="form-group">
                        <input class="form-control" type="password" name="password2"  placeholder="Повторите пароль" required id="password2">
                    </div>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
            <div class="modal-footer">
                <p id="passwordText" class="text warning-color"></p>
              <button type="submit" id="passwordButton" class="btn btn-info">Сохранить</button>
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
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <div class="modal-body">
              <table class="table">
                <tbody>
                <tr>
                  <td><i class="fa fa-envelope-o fa-5x mr-1" aria-hidden="true"></i></td>
                  <td class="lead">
                    <div class="form-group">
                      <input class="form-control" type="email" name="email" placeholder="Введите email" required>
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
    <div class="modal fade" id="changeTelegramUsername" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-notify modal-info" role="document">
              <div class="modal-content">
                  <div class="modal-header  accent-1">
                      <h5 class="modal-title white-text" ><i class="fa fa-user-circle  mr-3 " aria-hidden="true"></i>Изменить телеграм @username </h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
                  </div>
                  <div class="modal-body">
                      <table class="table">
                          <tbody>
                          <tr>
                              <td><i class="fa fa-telegram fa-5x mr-1" aria-hidden="true"></i></td>
                              <td class="lead">
                                      Чтобы изменить ваш @username в телеграм, воспользуйтесь кнопкой "Личный кабинет" в меню нашего <#if userHash??><a href="${botLink}?start=${userHash}">бота</a><#else><a href="${botLink}"> бота </a></#if>.
                              </td>
                          </tr>
                          </tbody>
                      </table>
                  </div>
                  <div class="modal-footer text-center">

                      <form action="${botLink}" method="get">
                          <#if userHash??><input type="hidden" name="start" value="${userHash}"></#if>
                          <button type="submit" class="btn btn-info">Перейти к боту</button>
                      </form>
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                  </div>
              </div>
          </div>
      </div>
    <div class="modal fade" id="referalLinkWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-notify modal-info" role="document">
              <div class="modal-content">
                  <div class="modal-header cyan">
                      <h5 class="modal-title white-text" ><i class="fa fa-handshake-o mr-3 white-text" aria-hidden="true"></i>Реферальная ссылка</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
                  </div>
                  <div class="modal-body text-center ">
                     Чтобы пригласить рефералов, отправьте эту <a href="${siteURL}?ref=${user.id}">ссылку</a>.
                  </div>
                  <div class="modal-footer text-center">
                      <a role="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Закрыть</a>
                  </div>
              </div>
          </div>
      </div>

    <section id="subscription1"> </section>
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
                      <#if (user.trainingGroups?? && user.trainingGroups?size>0)><i class="fa fa-check-square fa-5x green-text" aria-hidden="true"></i></i>
                      <#else><i class="fa fa-exclamation-triangle fa-5x orange-text" aria-hidden="true"></i></#if>
                  </td>
                  <td class="lead">
                    <#if (user.trainingGroups?? && user.trainingGroups?size>0)>
                      <#list user.trainingGroups as training>
                          Вы записаны на курс: ${training.course.name}
                      </#list>
                    <#else>Запишитесь на курс
                    </#if>
                  </td>
                </tr>
                </tbody>
              </table>
              </div>
            <div class="card-footer text-center ">
                <#if (user.trainingGroups?? && user.trainingGroups?size>0)>
                <#--<button type="button" class="btn btn-purple" data-toggle="modal" data-target="#trainingWindow">Отправить ДЗ </button>-->
                <#else >
                <button type="button" class="btn btn-purple" data-toggle="modal" data-target="#trainingWindow">Записаться</button>
                </#if>
            </div>
          </div>
          </div>
        </div>
      </div>
      <#--homework-->
    <#if (user.trainingGroups?? && user.trainingGroups?size > 0)>
    <section id="homework"></section>
    <div class="container container-fluid">
        <div class="row wow fadeIn">
            <div class="col-md-12 mb-4">
                <div class="card"  >
                    <div class="card-header text-center "><i class="fa fa-file text-info mr-3 " aria-hidden="true"></i>Ваши работы</div>
                    <div class="card-body blue lighten-5">
                        <#if (user.homeworks?? && user.homeworks?size >0)>
                            <table class="table table-hover">
                                <thead>
                                <th>id</th>
                                <th>дата</th>
                                <th>статус</th>
                                </thead>
                                <tbody >
                                <#list user.homeworks as homework>
                                <#assign homeworkDate=(""+homework.dateTimeOfCreation)?date("yyyy-MM-dd")>
                                <tr>
                                    <td>${homework.id}</td>
                                    <td>${homeworkDate}</td>
                                    <td><#if homework.verified??>Оценка ${homework.rating}><#else>не проверено</#if></td>
                                </tr>
                                </#list>
                            </table>
                        <#else> Вы пока не отправили ни однного задания
                        </#if>
                    </div>
                    <div class="card-footer">
                        <button type="button" class="btn btn-pink" data-toggle="modal" data-target="#homeworkWindow">Отправить ДЗ </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </#if>

    <section id="profile"> </section>
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
                    <td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#modalProfileFirstName"><i class="fa fa-cog" aria-hidden="true"></i></button></td>
                  </tr>
                  <tr>
                    <th scope="row">Фамилия</th>
                    <td><#if user.userData??&&user.userData.lastName??>${user.userData.lastName}</#if></td>
                    <td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#modalProfileLastName"><i class="fa fa-cog" aria-hidden="true"></i></button></td>
                  </tr>
                  <tr>
                    <th scope="row"><i class="fa fa-lock mr-1" aria-hidden="true"></i>Пароль</th>
                    <td>*******</td>
                    <td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#modalProfilePassword"><i class="fa fa-cog" aria-hidden="true"></i></button></td>
                  </tr>
                  <tr>
                    <th scope="row"><i class="fa fa-envelope-o mr-1" aria-hidden="true"></i>email</th>
                    <td><#if user.userData.email??>${user.userData.email}</#if></td>
                    <td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#modalProfileMail"><i class="fa fa-cog" aria-hidden="true"></i></button></td>
                  </tr>
                  <tr>
                    <th scope="row"><i class="fa fa-telegram text-primary mr-1" aria-hidden="true"></i> telegram</th>
                    <td><#if user.userData.telegramNikcName??>${user.userData.telegramNikcName}<#else>не настроен</#if></td>
                    <td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#changeTelegramUsername"><i class="fa fa-cog" aria-hidden="true"></i></button></td>
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
            <div class="card-header text-center"><i class="fa fa-handshake-o mr-3 text-default" aria-hidden="true"></i>Рефералы</div>
            <div class="card-body cyan lighten-5">
              <table class="table table-hover">
                <tbody>
                <tr>
                  <th scope="row">Количество рефералов </th>
                  <td><#if numberOfAllReferals??>${numberOfAllReferals}<#else>0</#if></td>
                </tr>
                <tr>
                  <th scope="row">Оплатили услуг на сумму $</th>
                  <td><#if sumPaymentOfReferals??>${sumPaymentOfReferals}<#else>0</#if></td>
                </tr>
                <tr>
                    <th scope="row">Вам начислено $ </th>
                    <td><#if user.getBonusWallet()??&&user.getBonusWallet().usdBonus??>${ user.getBonusWallet().usdBonus}<#else>0</#if></td>
                </tr>
                </tbody>
              </table>
            </div>
            <div class="card-footer text-center ">
              <button type="button" class="btn btn-default " data-toggle="modal" data-target="#referalLinkWindow">Пригласить</button>
            </div>
          </div>
        </div>
        <div class="col-md-4"></div>
      </div>
    </div>

    <section id="bonusWallet"></section>
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
                  <td class="lead">На вашем счету
                  <#if user.getBonusWallet()??&&user.getBonusWallet().candyWrapers??>
                  ${user.getBonusWallet().candyWrapers}
                      <#if (user.getBonusWallet().candyWrapers==1)>
                       бонус
                      <#elseif (user.getBonusWallet().candyWrapers>1&&user.getBonusWallet().candyWrapers<5)>
                        бонуса
                      <#else>бонусов
                      </#if>
                  <#else>0 бонусов
                  </#if> </td>
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


  <script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="js/popper.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/mdb.min.js"></script>
  <script src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
  <#--scrolling nav-->
  <script src="js/scrolling-nav.js"></script>
  <#-- Animations initialization-->
  <script type="text/javascript">new WOW().init();</script>
  <#--проверка пароля-->
  <script>
      $(function(){
          $('#changePassword').validate({
              rules: {
                  password1: {
                      required: true,
                      minlength: 8,
                      pwcheck: true
                  },
                  password2: {
                      required: true,
                      minlength: 8,
                      equalTo: "#password1",
                      pwcheck: true
                  },
              },
              messages: {
                  password1: {
                      required: "Обязательно к заполнению",
                      minlength: "Введите не менее 8-ми символов",
                      pwcheck: "Недопустимые символы"
                  },
                  password2: {
                      required: "Обязательно к заполнению",
                      minlength: "Введите не менее 8-ми символов",
                      equalTo: "Пароли не совпадают",
                      pwcheck: "Недопустимые символы"
                  }
              }
          });
          $.validator.addMethod("pwcheck",
                  function(value, element) {
                      return /^[A-Za-z0-9\d=!\-@._*]+$/.test(value);
                  });
      });
  </script>
<#if userHash??>
      <script type="text/javascript">
          $(window).on('load',function(){
              $('#botLinkModal').modal('show');
          });
      </script>
<#elseif paidOrder??>
        <script type="text/javascript">
            $(window).on('load',function(){
                $('#paidOrderModal').modal('show');
            });
        </script>
<#elseif succes??>
        <script type="text/javascript">
    $(window).on('load',function(){
        $('#succesWindow').modal('show');
    });
</script>
</#if>

</body>

</html>