
        var req = newXMLHttpRequest();

        function AjaxCall(action, id, addon) {

            if (req == null || !req) alert("AJAX is not supported by this browser!");

            req.open("POST", "backend.php", false);
            req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            req.send("action=" + action + "&id=" + id);

            AJAXTimer(id, addon);
        }

        function AjaxCallCheckReady(id, addon)
        {
            var result = false;

                if (req.readyState == 4)
                {
                    if (req.responseXML != null) {
                        result = true; 

                        // Set parameters
                        if (req.responseXML.getElementsByTagName("setparameters")[0] != null) {
                            var root = req.responseXML.getElementsByTagName("setparameters")[0];
                            var result = eval(root.getElementsByTagName("result")[0].firstChild.nodeValue);
                            // Next step - run addon action
                            if (result == 1 && addon != null && addon != "") {
                                AjaxCall(addon, id, '');
                            }
                        }
                        // Check feeds states
                        if (req.responseXML.getElementsByTagName("getfeedsstates")[0] != null) {
                            var root = req.responseXML.getElementsByTagName("getfeedsstates")[0];

                            var loader = root.getElementsByTagName("loaderstate")[0];
                            var loaderscount = eval(loader.getAttribute("count"));

                            var receiver = root.getElementsByTagName("receiverstate")[0];
                            var receiverscount = eval(receiver.getAttribute("count"));

                            for (var i = 0; i < loaderscount; i++) {
                                var value = trim(loader.getElementsByTagName("feed")[i].firstChild.nodeValue);
                                if (value != null) {
                                    var feedID = 'run' + eval(i+1);
                                    ChangeButtonValue(feedID, value);
                                }
                            }

                            for (var i = 0; i < receiverscount; i++) {
                                var value = trim(receiver.getElementsByTagName("feed")[i].firstChild.nodeValue);
                                if (value != null) {
                                    var feedID = 'runreceiverbutton' + eval(i+1);
                                    ChangeButtonValue(feedID, value);
                                }
                            }
                        }
                        // Run loader feeds
                        else if (req.responseXML.getElementsByTagName("runloaderfeed")[0] != null) {
                            var root = req.responseXML.getElementsByTagName("runloaderfeed")[0];
                            var result = eval(root.getElementsByTagName("result")[0].firstChild.nodeValue);
                            // Change button caption
                            if (result == 1) {
                                var state = trim(root.getElementsByTagName("state")[0].firstChild.nodeValue);
                                var feedID = 'run' + id;
                                ChangeButtonValue(feedID, state);
                            }
                        }
                        // Cancel loader feeds
                        else if (req.responseXML.getElementsByTagName("cancelloaderfeed")[0] != null) {
                            var root = req.responseXML.getElementsByTagName("cancelloaderfeed")[0];
                            var result = eval(root.getElementsByTagName("result")[0].firstChild.nodeValue);
                            // Change button caption
                            if (result == 1) {
                                var state = trim(root.getElementsByTagName("state")[0].firstChild.nodeValue);
                                var feedID = 'run' + id;
                                ChangeButtonValue(feedID, state);
                            }
                        }
                        // Run receiver feeds
                        else if (req.responseXML.getElementsByTagName("runreceiverfeed")[0] != null) {
                            var root = req.responseXML.getElementsByTagName("runreceiverfeed")[0];
                            var result = eval(root.getElementsByTagName("result")[0].firstChild.nodeValue);
                            // Change button caption
                            if (result == 1) {
                                var state = trim(root.getElementsByTagName("state")[0].firstChild.nodeValue);
                                var feedID = 'runreceiverbutton' + id;
                                ChangeButtonValue(feedID, state);
                            }
                        }
                        // Restart receiver feeds
                        else if (req.responseXML.getElementsByTagName("restartreceiverfeed")[0] != null) {
                            var root = req.responseXML.getElementsByTagName("restartreceiverfeed")[0];
                            var result = eval(root.getElementsByTagName("result")[0].firstChild.nodeValue);
                            // Change button caption
                            if (result == 1) {
                                var state = trim(root.getElementsByTagName("state")[0].firstChild.nodeValue);
                                var feedID = 'runreceiverbutton' + id;
                                ChangeButtonValue(feedID, state);
                            }
                        }
                        // Progress bar and feed color
                        else if (req.responseXML.getElementsByTagName("getprogress")[0] != null) {
                            var root = req.responseXML.getElementsByTagName("getprogress")[0];
                            var feeds = root.getElementsByTagName("feeds")[0];
                            var feedsCount = eval(feeds.getAttribute("count"));
                            for (var i = 0; i < feedsCount; i++) {
                                var feed = root.getElementsByTagName("feed")[i];
                                var feedId = feed.getAttribute("id");
                                var feedCur = feed.getAttribute("cur");
                                var feedMax = feed.getAttribute("max");
                                var feedUnlimit = feed.getAttribute("unlimit");
                                var feedDie = feed.getAttribute("die");

                                showLoaderFeedProgressBar(feedId, feedCur, feedMax, feedUnlimit, feedDie);

                                var feedColor = "active";
                                if (eval(feedDie) == 1) feedColor = "die";
                                ChangeLoaderFeedColor('loader' + feedId, feedColor);
                            }
                        }
                        // TextView
                        else if (req.responseXML.getElementsByTagName("getpackagestate")[0] != null) {
                            var root = req.responseXML.getElementsByTagName("getpackagestate")[0];

                            var loaders = root.getElementsByTagName("loaders")[0];
                            var loadersBodyCount = eval(0);
                            if (loaders != null) loadersBodyCount = eval(loaders.getAttribute("bodiescount"));

                            var receivers = root.getElementsByTagName("receivers")[0];
                            var receiversBodyCount = eval(0);
                            if (receivers != null) receiversBodyCount = eval(receivers.getAttribute("bodiescount"));
                            var content = "";

                            // Show loaders state
                            if (loaders != null) {
                                    content = content + "<table border=\"1px\" width=\"100%\" height=\"100%\" nowrap>";
                                    content = content + "<tr align=\"center\" height=\"30px\" class=\"textview\" nowrap>";
                                    var head = loaders.getElementsByTagName("head")[0];
                                    var cnt = eval(head.getAttribute("count"));

                                    for (var i = 0; i < cnt; i++) {
                                        var value = head.getElementsByTagName("name")[i].firstChild.nodeValue;
                                        if (value != null && value != " " && value != "" && value != "_") {
                                            content = content + "<td class=\"tab\" align=\"center\" nowrap><b>" + value +"</b></td>";
                                        }
                                        else content = content + "<td class=\"tab\" align=\"center\" nowrap><b>&nbsp;</b></td>";
                                    }
                                    content = content + "</tr>";

                                    for (var j = 0; j < loadersBodyCount; j++) {
                                        var body = loaders.getElementsByTagName("body")[j];
                                        var cnt = eval(body.getAttribute("count"));

                                        var rowstyle = "firstrow";
                                        if (j%2 != 0) rowstyle = "secondrow";

                                        content = content + "<tr align=\"center\" height=\"30px\" class=\"" + rowstyle + "\" nowrap>";

                                        for (var i = 0; i < cnt; i++) {
                                            var value = body.getElementsByTagName("name")[i].firstChild.nodeValue;
                                            var url = body.getElementsByTagName("name")[i].getAttribute("url");

                                            if (url != null) value = "<a href=\"" + url + "\" target=\"_blank\">" + value + "</a>";

                                            if (value != null && value != " " && value != "" && value != "_") {
                                                content = content + "<td class=\"tab\" align=\"center\" nowrap>" + value +"</td>";
                                            }
                                            else content = content + "<td class=\"tab\" align=\"center\" nowrap>&nbsp;</td>";
                                        }
                                        content = content + "</tr>";
                                    }

                                    var footer = loaders.getElementsByTagName("footer")[0];
                                    if (footer != null) {
                                        var cnt = eval(footer.getAttribute("count"));

                                        content = content + "<tr align=\"center\" height=\"30px\" class=\"textview\" nowrap>";

                                        for (var i = 0; i < cnt; i++) {
                                            var value = footer.getElementsByTagName("name")[i].firstChild.nodeValue;
                                            if (value != null && value != " " && value != "" && value != "_") {
                                                content = content + "<td class=\"tab\" align=\"center\" nowrap><b>" + value +"</b></td>";
                                            }
                                            else content = content + "<td class=\"tab\" align=\"center\" nowrap><b>&nbsp;</b></td>";
                                        }
                                        content = content + "</tr>";
                                    }

                                    content = content + "</table>";

                                    if (eval(id) == 1)
                                        addLoaderContentDetails(content);
                                    else addLoaderContent(content);
                            }
                            //--//

                            // Show receivers state
                            if (receivers != null) {
                                content = "<table border=\"1px\" width=\"100%\" height=\"100%\" nowrap>";
                                content = content + "<tr align=\"center\" height=\"30px\" class=\"textview\" nowrap>";
                                var head = receivers.getElementsByTagName("head")[0];
                                var cnt = eval(head.getAttribute("count"));

                                for (var i = 0; i < cnt; i++) {
                                    var value = head.getElementsByTagName("name")[i].firstChild.nodeValue;
                                    if (value != null && value != " " && value != "" && value != "_") {
                                        content = content + "<td class=\"tab\" align=\"center\" nowrap><b>" + value +"</b></td>";
                                    }
                                    else content = content + "<td class=\"tab\" align=\"center\" nowrap><b>&nbsp;</b></td>";
                                }
                                content = content + "</tr>";

                                for (var j = 0; j < receiversBodyCount; j++) {
                                    var body = receivers.getElementsByTagName("body")[j];
                                    var cnt = eval(body.getAttribute("count"));

                                    var rowstyle = "firstrow";
                                    if (j%2 != 0) rowstyle = "secondrow";

                                    content = content + "<tr align=\"center\" height=\"30px\" class=\"" + rowstyle + "\" nowrap>";

                                    for (var i = 0; i < cnt; i++) {
                                        var value = body.getElementsByTagName("name")[i].firstChild.nodeValue;
                                        if (value != null && value != " " && value != "" && value != "_") {
                                            content = content + "<td class=\"tab\" align=\"center\" nowrap>" + value +"</td>";
                                        }
                                        else content = content + "<td class=\"tab\" align=\"center\" nowrap>&nbsp;</td>";
                                    }
                                    content = content + "</tr>";
                                }

                                var footer = receivers.getElementsByTagName("footer")[0];
                                var cnt = eval(footer.getAttribute("count"));

                                content = content + "<tr align=\"center\" height=\"30px\" class=\"textview\" nowrap>";
                                for (var i = 0; i < cnt; i++) {
                                    var value = footer.getElementsByTagName("name")[i].firstChild.nodeValue;
                                    if (value != null && value != " " && value != "" && value != "_") {
                                        content = content + "<td class=\"tab\" align=\"center\" nowrap><b>" + value +"</b></td>";
                                    }
                                    else content = content + "<td class=\"tab\" align=\"center\" nowrap><b>&nbsp;</b></td>";
                                }
                                content = content + "</tr></table>";
                                addReceiverContent(content);
                            }
                            //--//
                        }
                        // Remove All Packages
                        else if (req.responseXML.getElementsByTagName("removeallpackages")[0] != null) {
                            var root = req.responseXML.getElementsByTagName("removeallpackages")[0];
                            var result = eval(root.getElementsByTagName("result")[0].firstChild.nodeValue);
                        }
                        // Shutdown emulator
                        else if (req.responseXML.getElementsByTagName("shutdown")[0] != null) {
                            var root = req.responseXML.getElementsByTagName("shutdown")[0];
                            var result = eval(root.getElementsByTagName("result")[0].firstChild.nodeValue);
                            // Change button caption and enable/disable Load config button
                            if (result == 1) {
                                var state = trim(root.getElementsByTagName("state")[0].firstChild.nodeValue);
                                ChangeButtonValue('shutdownbutton', state);

                                var loadbuttonstate = trim(root.getElementsByTagName("loadbuttonstate")[0].firstChild.nodeValue);
                                if (loadbuttonstate == "OFF") isShutdown = true;
                                else isShutdown = false;
                                ActiveButtonController();
                            }
                        }
                    }
                }

            return result;
        }

        function newXMLHttpRequest() {
            var xmlreq = false;

            if (window.XMLHttpRequest) {
                xmlreq = new XMLHttpRequest();
            } else if (window.ActiveXObject) {
                try {
                    xmlreq = new ActiveXObject("Msxml2.XMLHTTP");
                } catch (e1) {
                    try {
                        xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
                    } catch (e2) {
                    }
                }
            }

            return xmlreq;
        }

        function  AJAXTimer(id, addon) {
            var result = AjaxCallCheckReady(id, addon);
            if (!result) {
                if (id == "") id = "null";
                if (addon == "") addon = "null";
                var t_a = setTimeout("AJAXTimer('"+ id +"', '" + addon + "')", 100);
            }
        }

        function buttonEvent(action, id) {
            AjaxCall('setparameters', id, action);
        }
        
