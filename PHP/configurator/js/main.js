    var TYPES = new Array(new Array('Шарф', 'images/staff1/', 100),
                          new Array('Шапка', 'images/staff2/', 22));
    
    var TYPES_SCARF = new Array(new Array('images/staff1/100/', 10),
                                new Array('images/staff1/125/', 13),
                                new Array('images/staff1/150/', 15),
                                new Array('images/staff1/175/', 18),
                                new Array('images/staff1/200/', 20));
                                
    var TYPES_SCARF2 = new Array(new Array('images/staff1/10/', 5),
                                 new Array('images/staff1/15/', 7),
                                 new Array('images/staff1/20/', 10),
                                 new Array('images/staff1/25/', 12),
                                 new Array('images/staff1/30/', 15));                                
                                
    var BUTTONID = 1;
    var STARTPRICE = 1000;
    var PRICECOEFS = new Array(-100, -50, 0, 50, 100);
    var BUCKLETYPES = new Array ("Шерсть 100%", "50% Шерсть / 50% Акрил", "Акрил 100%");
    var CURRENTBUCKLEID = 0;
    var LININGPRICECOEFS = 0;
    
    var COLORTEMPLATE = 'images/color.png';
    var COLORACTIVETEMPLATE = 'images/color_active.png';
    var CURRENTCOLOR = "#FFFFFF";
    var COLORS_IN_ROW = 4;
    var DEFAULTLINESCOLOR = "#555555";
    var BUCKLECOLORS = new Array(new Array('#993366', '#00CC00', '#FFFF33', '#33FFCC', '#FF3333', '#3333FF', '#FF0099'), 
                                 new Array('#993366', '#00CC00', '#FFFF33', '#33FFCC'), 
                                 new Array('#FF3333', '#3333FF', '#FF0099'));
    
    var NODETYPES = new Array (new Array('images/node1.png', 'прямой - узел1'),
                               new Array('images/node2.png', 'описуха узел2'),
                               new Array('images/node3.png', 'описуха узел3'),
                               new Array('images/node4.png', 'описуха узел4'),
                               new Array('images/node5.png', 'описуха узел5'));
    
    var LINES = new Array ('images/lines1.png', 'images/lines2.png');
    
    function btn1Vars() {        
        BUTTONID = 1;
                
        STARTPRICE = 1000;
        LININGPRICECOEFS = 50;
        
        var defaultSizeX = 150;
        var defaultSizeY = 20;
        
        var sizeDivArr1 = new Array(100, 125, 150, 175, 200);
        var sizeDivArr2 = new Array(10, 15, 20, 25, 30);

        var sizeDiv = "<table cellpadding='0' cellspacing='0'><tr><td>Д</td><td>";
        
        sizeDiv += "<select id='sizex' onchange='setType(0);priceHandler()'>";        
        for (i=0; i<sizeDivArr1.length; i++) {
            sizeDiv += "<option value='" + i + "' " + ((defaultSizeX == sizeDivArr1[i]) ? "selected" : "") +">" + sizeDivArr1[i] + "</option>";            
        }
        sizeDiv += "</select>";
        
        sizeDiv += "</td><td>см</td></tr><tr>";        
        sizeDiv += "<td>Ш</td><td>";
        
        sizeDiv += "<select id='sizey' onchange='setType(0);priceHandler();'>";
        for (i=0; i<sizeDivArr2.length; i++) {
            sizeDiv += "<option value='" + i + "' " + ((defaultSizeY == sizeDivArr2[i]) ? "selected" : "") +">" + sizeDivArr2[i] + "</option>";            
        }
        sizeDiv += "</select>";
        
        sizeDiv += "</td><td>см</td></tr></table>";                
        document.getElementById('sizeDiv').innerHTML = sizeDiv;        

        var lines = "<table>";
        for (i=0; i<LINES.length; i++) {
            var val = "<img src=" + LINES[i] + " />";
            var ch = (i == 0)? "checked" : "";
            lines += "<tr align='center'><td><input type='radio' onchange='setType(0)' id='lines" + i + "' name='linesGroup' " + ch + "></td><td>" + val + "</td></tr>";
        }
        lines += "</table>";
        document.getElementById('linesTitle').innerHTML = "Полосы";
        document.getElementById('linesBody').innerHTML = lines;  
                
        setType(0);
        
        var defaultBuckleIdx = 1;
        var buckle = "<table cellpadding='0' cellspacing='0'>";        
        for (i=0; i<BUCKLETYPES.length; i++) {
            buckle += "<tr><td><input onchange='colorHandler()' id='buckle" + i + "' type='radio' name='buckleGroup' " + ((defaultBuckleIdx == i) ? "checked" : "") +">" + BUCKLETYPES[i] + "</input></td></tr>";
        }        
        buckle += "</table>";
        document.getElementById('buckleType').innerHTML = buckle;
        
        document.getElementById('lining').innerHTML = "Кисточки";
        document.getElementById('liningYes').checked = false;
        document.getElementById('liningNo').checked = true;        
        document.getElementById('price').innerHTML = STARTPRICE;                  
         
        setNode(0);        
        colorHandler();        
    }

    function btn2Vars() {
        
        var lines = "<table>";
        lines += "<tr align='center'><td><input onchange='pumponHandler()' type='radio' id='linesYes' name='linesGroup' checked></td><td>Да</td></tr>";
        lines += "<tr align='center'><td><input onchange='pumponHandler()' type='radio' id='linesNo' name='linesGroup'></td><td>Нет</td></tr>";        
        lines += "</table>";
        document.getElementById('linesTitle').innerHTML = "Пумпон";
        document.getElementById('linesBody').innerHTML = lines; 
        document.getElementById('linesYes').checked = true;
        document.getElementById('linesNo').checked = false; 
        
        BUTTONID = 2;             
        STARTPRICE = 700;
        LININGPRICECOEFS = 300;
        
        var defaultSizeIdx = 1;
        var sizeDivArr = new Array("S (54-55 см)", "M (56-57 см)", "L &nbsp(58-59 см)", "XL (61-62см)");
        
        var sizeDiv = "<table cellpadding='0' cellspacing='0'>";        
        for (i=0; i<sizeDivArr.length; i++) {
            sizeDiv += "<tr><td><input type='radio' name='sizebtn2' " + ((defaultSizeIdx == i) ? "checked" : "") +">" + sizeDivArr[i] + "</input></td></tr>";
        }        
        sizeDiv += "</table>";
        
        document.getElementById('sizeDiv').innerHTML = sizeDiv;   
        
        setType(1);   
        
        var defaultBuckleIdx = 1;
        var buckle = "<table cellpadding='0' cellspacing='0'>";        
        for (i=0; i<BUCKLETYPES.length; i++) {
            buckle += "<tr><td><input onchange='colorHandler()' id='buckle" + i + "' type='radio' name='buckleGroup' " + ((defaultBuckleIdx == i) ? "checked" : "") +">" + BUCKLETYPES[i] + "</input></td></tr>";
        }        
        buckle += "</table>";
        document.getElementById('buckleType').innerHTML = buckle;
        
        document.getElementById('lining').innerHTML = "Подкладка";        
        document.getElementById('liningYes').checked = false;
        document.getElementById('liningNo').checked = true;
        document.getElementById('price').innerHTML = STARTPRICE;                       
                 
        setNode(0);
        colorHandler();              
    }
    
    function priceHandler() {
        var price = STARTPRICE;
        
        try {
            var obj = document.getElementById('sizex');
            var p1 = PRICECOEFS[obj.options[obj.selectedIndex].value];
        
            obj = document.getElementById('sizey');
            var p2 = PRICECOEFS[obj.options[obj.selectedIndex].value];
            
            price = price + p1 + p2;
        } catch (E) {
            document.getElementById('price').innerHTML = price;
        }
        
        try {    
            var obj = document.getElementById('liningYes');
            var p3 = (obj.checked) ? LININGPRICECOEFS : 0;

            price = price + p3;
            document.getElementById('price').innerHTML = price;        
        } catch (E) {
            document.getElementById('price').innerHTML = price;        
        }
    }
    
    function colorHandler() {
        id = 0; 
        try {
            for (i=0; i<BUCKLETYPES.length; i++) {
                if (document.getElementById('buckle' + i).checked) {
                    id = i;
                    break;
                }
            }
        } catch (E) {
        }
        
        CURRENTBUCKLEID = id;
        var colors = BUCKLECOLORS[id];
        
        var txt = "<table><tr>"; 

        var idx = 0;
        for (i=0; i<colors.length; i++) {
            txt += "<td><a href=\"javascript:setColor('clr" + i + "', '" + colors[i] + "');\" onfocus='this.blur();'>" + 
                   "<img id='clr" + i + "' src=" + COLORTEMPLATE + " style='background-color:" + colors[i] + ";' /></a></td>";
            if (idx == (COLORS_IN_ROW - 1)) {
                txt += "</tr><tr>";
            }
            idx++;
            if (idx >= COLORS_IN_ROW) idx = 0;
        }
        txt += "</tr></table>";

        document.getElementById('buckleDiv').innerHTML = txt;
    }
    
    function setType(id) {
        var btns = "";
        for (i=0; i<TYPES.length; i++) {
            btns += "<input type='button' value='" + TYPES[i][0] + "' onClick='btn" + (i+1) + "Vars();' />\n<br/>";
        }
        document.getElementById('typeDiv').innerHTML = btns;
        
        var staff = "";
        if (TYPES[id][2] > 0) {
            staff += "<table cellpadding='0' cellspacing='0' style='margin:auto'>";
            
            // шапка
            if (id == 1) {
                for (i=TYPES[id][2]; i>=1; i--) {
                    var imageName = TYPES[id][1] + i + ".png";
                    
                    var alignDivBegin = "";
                    var alignDivEnd = "";
                    
                    // специфика для шапки
                    if (BUTTONID == 2 && i == TYPES[id][2]) {
                        if (isPumpon()) {
                            alignDivBegin = "<div id='pumponDiv'>";
                            imageName = TYPES[id][1] + "Pumpon.png";
                            alignDivEnd = "</div>";
                        } else {
                            imageName = TYPES[id][1] + "No_Pumpon.png";
                        }
                    }
                    
                    staff += "<tr valign='top'><td nowrap='nowrap'>" + alignDivBegin + "<a href=\"javascript:fillColor('staff" + i + "');\" onfocus='this.blur();'>" + 
                             "<img id='staff" + i + "' src='" + imageName + "' /></a>" + alignDivEnd + "</td></tr>";
                }
            } else if (id == 0) {
                var isHoriz = (document.getElementById('lines0').checked) ? true : false;
                
                if (isHoriz) {
                    // шарф горизонтальный
                    obj = document.getElementById('sizey');
                    var newId = obj.options[obj.selectedIndex].value;
                    var cnt = TYPES_SCARF2[newId][1];
                    var path = TYPES_SCARF2[newId][0];
                    
                    for (i=1; i<=cnt; i++) {
                        var imageNameLeft = path + i + "_Left_Brushes.png";
                        var imageName = path + i + "_Horizontal_Sharf.png";
                        var imageNameRight = path + i + "_Right_Brushes.png";
                        
                        var alignDivBegin = "";
                        var alignDivEnd = "";                    
                        
                        staff += "<tr valign='top'><td nowrap='nowrap'>" + alignDivBegin + 

                                 "<a href=\"javascript:fillColor('staff_l" + i + "');\" onfocus='this.blur();'>" + 
                                 "<img id='staff_l" + i + "' src='" + imageNameLeft + "' style='background:" + DEFAULTLINESCOLOR + "' /></a>" + 
                        
                                 "<a href=\"javascript:fillColor('staff" + i + "');\" onfocus='this.blur();'>" + 
                                 "<img id='staff" + i + "' src='" + imageName + "' /></a>" + 
                                 
                                 "<a href=\"javascript:fillColor('staff_r" + i + "');\" onfocus='this.blur();'>" + 
                                 "<img id='staff_r" + i + "' src='" + imageNameRight + "' style='background:" + DEFAULTLINESCOLOR + "' /></a>" + 

                                 alignDivEnd + "</td></tr>";                                 
                    }
                } else {
                    // шарф вертикальный                
                    obj = document.getElementById('sizex');
                    var newId = obj.options[obj.selectedIndex].value;
                    var cnt = TYPES_SCARF[newId][1];
                    var path = TYPES_SCARF[newId][0];
                    
                    staff += "<tr valign='top'>";
                    for (i=1; i<=cnt; i++) {
                        var imageName = path + i + ".png";
                        
                        var alignDivBegin = "";
                        var alignDivEnd = "";                    
                        
                        staff += "<td nowrap='nowrap'>" + alignDivBegin + "<a href=\"javascript:fillColor('staff" + i + "');\" onfocus='this.blur();'>" + 
                                 "<img id='staff" + i + "' src='" + imageName + "' /></a>" + alignDivEnd + "</td>";
                    }
                    staff += "</tr>";
                }
            }
            staff += "</table>";
        }
        document.getElementById('mainDiv').innerHTML = staff;
    }
    
    function setNode(id) {
        var table = "<table><tr><td><img src='" + NODETYPES[id][0] + "' /></td></tr><tr><td>" + NODETYPES[id][1] + "</td></tr></table>";
        document.getElementById('nodeDiv').innerHTML = table;
    }
    
    function fillColor(id) {
        document.getElementById(id).style.backgroundColor = CURRENTCOLOR;
    }
    
    function setColor(id, color) {
        CURRENTCOLOR = color;
        var colors = BUCKLECOLORS[CURRENTBUCKLEID];
        for (i=0; i<colors.length; i++) {
            document.getElementById('clr' + i).src = COLORTEMPLATE;
        }
        document.getElementById(id).src = COLORACTIVETEMPLATE;
    }
    
    function buckleNote() { 
        var table = "<table border='1'>" +
        "<tr><td>" + BUCKLETYPES[0] + "</td><td>описуха 1</td></tr>" +
        "<tr><td>" + BUCKLETYPES[1] + "</td><td>описуха 2</td></tr>" +
        "<tr><td>" + BUCKLETYPES[2] + "</td><td>описуха 3</td></tr>" +
        "</table>";   
        return table; 
    }
    
    function liningNote() {
        if (BUTTONID == 1) {
            return liningNote1();
        }
        
        if (BUTTONID == 2) {
            return liningNote2();
        } 
            
        // default
        return liningNote1();
    }
        
    function liningNote1() { 
        var table = "<table border='1'>" +
        "<tr><td>фото1</td><td>фото2</td></tr>" +
        "<tr><td colspan='2'>строчки с текстом для кисточек</td></tr>" +
        "</table>";   
        return table; 
    }
    
    function liningNote2() { 
        var table = "<table border='1'>" +
        "<tr><td>фото1</td><td>фото2</td></tr>" +
        "<tr><td colspan='2'>строчки с текстом для подкладки</td></tr>" +
        "</table>";   
        return table; 
    }
    
    function thicknessNote() {
        var table = "<table border='1'>" +
        "<tr><td>толстое</td><td>это ...</td></tr>" +
        "<tr><td>тонкое</td><td>это ...</td></tr>" +
        "</table>";   
        return table; 
    }
    
    function nodesNote() {        
        var table = "<table border='1'>";
        for (i=0; i<NODETYPES.length; i++) {
            table += "<tr><td><a href='javascript:setNode(" + i + ")' onfocus='this.blur();'>" + 
                     "<img src='" + NODETYPES[i][0] + "' /></a></td><td>" + NODETYPES[i][1] + "</td></tr>";
        }
        table += "</table>";  
        return table; 
    }
    
    function isPumpon() {
        var obj = document.getElementById('linesYes');
        return (obj.checked) ? true : false;
    }
    
    function pumponHandler() {
        var id = 1;
        if (isPumpon()) {
            var imageName = TYPES[id][1] + "Pumpon.png";
        } else {
            var imageName = TYPES[id][1] + "No_Pumpon.png";
        }
        
        var obj = document.getElementById('staff' + TYPES[id][2]);
        if (obj) {
            obj.src = imageName;
        }
    }
    

    

