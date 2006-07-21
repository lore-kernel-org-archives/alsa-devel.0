From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001289]: I fixed Bug 0001284. Please
	reinstate line 86 in emux_synth.c !
Date: Fri, 21 Jul 2006 20:34:54 +0200
Message-ID: <de44fd2feaffe59f31504f8f321031e7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85FE317A
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 20:34:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1289> 
======================================================================
Reported By:                terminator356
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   1289
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
Date Submitted:             07-29-2005 04:36 CEST
Last Modified:              07-21-2006 20:34 CEST
======================================================================
Summary:                    I fixed Bug 0001284.  Please reinstate line 86 in
emux_synth.c !
Description: 
I fixed Bug 0001284. Please reinstate line 86 in emux_synth.c !

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001284 Soundfont notes problem - notes cut off...
related to          0001290 Re: Bug 0001284 + 0001289: Sorry, my fi...
======================================================================

----------------------------------------------------------------------
 tiwai - 08-03-05 12:17 
----------------------------------------------------------------------
This will terminate notes -- it sounds somehow contradictionary to your
original report (the notes are cut off too early)?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-05 04:36 terminator356  New Issue                                    
08-03-05 11:31 perex          Relationship added       related to 0001284  
08-03-05 11:31 perex          Relationship added       related to 0001290  
08-03-05 12:17 tiwai          Note Added: 0005620                          
07-21-06 20:34 tiwai          Status                   assigned => resolved
07-21-06 20:34 tiwai          Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
