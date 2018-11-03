// --
// Copyright (C) 2012-2018 Znuny GmbH, http://znuny.com/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core   = Core || {};

Core.Agent = Core.Agent || {};


/**
 * @namespace
 * @exports TargetNS as Core.Agent.Znuny4OTRSMarkTicketSeenUnseen
 * @description
 *      This namespace contains the special functions for Znuny4OTRSMarkTicketSeenUnseen.
 */
Core.Agent.Znuny4OTRSMarkTicketSeenUnseen = (function (TargetNS) {


    TargetNS.Init = function (Param) {
        var ParamCheckSuccess = true;
        $.each(

            function (Index, ParameterName) {
                if (!Param[ ParameterName ]) {
                    ParamCheckSuccess = false;
                }
            }
        );
        if (!ParamCheckSuccess) {
            return false;
        }

        TargetNS.AgentTicketMarkSeenUnseen(Param);

        Core.App.Subscribe('Event.AJAX.ContentUpdate.Callback', function() {
            TargetNS.AgentTicketMarkSeenUnseen(Param);
        });

        return true;
    };

    TargetNS.AgentTicketMarkSeenUnseen = function (Param) {

        // check if at least one article exists
        if ($('#ArticleItems div ul li a').length == 0){
            return;
        }

        var ArticleID = $('#ArticleItems div a').attr('name').replace('Article','');
        var Baselink = Core.Config.Get('Baselink');

        var HTML = "<li>";
        HTML += "<a id='AgentTicketMarkSeenUnseenArticle' href='" + Baselink + "Action=AgentTicketMarkSeenUnseen;Subaction=Unseen;TicketID=" + Param['TicketID'] + ";ArticleID=" + ArticleID + "' title=' " + Param['TranslateTitle'] + "'>" + Param['TranslateLink'] + "</a>";
        HTML += "</li>";

        $('#ArticleItems div div ul.Actions').append(HTML);
    };

    return TargetNS;
}(Core.Agent.Znuny4OTRSMarkTicketSeenUnseen || {}));
