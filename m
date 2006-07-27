From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001506]: What is required to add
	echoaudio drivers to the alsa-kernel tree
Date: Thu, 27 Jul 2006 08:35:58 +0200
Message-ID: <59e6c1ae929570b35461611fa3c61da8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2C06B21A
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 08:35:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1506> 
======================================================================
Reported By:                wbrown338
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1506
Category:                   PCI - echoaudio
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.12
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-26-2005 22:46 CEST
Last Modified:              07-27-2006 08:35 CEST
======================================================================
Summary:                    What is required to add echoaudio drivers to the
alsa-kernel tree
Description: 
Greetings:

I would like to see the echoaudio drivers (specifically mia) added to the
alsa-kernel tree so that I do not have to disable the 2.6 alsa-kernels,
custom compile alsa for my driver with the kernel source and then modify
several config files.  What are the requirements for this driver to be
added to alsa-kernel tree to be included in the kernel releases?  Are any
otheres out there using these drivers??
Thanks.
 
======================================================================

----------------------------------------------------------------------
 Adrian Bunk - 07-27-06 08:35 
----------------------------------------------------------------------
Included in kernel 2.6.18-rc1.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-05 22:46 wbrown338      New Issue                                    
10-26-05 22:46 wbrown338      Kernel Version            => 2.6.12          
07-27-06 08:35 Adrian Bunk    Note Added: 0011261                          
07-27-06 08:35 Adrian Bunk    Status                   new => resolved     
07-27-06 08:35 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
