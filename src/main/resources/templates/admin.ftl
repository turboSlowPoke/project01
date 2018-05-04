<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css"> </head>

<body>
<div class="modal" id="modal01">
    <div class="modal-dialog" role="document" >
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Выполнено</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <p >
                    <#if signalsSended?? >
                        Сигналы отправлены ${signalsSended} юзерам
                    <#elseif trainingGroup??>
                        Группа создана
                        <p>Курс: ${trainingGroup.course.name}
                        <p>Название: ${trainingGroup.name}</p>
                        <p>Начало набора ${trainingGroup.startSet}</p>
                        <p>Конец набора ${trainingGroup.endSet}</p>
                    </#if>
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
  <#if trainingGroupList?? && (trainingGroupList?size > 0)>
      <div class="py-2">
          <div class="container">
              <div class="row">
                  <div class="col-md-12">
                      <div class="card">
                          <div class="card-header"> Список групп</div>
                          <div class="card-body">
                              <table class="table">
                                  <thead>
                                  <tr>
                                      <th class="w-25">дата</th>
                                      <th>Название</th>
                                      <th>Студетны</th>
                                      <th> Ссылка</th>
                                  </tr>
                                  </thead>
                                  <tbody>
                                  <#list trainingGroupList as group>
                                  <tr>
                                      <td>${group.startSet} - ${group.endSet}</td>
                                      <td><#if group.name??>${group.name}</#if></td>
                                      <td><#if group.users??>${group.users?size}</#if></td>
                                      <th><a href="/admin/group?group=${group.id}">подробнее</a></th>
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

  <div class="py-2">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                <#if signalsSended??>
                    <div class="card-header text-success"> Сигнал отправлен ${signalsSended} юзерам </div>
                <#else><div class="card-header text-success"> Отправить сигнал </div>
                </#if>
                        <div class="card-body">
                            <form id="signalsForm" method="post" action="/admin">
                                <div class="form-group"> <label for="exampleFormControlInput1">Заголовок</label>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="hidden" name="method" value="sendSignal"/>
                                    <input name="header" type="text" class="form-control" id="signalHeader"> </div>
                                <div class="form-group"> <label for="exampleFormControlTextarea1">Текст сигнала</label>
                                    <textarea name="body" class="form-control" id="signalBody" rows="7"></textarea> </div>
                                <button type="submit">Отправить</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
  <div class="py-2">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
              <div class="card">
                  <div class="card-header">Создать набор на курс</div>
                  <div class="card-body">
                      <form id="createTrainingGroup" method="post" action="/admin">
                          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                          <input type="hidden" name="method" value="createTrainingGroup"/>
                          <div class="form-group">
                              <label for="exampleFormControlInput1">Название группы</label>
                              <input name="groupName" type="text" required="required" class="form-control"> </div>
                          <div class="form-group">
                              <label for="exampleFormControlInput1">Дата начала набора</label>
                              <input name="startSet" type="date" class="form-control" required="required"> </div>
                          <div class="form-group">
                              <label for="exampleFormControlInput1">Дата конца набора</label>
                              <input name="endSet" type="date" class="form-control" required="required"> </div>
                          <button type="submit">Создать</button>
                      </form>
                  </div>
              </div>
          </div>
        <div class="col-md-6">
          <div class="card">
            <div class="card-header"> Статистика</div>
            <div class="card-body">
              <p>Юзеров в базе = ${countUsers}</p>
              <p>Активных подписок на сигналы = ${countActiveSubscribe}</p>
              <p>Оплативших обучение = ${countUsersWithTraining}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>


  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

      <#if trainingGroup?? || signalsSended??>
      <script type="text/javascript">
          $(window).on('load',function(){
              $('#modal01').modal('show');
          });
      </script>
      </#if>

</body>

</html>