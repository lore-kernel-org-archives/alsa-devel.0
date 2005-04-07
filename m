From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000992]: no supported card
Date: Thu, 7 Apr 2005 12:55:23 +0200
Message-ID: <549ec5f53d0a8779b11679ae74e7678e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C39C9226
	for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2005 12:55:23 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=992> 
======================================================================
Reported By:                rav0r
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   992
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.4
======================================================================
Date Submitted:             03-14-2005 21:52 CET
Last Modified:              04-07-2005 12:55 CEST
======================================================================
Summary:                    no supported card
Description: 
I am not sure what model my s.card is. I only know it's ct4830 , 4.1 .Will
this model ever be supported?
======================================================================

----------------------------------------------------------------------
 rav0r - 04-07-05 12:54 
----------------------------------------------------------------------
[root@localhost root]# lspci -vn | grep -1 0401
[root@localhost root]#

----------------------------------------------------------------------
 rav0r - 04-07-05 12:55 
----------------------------------------------------------------------
so, it sais nothing.. Please explain thos commnads, so have am idea of what
I am doing..

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 21:52 rav0r          New Issue                                    
03-14-05 21:52 rav0r          Kernel Version            => 2.4             
03-14-05 22:57 mikma          Note Added: 0003910                          
03-15-05 23:13 rav0r          Note Added: 0003925                          
03-16-05 11:05 mikma          Note Added: 0003935                          
03-17-05 00:51 rav0r          Note Added: 0003974                          
03-20-05 19:14 rav0r          Note Added: 0004096                          
03-20-05 20:28 mikma          Note Added: 0004099                          
03-21-05 03:32 rav0r          File Added: config.log                       
03-21-05 03:33 rav0r          Note Added: 0004112                          
03-21-05 03:33 rav0r          Note Added: 0004113                          
03-21-05 15:44 mikma          Note Added: 0004118                          
03-21-05 17:13 rav0r          Note Added: 0004120                          
04-06-05 18:15 rav0r          Note Added: 0004347                          
04-06-05 18:16 rav0r          Note Added: 0004348                          
04-06-05 18:40 jcdutton       Note Added: 0004349                          
04-06-05 18:40 jcdutton       Status                   assigned => feedback
04-07-05 12:54 rav0r          Note Added: 0004355                          
04-07-05 12:55 rav0r          Note Added: 0004356                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
