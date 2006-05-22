From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002145]: Quiet sound, no master channel, no PCM channel and no ability to switch to non-8ch mode
Date: Tue, 23 May 2006 00:22:22 +0200
Message-ID: <58da72672b2fcc6cbcec74c9c70ab3fd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 496C6189
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 00:22:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2145> 
======================================================================
Reported By:                rathann
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2145
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2111_FC5 (SMP)
======================================================================
Date Submitted:             05-23-2006 00:22 CEST
Last Modified:              05-23-2006 00:22 CEST
======================================================================
Summary:                    Quiet sound, no master channel, no PCM channel and
no ability to switch to non-8ch mode
Description: 
1. Sound is very quiet. I need to set every channel to max to have decent
volume.
2. There's no master channel and there's no PCM channel.
3. There's a switch to change the number of output channels, but it has
only one option: 8ch (card supports 2-8ch).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 00:22 rathann        New Issue                                    
05-23-06 00:22 rathann        Distribution              => Fedora Core 5   
05-23-06 00:22 rathann        Kernel Version            => 2.6.16-1.2111_FC5
(SMP)
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
