<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h3>Login with:</h3>

<#list urls as key, value>
  <a text="${key}" href="${value}">Client</a>
</#list>

<#--<p th:each="url : ${urls}">
    <a th:text="${url.key}" th:href="${url.value}">Client</a>
</p>-->

</body>
</html>