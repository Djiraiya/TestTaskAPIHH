<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Search Result</title>
</head>
<body>
<div align="center">
    <div class="horizontal">
    <h2>Результаты поиска</h2>
        <a href="/">Вернуться на главную</a>
    </div>
        <table id="myTable" border="1" cellpadding="5">
            <tr>
                <th onclick="sortTable(0)">ID</th>
                <th onclick="sortTable(1)">Название</th>
                <th onclick="sortTable(2)">Дата публикации</th>
                <th onclick="sortTable(3)">Работодатель</th>
                <th onclick="sortIntTable(4)">Зарплата от</th>
                <th onclick="sortIntTable(5)">Зарплата до</th>
                <th onclick="sortTable(6)">Валюта</th>
            </tr>
            <c:forEach items="${result}" var="vacansy">
                <tr>
                    <td>${vacansy.id}</td>
                    <td>${vacansy.name}</td>
                    <td>${vacansy.published_at}</td>
                    <td>${vacansy.employer.name}</td>
                    <td>${vacansy.salary.from}</td>
                    <td>${vacansy.salary.to}</td>
                    <td>${vacansy.salary.currency}</td>
                </tr>
            </c:forEach>
    </table>
</div>
</body>
</html>

    <script>
        function sortTable(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("myTable");
            switching = true;
            dir = "asc";
            while (switching) {
                switching = false;
                rows = table.rows;
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            // If so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            // If so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount ++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }
    </script>

    <script>
        function sortIntTable(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("myTable");
            switching = true;
            dir = "asc";
            while (switching) {
                switching = false;
                rows = table.rows;
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];

                    var x1, y1;
                    switch (rows[i].getElementsByTagName("TD")[6].innerHTML) {
                        case "RUR": x1 = isNaN(parseInt(x.innerHTML)) ? -1 : parseInt(x.innerHTML);
                                    break;
                        case "USD": x1 = isNaN(parseInt(x.innerHTML)) ? -1 : parseInt(x.innerHTML) * 70;
                                    break;
                        case "EUR": x1 = isNaN(parseInt(x.innerHTML)) ? -1 : parseInt(x.innerHTML) * 80;
                                    break;
                        default: x1 = isNaN(parseInt(x.innerHTML)) ? -1 : parseInt(x.innerHTML);
                                 break;
                    }

                    switch (rows[i + 1].getElementsByTagName("TD")[6].innerHTML) {
                        case "RUR":
                            y1 = isNaN(parseInt(y.innerHTML)) ? -1 : parseInt(y.innerHTML);
                            break;
                        case "USD":
                            y1 = isNaN(parseInt(y.innerHTML)) ? -1 : parseInt(y.innerHTML) * 70;
                            break;
                        case "EUR":
                            y1 = isNaN(parseInt(y.innerHTML)) ? -1 : parseInt(y.innerHTML) * 80;
                            break;
                        default:
                            y1 = isNaN(parseInt(y.innerHTML)) ? -1 : parseInt(y.innerHTML);
                            break;
                    }
                    if (dir == "asc") {
                        if (x1 > y1) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x1 < y1) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount ++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }
    </script>
