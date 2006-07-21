From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001290]: Re: Bug 0001284 + 0001289:
	Sorry, my fix now makes pops and clicks...
Date: Fri, 21 Jul 2006 20:35:17 +0200
Message-ID: <baba18e1dd7e2edc54bb60b63fad5669@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1D1D717C
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 20:35:18 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1290> 
======================================================================
Reported By:                terminator356
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   1290
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-29-2005 05:34 CEST
Last Modified:              07-21-2006 20:35 CEST
======================================================================
Summary:                    Re: Bug 0001284 + 0001289: Sorry, my fix now makes
pops and clicks...
Description: 
Sorry my fix now makes pops and clicks if the
 same note is played more than once because
 the note is reset and used over again.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001284 Soundfont notes problem - notes cut off...
related to          0001289 I fixed Bug 0001284.  Please reinstate ...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-05 05:34 terminator356  New Issue                                    
08-03-05 11:30 perex          Relationship added       related to 0001284  
08-03-05 11:31 perex          Relationship added       related to 0001289  
07-21-06 20:35 tiwai          Status                   assigned => resolved
07-21-06 20:35 tiwai          Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
