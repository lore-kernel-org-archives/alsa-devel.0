From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000088]: rounding errors in increasing/decreasing volume?
Date: Tue, 31 May 2005 18:03:21 +0200
Message-ID: <6a463086332586dee2125166fbb69b1f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 48C5E1CA
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:21 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=88> 
======================================================================
Reported By:                cbm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   88
Category:                   OTHERS
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     closed
Distribution:               Gentoo GNU Linux
Kernel Version:             2.4.24
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-26-2004 08:33 CET
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    rounding errors in increasing/decreasing volume?
Description: 
See this gnome bug report:

http://bugs.gnome.org/show_bug.cgi?id=124741

Someone commented that its caused in the drivers?  I assume they meant
ALSA.  If its not at your end, I'll poke the gnome folk some more ;-)
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 09:23 
----------------------------------------------------------------------
Submitter: Do you still think that there is a bug in ALSA?

----------------------------------------------------------------------
 cbm - 03-20-05 01:10 
----------------------------------------------------------------------
I just tested with gnome 2.8 and the problem I'd been seeing is not evident
anymore.  Feel free to close this bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-26-04 08:33 cbm            New Issue                                    
02-26-04 11:12 tiwai          Note Added: 0000334                          
02-26-04 11:35 cbm            Note Added: 0000337                          
03-19-05 09:23 jdthood        Note Added: 0004015                          
03-20-05 01:10 cbm            Note Added: 0004070                          
03-22-05 14:59 jdthood        Status                   new => resolved     
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
