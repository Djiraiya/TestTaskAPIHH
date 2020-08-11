<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<body>

<div align="center">
    <h2>HH API</h2>
    <form method="get" action="search">
        <input type="text" name="keyword" />
        <input type="submit" value="Поиск" />
    </form>
</div>

<div align="left">
    <h3>Список специализаций</h3>
    <form method="get" action="export">
        <div class="select">
        <select id="specializationId" name="specialization" onchange="set2GetParameter('specialization', this.options[this.selectedIndex].value, 'area', area.options[area.selectedIndex].value)">
            <option value="0" disabled selected>Выберите специализацию</option>
            <option value="1" label="Информационные технологии, интернет, телеком" ${param.specialization == '1' ? 'selected' : ''}></option>
            <option value="24" label="Спортивные клубы, фитнес, салоны красоты" ${param.specialization == '24' ? 'selected' : ''}></option>
        </select>

        <select id="areaId" name="area"  onchange="set2GetParameter('specialization', specialization.options[specialization.selectedIndex].value, 'area', this.options[this.selectedIndex].value)">
            <option disabled selected>Выберите населенный пункт</option>
            <option value="4" label="Новосибирск" ${param.area == '4' ? 'selected' : ''}></option>
            <option value="47" label="Кемерово"  ${param.area == '47' ? 'selected' : ''}></option>
        </select>

        </div>
        <input id="btn-export" ${(param.specialization > 0 && param.area > 0) ? 'visible' : 'hidden' } type="submit" value="Экспорт">
    </form>

</div>

<div align="center">
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
        <c:forEach items="${vacansyList}" var="vacansy">
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

    <tr>
        <td colspan="7">
            <c:forEach begin="${1}" end="${pageCount}" step="1" varStatus="i">
                <c:url value="/" var="url">
                    <c:param name="page" value="${i.index-1}"/>
                    <c:param name="specialization" value="${param.specialization}"/>
                    <c:if test="${param.area > 0}">
                          <c:param name="area" value="${param.area}"/>
                    </c:if>
                </c:url>
                <a href="${url}">${i.index}</a>
            </c:forEach>

        </td>
    </tr>
</div>

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
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
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

<script>
    function set2GetParameter(paramName, paramValue, paramName2, paramValue2)
    {
        if (document.getElementById("specializationId").options.selectedIndex != 0 && document.getElementById("areaId").options.selectedIndex != 0) {
            document.getElementById("btn-export").hidden = false;
            window.location.search = "?" + paramName + "=" + paramValue + "&" + paramName2 + "=" + paramValue2;
        }
    }
</script>
