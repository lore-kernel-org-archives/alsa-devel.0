From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002335]: lockup when playing audio
Date: Sat, 5 Aug 2006 03:34:41 +0200
Message-ID: <c4ee055f19c0aee6fb35ec22f5571817@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10268F8
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 03:34:41 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2335> 
======================================================================
Reported By:                clameter
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2335
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian Testing
Kernel Version:             2.6.18-rc3
======================================================================
Date Submitted:             08-05-2006 03:34 CEST
Last Modified:              08-05-2006 03:34 CEST
======================================================================
Summary:                    lockup when playing audio
Description: 
Running on a dual core Pentium940. Sound works for some time and then the
system
locks up. nmi watchdog is not effective.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-05-06 03:34 clameter       New Issue                                    
08-05-06 03:34 clameter       Distribution              => Debian Testing  
08-05-06 03:34 clameter       Kernel Version            => 2.6.18-rc3      
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
