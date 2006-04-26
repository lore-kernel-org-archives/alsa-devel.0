From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002077]: emu10k1 will not use S24_LE
Date: Wed, 26 Apr 2006 21:51:23 +0200
Message-ID: <410aa9654eb9a5a0d89108b88e63050e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0199715A
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2006 21:51:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2077> 
======================================================================
Reported By:                braininajar
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2077
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             04-26-2006 21:51 CEST
Last Modified:              04-26-2006 21:51 CEST
======================================================================
Summary:                    emu10k1 will not use S24_LE
Description: 
The Audigy2 is a 24-bit, 96k card. It will handle 24 bit, 96k samples. For
some reason or other, the emu10k1 driver will not let it
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-06 21:51 braininajar    New Issue                                    
04-26-06 21:51 braininajar    Distribution              => gentoo          
04-26-06 21:51 braininajar    Kernel Version            => 2.6.16          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
