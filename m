From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001744]: Audiotrak Prodigy 7.1LT is still unusable, only H.P. chanel work and sound is quick...
Date: Fri, 13 Jan 2006 22:16:42 +0100
Message-ID: <df9480b5662c547d67e3023b2f2d1725@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9238E12A
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 22:16:42 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1744> 
======================================================================
Reported By:                robertdavid
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1744
Category:                   PCI - ice1724
Reproducibility:            sometimes
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Gentoo linux
Kernel Version:             2.6.14-archck-r7
======================================================================
Date Submitted:             01-13-2006 22:16 CET
Last Modified:              01-13-2006 22:16 CET
======================================================================
Summary:                    Audiotrak Prodigy 7.1LT is still unusable, only H.P.
chanel work and sound is quick...
Description: 
Im very glad that was added support for Prodigy, but there is still only
two channel working (7,8), the others are silent (tryed all volume
settings).
The sound from 7,8 chanel is good in case of quality, but is faster than
it should be (turn off Multi Track Rate Locking didnt do anything).
I've tryed mpalyer and XMMS, both the same.
I've compiled form CVS and keep it as it was (patched 13.1.2006 to support
Prodigy 7.1LT) 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-13-06 22:16 robertdavid    New Issue                                    
01-13-06 22:16 robertdavid    Distribution              => Gentoo linux    
01-13-06 22:16 robertdavid    Kernel Version            => 2.6.14-archck-r7
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
