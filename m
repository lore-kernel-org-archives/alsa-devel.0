From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000964]: "Swap surround slot" does not affect "Duplicate Front"
Date: Mon, 30 May 2005 12:58:15 +0200
Message-ID: <2de3353d2ad32ad515855dd754ce2957@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4EF621B4
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 12:58:15 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=964> 
======================================================================
Reported By:                slammer
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   964
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-04-2005 20:20 CET
Last Modified:              05-30-2005 12:58 CEST
======================================================================
Summary:                    "Swap surround slot" does not affect "Duplicate
Front"
Description: 
When i turn the "Swap surround slot" option "on" and physically do the
swap, the "Duplicate Front" option duplicates front channels still to the
Unswapped plug i.e. it sends them to the Center/LFE channels. I think that
the "Duplicate front" switch should be affected by the "Swap surround"
switch. Don't You think so?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-05 20:20 slammer        New Issue                                    
03-05-05 22:50 slammer        Issue Monitored: slammer                     
05-30-05 12:57 perex          Project                  ALSA - lib => ALSA -
driver
05-30-05 12:58 perex          Category                 control / hcontrol => PCI
- intel8x0
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
