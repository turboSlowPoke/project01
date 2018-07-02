<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  
  <title>ТВ не скажет</title>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
  <!-- Bootstrap core CSS -->
  <link href="/css/bootstrap.min.css" rel="stylesheet">
  <!-- Material Design Bootstrap -->
  <link href="/css/mdb.css" rel="stylesheet">
  <!-- Your custom styles (optional) -->
  <link  href="/css/style.css" rel="stylesheet">
</head>

<body>

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
          <li class="nav-item">
            <a class="nav-link" href="/">Главаная </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/about">О нас</a>
          </li>
          <li class="nav-item ">
            <a class="nav-link" href="/contacts">Контакты</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="/faq">FAQ
              <br> </a>
          </li>
        </ul>
        <ul class="navbar-nav nav-flex-icons">
          <li class="nav-item pr-lg-3">
            <a href="#" class="nav-link"  title="Авторизоваться через Google" data-toggle="tooltip" data-placement="bottom">
              <i class="fab fa-google" aria-hidden="true"></i>
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

<#if homework??>
<main class="pt-5 mt-5">
    <div class="container">
        <div class="row">
            <div class="card">
                <div class="card-header text-center">
                    <i class="fas fa-chalkboard-teacher text-info mr-3 " aria-hidden="true"></i>Домашняя работа
                </div>
                <div class="card-body">
                    <div class="table-wrapper-2">
                        <table class="table table-responsive-md">
                            <tr>
                                <th scope="row">${homework.id}</th>
                                <td>${homework.dateTimeOfCreation}</td>
                                <td>${homework.name}</td>
                                <td><#if homework.rating??>${homework.rating}<#else>не проверено</#if></td>
                                <td><form action="/lk/delete_homework" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="hidden" name="id" value="${homework.id}">
                                    <a class="text red-text" href="#" onclick="this.parentNode.submit()" title="Удалить! Внимание удаление не отменить!" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-times" aria-hidden="true"></i></a>
                                </form></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="card">
                <div class="card-header"> Текст</div>
                <div class="card-body"><#if homework.body??>${homework.body}</#if> </div>
            </div>
        </div>
        <div class="row">
            <div class="card mt-3">
                <div class="card-header">Изображения</div>
                <div class="card-body">
                    <#if homework.files??>
                        <#list homework.files as file>
                            <img class="img-fluid my-2 py-2 border-default" src="/homeworkfiles/${file}">
                        </#list>
                    </#if>
                </div>
            </div>
        </div>
    </div>

</main>
<#else>
<p class="lead m-5 pt-5">Такого задания не существует</p>
</#if>


  <footer class="page-footer text-center font-small mt-4 wow fadeIn fixed-bottom">
    <div class="footer-copyright py-3"> © 2018 Copyright:
      <a href="#"> ontvnotshow.com </a>
    </div>
  </footer>

  <!-- JQuery -->
  <script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="/js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="/js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="/js/mdb.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <!-- Initializations -->
<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
</script>
</body>

</html>