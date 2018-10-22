<?php
    function registerDiv($divId, $txtFunction, $position) {
        echo "<script>registerDiv('$divId', $txtFunction, '$position');</script>";
    }
     
    function showType() {        
        echo "<table cellpadding='0' cellspacing='0' nowrap><tr align='center' ><td><div class='div148wide'>".
             "<div><span id='typeDiv'></span></div>".
             "</div></td></tr><tr><td><div class='bgSmallBottom' /></td></tr></table>";
    }

    function showSize() {
        $txt = "<table cellpadding='0' cellspacing='0'><tr align='center' ><td><div class='div148wide'><h3>������</h3>".
        "<div class=\"sizeFont\" id=\"sizeDiv\">".        
        "</div></div></td></tr><tr><td><div class='bgSmallBottom' /></td></tr></table>";

        echo $txt;

    }

    function showBuckleType() {
        $txt = "<table cellpadding='0' cellspacing='0'><tr align='center' ><td><div class='div148wide'>".
        "<div id='buckleNote'><h3>��� ������</h3>".
        "<h4><div id='buckleType'></div></h4></div>".
        "</div></td></tr><tr><td><div class='bgSmallBottom' /></td></tr></table>";

        echo $txt;        
        registerDiv("buckleNote", "buckleNote()", "right"); 
    }

    function showLining() {
        $txt = "<table cellpadding='0' cellspacing='0'><tr align='center' ><td><div class='div148wide'>".
        "<div id='liningNote'><h3><span id='lining'></span></h3>".
        "<h4><table><tr>".
        "<td><input onchange='priceHandler()' id='liningYes' type='radio' name='liningGroup'>��</input></td>".
        "</tr><tr>".
        "<td><input onchange='priceHandler()' id='liningNo' type='radio' name='liningGroup' checked>���</input></td>".
        "</tr></table></h4></div>".
        "</div></td></tr><tr><td><div class='bgSmallBottom' /></td></tr></table>";
        echo $txt;
        registerDiv("liningNote", "liningNote()", "right"); 
    }

    function showPrice() {
        $txt = "<table cellpadding='0' cellspacing='0'><tr align='center' ><td><div class='div150wide'>".
        "<h3>����</h3>".
        "<h4><span id='price'></span> ���.</h4>".
        "</div></td></tr></table>";
        echo $txt;
    }

    function showLines() {
        $txt = "<table cellpadding='0' cellspacing='0'><tr align='center' ><td><div class='bgSmallLeft'/></td>".
        "<td><div class='div146wide'><h3><span id='linesTitle'></span></h3>".
        "<h4><span id='linesBody'></span></h4></div></td><td><div class='bgSmallRight'/></td></tr></table>";
        echo $txt;
    }

    function showNodeType() {
        $txt = "<table cellpadding='0' cellspacing='0'><tr align='center'><td><div class='div148wide'>".
        "<div id='nodesNote'><h3>��� ����</h3>".
        "<div><span id='nodeDiv'></span></div></div></div></td><td><div class='bgSmallRight'/></td></tr></table>";
        echo $txt;
        registerDiv("nodesNote", "nodesNote()", "top"); 
    }

    function showThickness() {
        $txt = "<table cellpadding='0' cellspacing='0'><tr align='center'><td><div class='div148wide'>".
        "<div id='thicknessNote'><h3>�������</h3>".
        "<h4><table><tr>".
        "<td><input type='radio' id='thicknessBig' name='thicknessGroup' checked>�������</input></td>".
        "</tr><tr>".
        "<td><input type='radio' id='thicknessSmall' name='thicknessGroup'>������</input></td>".
        "</tr></table></h4></div></div></td><td><div class='bgSmallRight'/></td></tr></table>";
        echo $txt;
        registerDiv("thicknessNote", "thicknessNote()", "top"); 
    }

    function showLabel() {
        $txt = "<table cellpadding='0' cellspacing='0'><tr align='center'><td><div class='div148wide'>".
        "<h3>�����</h3>".
        "<h4><table><tr>".
        "<td><input type=\"radio\" name=\"label\" checked>��</input></td>".
        "</tr><tr>".
        "<td><input type=\"radio\" name=\"label\">���</input></td>".
        "</tr></table></h4></div></td><td><div class='bgSmallRight'/></td></tr></table>";
        echo $txt;
    }

    function showFinish() {
        $txt = "<table cellpadding='0' cellspacing='0'><tr height='2px'><td><div class='bgSmallTop' height='2px' /></td></tr>".
               "<tr height='100px'><td align='center'><div class='div150wide'><h3><input type=\"button\" value=\"������!\" /></h3></div></td></tr></table>";
        echo $txt;
    }

    function showColors() {
        echo "<div><span id='buckleDiv'></span></div>";
    }

    function showMain() {
        echo "<div id='mainWindow'><span id='mainDiv'></span></div>";
    }
?>
