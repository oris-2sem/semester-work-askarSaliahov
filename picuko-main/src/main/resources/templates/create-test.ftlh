<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
    <title>Create test</title>
</head>
<body>
    <h1 class="text-center">Создание теста</h1>
    <div class="w-75 m-auto">

        <form class="question-form" method="post">
            <div class="input-group mb-3">
                <label class="input-group-text" for="inputGroupSelect01">Выбрать тему</label>
                <select name="topic" class="form-select" id="inputGroupSelect01">
                    <#list topics as topic>
                        <option value="${topic.id}">${topic.name}</option>
                    </#list>
                </select>
            </div>

            <div class="input-group mb-3">
                <span class="input-group-text" id="basic-addon1">Название</span>
                <input name="name" type="text" class="form-control" placeholder="Название" aria-label="Username" aria-describedby="basic-addon1">
            </div>

            <div class="form-floating" style="margin-bottom: 4.2rem">
                <textarea name="description" class="form-control" placeholder="Добавить описание" id="floatingTextarea2" style="height: 100px"></textarea>
                <label for="floatingTextarea2">Описание</label>
            </div>

            <div class="questions">
                <div class="question">
                    <h3 class="text-center mb-3">Добавьте вопрос</h3>

                    <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon1">Вопрос</span>
                        <input name="questionName" type="text" class="question-name form-control" placeholder="Вопрос" aria-label="Username" aria-describedby="basic-addon1">
                    </div>

                    <h5 class="text-center mb-3">Добавьте варианты ответов</h5>

                    <div class="w-25">
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="basic-addon1">A</span>
                            <input name="a" type="text" class="a form-control" placeholder="Ответ" aria-label="Username" aria-describedby="basic-addon1">
                        </div>

                        <div class="input-group mb-3">
                            <span class="input-group-text" id="basic-addon1">B</span>
                            <input name="b" type="text" class="b form-control" placeholder="Ответ" aria-label="Username" aria-describedby="basic-addon1">
                        </div>

                        <div class="input-group mb-3">
                            <span class="input-group-text" id="basic-addon1">C</span>
                            <input name="c" type="text" class="c form-control" placeholder="Ответ" aria-label="Username" aria-describedby="basic-addon1">
                        </div>

                        <div class="input-group mb-3">
                            <span class="input-group-text" id="basic-addon1">D</span>
                            <input name="d" type="text" class="d form-control" placeholder="Ответ" aria-label="Username" aria-describedby="basic-addon1">
                        </div>
                    </div>

                    <h5 class="text-center mb-3">Выберите правильный ответ</h5>

                    <div class="w-25 input-group mb-3">
                        <label class="input-group-text" for="inputGroupSelect01">Правильный вариант</label>
                        <select name="rightAnswer" class="right-answer form-select" id="inputGroupSelect01">
                            <option value="a">A</option>
                            <option value="b">B</option>
                            <option value="c">C</option>
                            <option value="d">D</option>
                        </select>
                    </div>

                </div>
            </div>

            <button type="submit" style="margin-top: 3.5rem; margin-bottom: 3.5rem" class="add-more btn btn-outline-secondary">Добавить еще вопрос</button>
        </form>

    </div>

</body>

<script>
    const form = document.querySelector(".question-form");
    const button = document.querySelector(".add-more");

    const questionName = document.querySelector(".question-name");
    const aAnswer = document.querySelector(".a");
    const bAnswer = document.querySelector(".b");
    const cAnswer = document.querySelector(".c");
    const dAnswer = document.querySelector(".d");
    const rightAnswer = document.querySelector(".right-answer");
    let testId = null;


    button.addEventListener("click", function (e) {

        e.preventDefault();

        const data = new FormData(form);

        const object = {};
        data.forEach((value, key) => object[key] = value);
        const json = JSON.stringify(object);

        if (testId === null) {
            fetch("/tests/create", {
                method: "post",
                headers: new Headers({ "content-type": "application/json" }),
                body: json
            })
                .then(response => response.json())
                .then(response => testId = response["testId"]);
        } else {
            fetch("/tests/" + testId, {
                method: "PATCH",
                headers: new Headers({ "content-type": "application/json" }),
                body: json
            })
                .then(response => response.json())
                .then(console.log)
                .catch(err => {})
        }

        questionName.value = "";
        aAnswer.value = "";
        bAnswer.value = "";
        cAnswer.value = "";
        dAnswer.value = "";
        rightAnswer.value = "";


    });
</script>
</html>