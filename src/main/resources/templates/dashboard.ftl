<!DOCTYPE html>
<html lang="ru">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>По ТВ не скажут</title>
    <link rel="icon" href="/img/icon.png">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/lk/font-awesome-animation.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
  <!-- Bootstrap core CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <!-- Material Design Bootstrap -->
  <link href="css/mdb.min.css" rel="stylesheet">
  <!-- Your custom styles (optional) -->
  <link href="css/lk/style.css" rel="stylesheet">
  </head>

<body>

  <header>
    <nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar">
      <div class="container-fluid">
        <a class="navbar-brand waves-effect" href="/#" target="_blank">
            <strong>
                <i class="fa fa-television" aria-hidden="true"></i>
                <i class="fa fa-line-chart" aria-hidden="true"></i>
            </strong>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <a class="nav-link waves-effect" href="/">Главная  </a>
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
                   <li class="nav-item active grey darken-3 rounded rounded-2 mr-3">
                       <b class="nav-link waves-effect" ">
                       <i class="fa fa-user indigo-text mr-1" aria-hidden="true"></i>
                       <span class="sr-only">(current)</span>
                  <#if user.login??>${user.login}
                  <#elseif user.userData??&&user.userData.telegramNikcName??>
                      ${user.userData.telegramNikcName}
                  <#elseif user.userData.firstName??>${user.userData.firstName}
                  </#if>
                       </b>
                   </li>
                   <li class="nav-item">
                       <a href="/logout" class="nav-link border border-light rounded waves-effect">
                           <i class="fas fa-sign-out-alt orange-text mr-1" aria-hidden="true"></i>Выйти</a>
                   </li>
               </ul>
            <#else>
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
            </#if>
        </div>
      </div>
    </nav>

    <div class="sidebar-fixed position-fixed ">

      <div class="list-group list-group-flush" id="mainNav">
        <a href="#subscription1" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-shopping-basket mr-3"></i>Подписки</a>
        <#if (user.trainingGroups?? && user.trainingGroups?size > 0)><a href="#homework" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-file mr-3"></i>Домашние задания</a></#if>
        <a href="#profile" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-user mr-3"></i>Профиль</a>
        <a href="#referals" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-handshake-o mr-3"></i>Реферальная программа</a>
        <a href="#bonusWallet" class="list-group-item list-group-item-action waves-effect js-scroll-trigger"> <i class="fa fa-money mr-3"></i>Бонусы</a>
      </div>
    </div>
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
                          Присоедитесь к нашему боту в telegram <i class="fab fa-telegram" aria-hidden="true"></i>
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
                  <#if (sumUncheckedHomework<2)>
                      <form class="form-group" action="/lk/add_homework" method="post" enctype="multipart/form-data">
                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                      <div class="modal-body text-center">
                          <table class="table">
                              <tbody>
                              <tr>
                                  <td><i class="fa fa-file faa-ring animated pink-text fa-5x" ></i></td>
                                  <td class="lead">
                                      <input type="text" required name="name" class="form-control" placeholder="Введите название">
                                      <br><br>
                                      <input type="file" multiple name="files" class="form-control-file">
                                      <br><br>
                                      <textarea class="form-control border-info" placeholder="введите текс" name="body" rows="10"></textarea>
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
                  <#else>
                      <div class="modal-body text-center">
                          Вы не можете отправить работу на проверку. У вас может быть не более двух непроверенных работ.
                          Дождитесь проверки или удалите одну из последниx.
                      </div>
                      <div class="modal-footer text-center">
                          <a role="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Отмена</a>
                      </div>
                  </#if>
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
              <input type="text" required name="firstName" class="form-control"  placeholder="Введите имя">
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
                  <td><i class="fas fa-envelope fa-5x mr-1" aria-hidden="true"></i></td>
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
                      <h5 class="modal-title white-text" id="exampleModalLabel"><i class="fa fa-user-circle  mr-3 " aria-hidden="true"></i>Телеграм @username</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
                  </div>
                  <div class="modal-body">
                      <table class="table">
                          <tbody>
                          <tr>
                              <td><i class="fab fa-telegram fa-5x mr-1" aria-hidden="true"></i></td>
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
    <div class="modal fade" id="changeAdvcash" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
              <div class="modal-content">
                  <div class="modal-header light-blue accent-1">
                      <h5 class="modal-title white-text" id="exampleModalLabel"><i class="fa fa-user-circle  mr-3 " aria-hidden="true"></i> Смена Advcash</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span> </button>
                  </div>
                  <form action="/lk" method="post">
                      <div class="modal-body">
                          <div class="form-group">
                              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                              <input type="text" required name="advcash" class="form-control"  placeholder="Введите номер кошелька">
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
    <div class="modal fade" id="referalLinkWindow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-notify modal-info" role="document">
              <div class="modal-content">
                  <div class="modal-header cyan">
                      <h5 class="modal-title white-text" ><i class="fa fa-handshake-o mr-3 white-text" aria-hidden="true"></i>Реферальная ссылка</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
                  </div>
                  <div class="modal-body text-center ">
                     Чтобы пригласить рефералов, отправьте эту <a href="${siteURL}?ref=${user.id}">ссылку</a>.<br>
                      <textarea readonly placeholder="" rows="1" cols="30">${siteURL}?ref=${user.id}</textarea>
                  </div>
                  <div class="modal-footer text-center">
                      <a role="button" class="btn btn-outline-info waves-effect" data-dismiss="modal">Закрыть</a>
                  </div>
              </div>
          </div>
      </div>
    <div class="modal fade" id="referalPayOutBonus" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-notify modal-info" role="document">
              <div class="modal-content">
                  <div class="modal-header cyan">
                      <h5 class="modal-title white-text" ><i class="fa fa-handshake-o mr-3 white-text" aria-hidden="true"></i>Выплата реферальных</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true" class="white-text">×</span> </button>
                  </div>
                  <div class="modal-body text-center">
                      <#if (payOutOrders?? && payOutOrders?size>0)>
                          <#list payOutOrders as payOutOrder>
                              <#assign orderDate=(""+payOutOrder.createDate)?date("yyyy-MM-dd")>
                              Вы подали заявку на выплату ${orderDate}  id=<b>${payOutOrder.id}</b><br>
                              Ваши реферальные будут перечислены на кошелёк advcash: ${user.userData.advcash}
                          </#list>
                      <#else>
                      Прежде чем создать заявку на выплату проверьте номер вашего кошелька advcash.<br>
                      Номер вашего advcash: <#if user.userData.advcash??> ${user.userData.advcash}<#else> <i>не настроен</i> </#if>
                      Заявки обрабатываются в конце недели.
                      <a class="btn btn-green btn-sm" href="/lk/pay_out">Создать заявку</a><br>
                      </#if>
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
                        <#if (homeworkList?? && homeworkList?size >0)>
                            <table class="table table-hover">
                                <thead>
                                <th>id</th>
                                <th>дата</th>
                                <th>статус</th>
                                <th></th>
                                <th></th>
                                </thead>
                                <tbody >
                                <#assign countHomework=0>
                                <#list homeworkList as homework>
                                    <#if countHomework<5>
                                    <#assign countHomework=countHomework+1>
                                    <#assign homeworkDate=(""+homework.dateTimeOfCreation)?date("yyyy-MM-dd")>
                                <tr>
                                    <td>${homework.id}</td>
                                    <td>${homeworkDate}</td>
                                    <td><#if (homework.cheked?? && homework.cheked==true )>Оценка ${homework.rating}<#else>не проверено</#if></td>
                                    <td><a class="" href="/lk/homework/${homework.id}" title="Просмотр" data-toggle="tooltip" data-placement="bottom"><i class="fas fa-glasses text-success"></i></a></td>
                                    <td>
                                        <form action="/lk/delete_homework" method="post">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <input type="hidden" name="id" value="${homework.id}">
                                            <a class="text red-text" href="#" onclick="this.parentNode.submit()" title="Удалить это задание" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-times" aria-hidden="true"></i></a>
                                        </form>
                                    </td>
                                </tr>
                                    <#else>
                                        <#break>
                                    </#if>
                                </#list>
                            </table>
                        <#else> Вы пока не отправили ни однного задания
                        </#if>
                    </div>
                    <div class="card-footer">
                        <button type="button" class="btn btn-pink" data-toggle="modal" data-target="#homeworkWindow">Отправить ДЗ </button>
                        <#if (homeworkList?? && homeworkList?size >5)>
                        <a class="btn btn-blue-grey" href="/lk/list_my_homeworks" title="Открыть весь спикок" data-toggle="tooltip" data-placement="bottom"><i class="fas fa-table mr-1"></i> Список работ</a>
                        </#if>
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
                     <td>
                         <a class="text text-info littleButton" data-toggle="modal" data-target="#modalProfileFirstName"><i class="fa fa-cog" aria-hidden="true"></i></a>
                         <button type="button" class="btn btn-info btn-sm bigButton" data-toggle="modal" data-target="#modalProfileFirstName"><i class="fa fa-cog" aria-hidden="true"></i></button>
                     </td>
                  </tr>
                  <tr>
                    <th scope="row">Фамилия</th>
                    <td><#if user.userData??&&user.userData.lastName??>${user.userData.lastName}</#if></td>
                    <td>
                        <a class="text text-info littleButton" data-toggle="modal" data-target="#modalProfileLastName"><i class="fa fa-cog" aria-hidden="true"></i></a>
                        <button type="button" class="btn btn-info btn-sm bigButton" data-toggle="modal" data-target="#modalProfileLastName"><i class="fa fa-cog" aria-hidden="true"></i></button></td>
                  </tr>
                  <tr>
                    <th scope="row"><i class="fa fa-lock mr-1" aria-hidden="true"></i>Пароль</th>
                    <td>*******</td>
                    <td>
                        <a class="text text-info littleButton" data-toggle="modal" data-target="#modalProfilePassword"><i class="fa fa-cog" aria-hidden="true"></i></a>
                        <button type="button" class="btn btn-info btn-sm bigButton" data-toggle="modal" data-target="#modalProfilePassword"><i class="fa fa-cog" aria-hidden="true"></i>
                        </button></td>
                  </tr>
                  <tr>
                    <th scope="row"><i class="fas fa-envelope mr-1" aria-hidden="true"></i>email</th>
                    <td><#if user.userData.email??>${user.userData.email}</#if></td>
                    <td>
                        <a class="text text-info littleButton" data-toggle="modal" data-target="#modalProfileMail"><i class="fa fa-cog" aria-hidden="true"></i></a>
                        <button type="button" class="btn btn-info btn-sm bigButton" data-toggle="modal" data-target="#modalProfileMail"><i class="fa fa-cog" aria-hidden="true"></i></button>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row"><i class="fab fa-telegram text-primary mr-1" aria-hidden="true"></i> telegram</th>
                    <td><#if user.userData.telegramNikcName??>${user.userData.telegramNikcName}<#else>не настроен</#if></td>
                    <td>
                        <a class="text text-info littleButton" data-toggle="modal" data-target="#changeTelegramUsername"><i class="fa fa-cog" aria-hidden="true"></i></a>
                        <button type="button" class="btn btn-info btn-sm bigButton" data-toggle="modal" data-target="#changeTelegramUsername"><i class="fa fa-cog" aria-hidden="true"></i></button>
                    </td>
                  </tr>
                  <tr>
                      <th scope="row"><i class="fa fa-credit-card text-primary mr-1" aria-hidden="true"></i> advcash</th>
                      <td><#if user.userData.advcash??>${user.userData.advcash}<#else>не настроен</#if></td>
                      <td>
                          <a class="text text-info littleButton" data-toggle="modal" data-target="#changeAdvcash"><i class="fa fa-cog" aria-hidden="true"></i></a>
                          <button type="button" class="btn btn-info btn-sm bigButton" data-toggle="modal" data-target="#changeAdvcash"><i class="fa fa-cog" aria-hidden="true"></i></button>
                      </td>
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
              <#if (user.getBonusWallet()?? && user.getBonusWallet().usdBonus?? && user.getBonusWallet().usdBonus>0)>
                  <button type="button" class="btn btn-default " data-toggle="modal" data-target="#referalPayOutBonus">Выплатить</button>
              </#if>
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

  <footer class="text-center font-small mt-4 wow fadeIn">
      <!--Call to action-->
      <div class="footerUpSide">
          <hr class="my-4">
          <!--/.Call to action-->
          <!-- Social icons -->
          <div class="pb-4 footerMiddleSide text-white">
              <a href="#" class="text-white">
                  <i class="fab fa-vk mr-3"></i>
              </a>
              <a href="#" class="text-white">
                  <i class="fab fa-youtube mr-3"></i>
              </a>
              <a href="#" class="text-white">
                  <i class="fab fa-telegram mr-3"></i>
              </a>
              <a href="#" class="text-white">
                  <i class="fab fa-instagram mr-3"></i>
              </a>
          </div>
      </div>

      <!-- Social icons -->
      <!--Copyright-->
      <div class="footerDownSide py-3 text-white" > © 2018 Copyright:
          <a href="#" class="text-white"> potvneskazut.ru </a>
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
  <#--для подсказок-->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <#-- Animations initialization-->
  <script type="text/javascript">new WOW().init();
  <#--для подсказок-->
  $(function () {
      $('[data-toggle="tooltip"]').tooltip()
  })
  </script>
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