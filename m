From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002301]: 82801G ICH7 problems.
Date: Thu, 27 Jul 2006 12:59:50 +0200
Message-ID: <298ea3c754ffae452a7b07f87accc301@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BDF79170
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 12:59:50 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2301> 
======================================================================
Reported By:                magmax
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2301
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.17-1-686
======================================================================
Date Submitted:             07-24-2006 16:28 CEST
Last Modified:              07-27-2006 12:59 CEST
======================================================================
Summary:                    82801G ICH7 problems.
Description: 
I have two problems: 

a) a really annoying acute noise that is present all the time.

b) when you change whatever you want at alsamixer, all the sound (acute
noise included) shuts down.

This bug may be similar to 0002221.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-27-06 12:59 
----------------------------------------------------------------------
Did you try model module option with various values, as described in
ALSA-Configuration.txt?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-24-06 16:28 magmax         New Issue                                    
07-24-06 16:28 magmax         Distribution              => Debian          
07-24-06 16:28 magmax         Kernel Version            => 2.6.17-1-686    
07-27-06 12:59 tiwai          Note Added: 0011270                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
