#!/bin/bash

methods=("GET" "POST" "PUT" "PATCH" "DELETE")

url_links=("index.html" "api/data" "resources/file.txt" "users.log" "info.htnl" "stuff.html")

http_codes=(200 201 400 401 403 404 500 501 502 503)

# 200 OK: Запрос был успешно обработан, и ответ содержит запрашиваемые данные.

# 201 Created: Запрос был успешно обработан, и в результате был создан новый ресурс.

# 400 Bad Request: Сервер не может понять запрос из-за некорректного синтаксиса или других ошибок клиента.

# 401 Unauthorized: Клиент не авторизован для доступа к запрашиваемому ресурсу. Требуется предоставить дополнительные аутентификационные данные.

# 403 Forbidden: Клиент не имеет доступа к запрашиваемому ресурсу из-за ограничений, установленных сервером.

# 404 Not Found: Запрашиваемый ресурс не найден на сервере.

# 500 Internal Server Error: Произошла внутренняя ошибка сервера, которая не позволяет выполнить запрос.

# 501 Not Implemented: Сервер не поддерживает функциональность, необходимую для выполнения запроса.

# 502 Bad Gateway: Сервер, выступая в роли шлюза или прокси-сервера, получил некорректный ответ от внешнего сервера.

# 503 Service Unavailable: Сервер временно не может обрабатывать запросы из-за временной перегрузки или обслуживания.

user_agent=("(Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36" # Google
            "(Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/110.0" # Mozilla Firefox
            "(Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko" # Internet Explorer
            "(Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 OPR/96.0.0.0 (Edition Yx 05)" # Opera
            "(Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.57" #Microsoft Edge
            "(Windows NT 6.2; WOW64) AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2" # Safari
            "(compatible; PRTG Network Monitor (www.paessler.com); Windows)" #Crawler
            "(compatible; YandexBot/3.0; +http://yandex.com/bots)" # Bot
            "(compatible; PostmanRuntime/7.26.5; Windows)" # Library
            "(compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)" # Net tool
          )