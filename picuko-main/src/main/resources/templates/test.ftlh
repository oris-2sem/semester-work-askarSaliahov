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
<style>
    .question-disable {
        display: none;
    }

    .button-disable {
        display: none;
    }
</style>
<body>
    <form class="form">
        <div class="w-75 m-auto">
            <h1 class="mt-5 mb-5 text-center">${test.name}</h1>
            <h5>${test.topic.name}</h5>
            <p>${test.description}</p>
            <hr>

            <#list test.questions as question>

                <div class="mb-5 question" id="${question?index}">
                    <div class="alert alert-dark" role="alert">
                        ${question.text}
                    </div>

                    <#list question.answers as answer>

                        <div style="margin-left: 20px">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="answer-${question?index}" value="${answer?index}">
                                <label class="form-check-label" >
                                    ${answer}
                                </label>
                            </div>
                        </div>
                    </#list>

                </div>
            </#list>

            <button type="button" class="btn btn-danger prev-question">Prev</button>
            <button type="button" class="btn btn-primary next-question">Next</button>

            <div class="mt-5">
                <button type="submit" class="btn btn-outline-success check-results">Завершить</button>
            </div>
        </div>
    </form>
    <div class="w-75 m-auto d-none result-block">
        <h1 class="mt-5 text-center">Ваш результат: <b class="result"></b> points</h1>
        <button class="text-center mt-5"><a href="/tests">К тестам</a></button>
    </div>
</body>

<script>
    let index;
    const questions = document.querySelectorAll(".question");
    const nextQuestionButton = document.querySelector(".next-question");
    const prevQuestionButton = document.querySelector(".prev-question");
    const finishButton = document.querySelector(".check-results");
    const form = document.querySelector(".form");
    const inputs = document.querySelectorAll("input[type=radio]");
    const resultBlock = document.querySelector(".result-block");
    const result = document.querySelector(".result");

    form.addEventListener("submit", function (e) {
        e.preventDefault();
        const list = [];
        inputs.forEach(input => {
            if (input.checked) {
                list.push(input.value);
            }
        })

        fetch("/tests/${test.id}", {
            method: "post",
            headers: new Headers({ "content-type": "application/json" }),
            body: JSON.stringify(list)
        }).then(res => res.json())
            .then(res => {
                form.classList.add("d-none");
                result.innerHTML = res.result === undefined ? 0 : res.result;
                resultBlock.classList.remove("d-none");
            })
            .catch(err => console.error(err))

    });

    function processNextQuestion() {

        questions.forEach(question => {
            const id = +question.getAttribute("id");
            if (id !== index) {
                question.classList.add("question-disable");
            } else {
                question.classList.remove("question-disable");
            }
        });

    }

    function processPrevQuestion() {
        questions.forEach(question => {
            const id = +question.getAttribute("id");
            if (id !== index) {
                question.classList.add("question-disable");
            } else {
                question.classList.remove("question-disable");
            }
        });

    }

    document.addEventListener("DOMContentLoaded", function () {
        index = 0;
        prevQuestionButton.classList.add("button-disable");
        processNextQuestion();
    });

    nextQuestionButton.addEventListener("click", function () {
        prevQuestionButton.classList.remove("button-disable");

        if (index < questions.length - 1) {
            index = index + 1;

            if (index === questions.length - 1) {
                nextQuestionButton.classList.add("button-disable");
            } else {
                nextQuestionButton.classList.remove("button-disable");
            }

            processNextQuestion();
        }

    });

    prevQuestionButton.addEventListener("click", function () {
        nextQuestionButton.classList.remove("button-disable");

        if (index > 0) {
            index = index - 1;

            if (index === 0) {
                prevQuestionButton.classList.add("button-disable");
            } else {
                prevQuestionButton.classList.remove("button-disable");
            }

            processPrevQuestion();
        }
    })


</script>
</html>