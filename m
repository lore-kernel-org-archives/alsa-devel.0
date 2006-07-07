From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002265]: Input volume doesn't work
	(recording always set to max)
Date: Fri, 7 Jul 2006 18:25:59 +0200
Message-ID: <fc0267e05cf63ad75b4f07a534510a0e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 41C24287
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 18:25:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2265> 
======================================================================
Reported By:                fdoffizi01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2265
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-07-2006 18:25 CEST
Last Modified:              07-07-2006 18:25 CEST
======================================================================
Summary:                    Input volume doesn't work (recording always set to
max)
Description: 
Moving the volume selector on input (capture) device doesn't work, nothing
changes and recording is still at max volume that means clipping and so
on. I was sure it worked some time before.
I apply 2059 and 2093 patches, could they interfere?
Even CD playing isn't working anymore (no audio output at all but I'll
post another bug for it).

Thanks, great job!
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-07-06 18:25 fdoffizi01     New Issue                                    
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
