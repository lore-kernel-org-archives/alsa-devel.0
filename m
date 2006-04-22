From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002058]: Audigy 2 ZS Notebook lacks record capability
Date: Sat, 22 Apr 2006 21:11:13 +0200
Message-ID: <637015ab7efda4b326ce277940b5cb46@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3952F15D
	for <alsa-devel@alsa-project.org>; Sat, 22 Apr 2006 21:11:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2058> 
======================================================================
Reported By:                artdent
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2058
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.15
======================================================================
Date Submitted:             04-22-2006 21:11 CEST
Last Modified:              04-22-2006 21:11 CEST
======================================================================
Summary:                    Audigy 2 ZS Notebook lacks record capability
Description: 
According to bug #927, the emu10k1 driver now works with the Audigy 2 ZS
PCMCIA card for playback, but not capture. The most current is "untested,
might already work". Are there any plans to figure out recording with this
card? It would be greatly appreciated.

Even with an untested patch to enable recording, I would be willing to
test it to see if it works.

Thanks,
Jacob Lee

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-22-06 21:11 artdent        New Issue                                    
04-22-06 21:11 artdent        Distribution              => Debian unstable 
04-22-06 21:11 artdent        Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
