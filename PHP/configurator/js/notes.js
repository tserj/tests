/*
    Создание всплывающих подсказок на JS

 вызывать так:
 <div style="border: 1px #F00 dashed; display: inline-block;" id="test" onMouseOver="showFootnote(createTable(2,2,'some text'), 200, 20, 'test2', 'test', 500);"> 
    some text
 </div>
 
 
 Зависимости:
    x.gif - крестик закрытия (13x13)
 
    Стили:
    
    div.footnote_new, div.footnote_new_active {
      position: absolute;
      z-index: 10;
      display: none;
      width: 200px;
      font-size: 11px;
      padding: 3px;
      color: #666;
      background: #FBFBE5;
      border: 1px solid #C3C3C3
      text-align: left;
    }
    div.footnote_new_active { display: block }
 
    #x_image { position: absolute; right: 5px; top: 5px }

*/

var CURSOR_X = 0;
var CURSOR_Y = 0;

var X_IMAGE_SRC = "../images/x.gif";

// Устанавливаем обработчик движения мышкой
window.document.onmousemove = getXYPosition;

// Записывает значения курсора в глобальные переменные при движении мышкой
function getXYPosition(e) {
    x = y = 0;   

    if (window && window.event) { 
        var cursor = window.event;
        window.event.cancelBubble = true;
    } else {
        var cursor = e;
    }

    if (cursor.pageX || cursor.pageY) {
        x=cursor.pageX;
        y=cursor.pageY;
    } else if (cursor.clientX || cursor.clientY) {
        x=cursor.clientX + document.body.scrollLeft;
        y=cursor.clientY + document.body.scrollTop;
    } else if (cursor.screenX || cursor.screenY) {
        x=cursor.screenX;
        y=cursor.screenY;
    }
    
    CURSOR_X = x;
    CURSOR_Y = y;
    
    // вызов процедур обработки
    main();
} 

// Возвращает коорданаты слоя
function absPosition(obj) { 
    var left = tops = 0; 
    right = obj.offsetWidth;
    bottom = obj.offsetHeight;
    while(obj) { 
        left += obj.offsetLeft; 
        tops += obj.offsetTop;
        obj = obj.offsetParent; 
    } 
    return { left:left, right:right + left, top:tops, bottom:bottom + tops }; 
} 

// Проверяет принадлежность курсора слою
function isInDiv(id) {
    if (CURSOR_X == 0 && CURSOR_Y == 0) return false;
    layer = absPosition(document.getElementById(id));
    return (CURSOR_X >= layer.left && CURSOR_X <= layer.right &&
            CURSOR_Y >= layer.top && CURSOR_Y <= layer.bottom)
} 
      
// Записывает дебаг информацию в слой с id=debug
function debug(txt) {
    layer = document.getElementById('debug');
    layer.innerHTML = layer.innerHTML + "<br/>" + txt; 
}  

// Создает новый слой (подсказку) и устанавливает таймер закрытия
// txt - HTML текст
// width - ширина слоя
// offset - смещение вправо относительно вызывающего слоя
// newDivName - id нового слоя
// insertDiv - id вызывающего слоя
// closeDelay - задержка перед закрытием в мс.
function showFootnote(txt, width, offset, newDivName, insertDiv, closeDelay) {    
    div = document.getElementById(newDivName);
    if (div) return;

    f = document.createElement("div");
    f.setAttribute("id", newDivName);
    f.setAttribute("style", "display: block; top: 0px; left: 0px; width:"+width+"px; height:auto;");
    f.setAttribute("class", "footnote_new");
    document.body.appendChild(f);
    
    f.opacityFilter = 0;
    fn = "deleteLayer('"+newDivName+"')"; 
    f.innerHTML = '<img src="' + X_IMAGE_SRC + '" height="13" width="13" border="0" id="x_image" style="cursor:pointer; float:right;" onclick="'+fn+'"; /><div style="padding: 10px">' + txt + '</div>';
    f.className = 'footnote_new_active';

    f.style.display = 'block';
    f.style.textAlign = 'left';
    
    o = document.getElementById(insertDiv);

    var o_coords = absPosition(o);
    var f_coords = absPosition(f);
    
    var calculatedTop = (f.offsetTop + (o_coords.top - f_coords.top));
    var calculatedLeft = (f.offsetLeft + (o_coords.left - f_coords.left) + offset);

    if (calculatedTop + f.offsetHeight > document.body.offsetHeight) calculatedTop = document.body.offsetHeight - f.offsetHeight;
    if (calculatedLeft + 200 > document.body.offsetWidth) calculatedLeft = document.body.offsetWidth - 220;

    f.style.top = calculatedTop + 'px';
    f.style.left = calculatedLeft + 'px'; 

    closeTimer(closeDelay, newDivName); 
}

// Удаляет слой (подсказку)
// id - id слоя для удаления
function deleteLayer(id) { 
    div = document.getElementById(id); 
    if (div) {
        div.parentNode.removeChild(div);
    }
} 

// Вызывает удаление слоя с задержкой, если курсор находится за пределами слоя
// time - задержка перед удалением слоя в мс.
// id - id слоя для удаления
function closeTimer(time, id) { 
    into = isInDiv(id);
    if (!into) { 
        fn = "deleteLayer('"+id+"')";
        var t = setTimeout(fn, time);
    } else {
        fn = "closeTimer("+time+",'"+id+"')";
        var t = setTimeout(fn, 100);
    }
}

// Создает таблицу в HTML 
// row - кол-во строк
// col - кол-во столбцов
// txt - текст (повторяется во всех ячейках - TODO)
function createTable(row, col, txt) {
    table = "<table border=\"1\">"
    for (i=0; i<eval(row); i++) {
        table += "<tr>";
        for (j=0; j<eval(col); j++) {
            table += "<td>";    
            table += txt;
            table += "</td>";
        }
        table += "</tr>";
    }
    table += "</table>"
    return table;
}

//***********************************************************
// NEW version (подсказка рядом со слоем, если курсор в слое)
//***********************************************************

var REGISTER_DIVS = new Array();
var REGISTER_DIVS_TXT = new Array();
var REGISTER_DIVS_POS = new Array();
var ADDON_PARENT_ID = null;
var ADDON_DIV = null;

// Регистрирует новый слой-подсказку
// id - id слоя родителя
// txt - текст подсказки
// position - позиция (поддерживаются только: right, top)
function registerDiv(id, txt, position) {
    var div = document.getElementById(id); 
    if (div) {
        REGISTER_DIVS[REGISTER_DIVS.length] = id;
        REGISTER_DIVS_TXT[REGISTER_DIVS_TXT.length] = txt;
        REGISTER_DIVS_POS[REGISTER_DIVS_POS.length] = position;
    }   
}

// Главный обработчик - вызывается при каждом движении мыши
function main() {
    var inRegisterDiv = false;
    var inRegisterDivId = 0;  
    for (i=0; i<REGISTER_DIVS.length; i++) {  
        if (isInDiv(REGISTER_DIVS[i])) {
            inRegisterDiv = true;
            inRegisterDivId = i;
            break;
        }
    }
    
    var isSameRegisterDiv = false;
    if (ADDON_DIV == null) {
        isSameRegisterDiv = true;        
    } else {
        isSameRegisterDiv = (ADDON_PARENT_ID == inRegisterDivId);
    }

    if (inRegisterDiv && isSameRegisterDiv) {
        if (ADDON_DIV == null) {
            ADDON_PARENT_ID = inRegisterDivId;
            createAddon(inRegisterDivId);
        }
    } else {       
        if (ADDON_DIV != null && !isInDiv(ADDON_DIV)) {
            closeAddonDiv();
        }
    }
}

// Создает новый слой (подсказку)
// idx - индекс в массиве REGISTER_DIVS (зарегистрированных слоев)
function createAddon(idx) {
    ADDON_DIV = 'addon_note';    
    var width = "300px";
    var height = "auto";  
    var txt = REGISTER_DIVS_TXT[idx]; 
    var position = REGISTER_DIVS_POS[idx];   
    var insertDiv = REGISTER_DIVS[idx];  
    
    var div = document.getElementById(ADDON_DIV);
    if (div) return;
    
    var f = document.createElement("div");
    f.setAttribute("id", ADDON_DIV);
    f.setAttribute("style", "display: block; top: 0px; left: 0px; width:" + width + "; height:" + height + ";");
    f.setAttribute("class", "footnote");
    document.body.appendChild(f);
    
    f.innerHTML = '<div class="footnote_top"></div><div class="footnote_middle">' + txt + '</div><div class="footnote_bottom"></div>';
    //f.className = 'footnote_new_active';

    f.style.display = 'block';
    f.style.textAlign = 'left';
    
    var o = document.getElementById(insertDiv);
    var o_coords = absPosition(o);
    var f_coords = absPosition(f);
    
    var calculatedTop = 0;
    var calculatedLeft = 0;
    
    if (position == "right") {
        calculatedLeft = o_coords.right;        
        var x = f_coords.bottom - f_coords.top;
        var y = o_coords.bottom - o_coords.top;
        calculatedTop = (x >= y) ? o_coords.top - parseInt((x-y)/2) : o_coords.top + parseInt((y-x)/2);
    } else {
        // top
        calculatedTop = o_coords.top - (f_coords.bottom - f_coords.top);
        var x = f_coords.right - f_coords.left;
        var y = o_coords.right - o_coords.left;
        calculatedLeft = (x >= y) ? o_coords.left - parseInt((x-y)/2) : o_coords.left + parseInt((y-x)/2);
    }

    if (calculatedTop < 0) {
        calculatedTop = 0;
    }
    if (calculatedLeft < 0) {
        calculatedLeft = 0;
    }
    
    f.style.top = calculatedTop + 'px';
    f.style.left = calculatedLeft + 'px';       
}

// Удаляет слой (подсказку)
function closeAddonDiv() {
    deleteLayer(ADDON_DIV);
    ADDON_DIV = null;
}