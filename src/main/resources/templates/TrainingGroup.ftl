<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css">
</head>

<body class="">
  <div class="py-1 pt-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h3 class="pt-5">Группа ${group.name}  ${group.startSet} - ${group.endSet} </h3>
          <p class="lead">Курс ${group.course.name}</p>
          <p class="lead">здесь нужна ссылка на @телеграм группу</p>
          <a class="btn btn-primary" href="/admin" >Вернуться к списку групп </a>
        </div>
      </div>
    </div>
  </div>

  <#if group.users?? && (group.users?size>0)>
      <div class="p-1">
          <div class="container">
              <div class="row">
                  <div class="col-md-12">
                      <div class="card">
                          <div class="card-header">Студетны</div>
                          <div class="card-body">
                              <table class="table">
                                  <thead>
                                  <tr>
                                      <th class="w-25">Имя</th>
                                      <th>@telegram</th>
                                      <th>ДЗ</th>
                                  </tr>
                                  </thead>
                                  <tbody>
                                  <#list group.users as user>
                                     <tr>
                                         <td><#if user.userData.firstName??>${user.userData.firstName}<#else>Без имени</#if></td>
                                         <td><#if user.userData.telegramNikcName??>${user.userData.telegramNikcName}<#else>Без ника</#if></td>
                                         <td><#if user.homeworks??><a href="/admin/homework/${user.id}">ДЗ</a></#if></td>
                                     </tr>
                                  </#list>
                                  </tbody>
                              </table>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
      </div>
  </#if>

  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>

</html>