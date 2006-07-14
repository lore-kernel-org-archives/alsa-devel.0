From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002280]: nforce 570 with AD1988A no
	sound
Date: Fri, 14 Jul 2006 14:40:40 +0200
Message-ID: <354029d88a045683ed695d25323aa741@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D27AF134
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 14:40:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2280> 
======================================================================
Reported By:                Tobias Diedrich
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2280
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian/GNU Linux testing
Kernel Version:             2.6.18-rc1
======================================================================
Date Submitted:             07-14-2006 14:40 CEST
Last Modified:              07-14-2006 14:40 CEST
======================================================================
Summary:                    nforce 570 with AD1988A no sound
Description: 
I just bought a new mainboard, an Asus M2N with nforce 570 chipset (mcp55)
and snd-hda-intel loads fine, but complains about an unknown chip version
and tries to get some configuration values from the BIOS. Apparently this
does not work, since while it loads fine I have so far been unable to get
any sound from it.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-14-06 14:40 Tobias DiedrichNew Issue                                    
07-14-06 14:40 Tobias DiedrichDistribution              => Debian/GNU Linux
testing
07-14-06 14:40 Tobias DiedrichKernel Version            => 2.6.18-rc1      
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
