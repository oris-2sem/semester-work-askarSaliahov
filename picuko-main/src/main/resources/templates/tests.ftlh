<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<body>
    <div class="w-50 m-auto">
        <h1 style="margin-top: 10px; text-align: center">Тесты</h1>
        <#list tests as test>
            <div style="border: 1px solid darkgray; margin-bottom: 2.3rem; padding: 10px">
                <h3 style="display: inline-block; margin-right: 5px">${test.name}</h3>
                <b style="color: lightcoral">${test.topic.name}</b>
                <p>${test.description}</p>
                <button type="button"><a href="/tests/${test.id}">Пройти</a></button>
            </div>
        </#list>
    </div>
</body>
</html>