From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000214]: ac3 passthrough not working
Date: Sat, 11 Sep 2004 05:25:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040911032555.644F54904E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C2011247
	for <alsa-devel@alsa-project.org>; Sat, 11 Sep 2004 05:25:55 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 7E9BC220B8
	for <alsa-devel@alsa-project.org>; Sat, 11 Sep 2004 05:25:55 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000214
======================================================================
Reported By:                m_stolle
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     214
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.4.25
======================================================================
Date Submitted:             04-16-2004 05:06 CEST
Last Modified:              09-11-2004 05:25 CEST
======================================================================
Summary:                    ac3 passthrough not working
Description: 
I have a Dell Inspiron 8200 with an Intel ICH3/Cirrus Logic CS4205 sound
card.  Unfortunately, the hardware AC3 passthrough does not work. 
Instead, I only get a high-pitched funny noise.

The symptoms are the same in mplayer as well as in xine.  Verbose output
of mplayer provided below:
======================================================================

----------------------------------------------------------------------
 m_stolle - 09-11-2004 05:25 CEST 
----------------------------------------------------------------------
This bug is still present in 2.6.8.1  Am I the only one with this bug?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-16-04 05:06 m_stolle       New Bug                                      
04-16-04 05:06 m_stolle       Distribution              => Debian          
04-16-04 05:06 m_stolle       Kernel Version            => 2.4.25          
09-11-04 05:25 m_stolle       Bugnote Added: 0001744                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
