From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002062]: azx_get_response_timeout -> no sound with hda_intel
Date: Sun, 23 Apr 2006 14:06:38 +0200
Message-ID: <b6536aacf1e5982abfb8deee01a8e98f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 531A7188
	for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2006 14:06:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2062> 
======================================================================
Reported By:                lemzwerg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2062
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             Linux linux 2.6.16.9-smp #1 SMP Fri Apr 21 11:20:09
CEST 2006 i686 i686 i386 GNU/Linux
======================================================================
Date Submitted:             04-23-2006 14:06 CEST
Last Modified:              04-23-2006 14:06 CEST
======================================================================
Summary:                    azx_get_response_timeout -> no sound with hda_intel
Description: 
I have exactly the same problem as reported here (with the same
hardware, this is, SigmaTel STAC9200 codec, but in an Dell Inspiron
6400):

  http://threebit.net/mail-archive/linux-kernel/msg00690.html

but I'm using the latest ALSA and Linux kernel versions...

Any fix available?

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-23-06 14:06 lemzwerg       New Issue                                    
04-23-06 14:06 lemzwerg       Kernel Version            => Linux linux
2.6.16.9-smp #1 SMP Fri Apr 21 11:20:09 CEST 2006 i686 i686 i386 GNU/Linux
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
