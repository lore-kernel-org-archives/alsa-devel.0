From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000326]: Emagic EMI 6/2m: no recording
Date: Thu, 16 Mar 2006 08:43:57 +0100
Message-ID: <5bcdace827b01242c26ae63ac54e075e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 063211FB
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 08:43:57 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=326> 
======================================================================
Reported By:                kompi
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   326
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo Linux
Kernel Version:             2.6.7-rc2 (also tested earlier stable versions)
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-07-2004 19:52 CEST
Last Modified:              03-16-2006 08:43 CET
======================================================================
Summary:                    Emagic EMI 6/2m: no recording
Description: 
Cannot get a recording stream from the USB device Emagic EMI 6/2m running
with snd-usb-audio. 
No errors oder hangs are produced. Just a zero stream is outputted (in
every data rate the emi can work with).
The mixer controls are set correctly, nothing is muted.

======================================================================

----------------------------------------------------------------------
 jdthood - 08-30-05 12:17 
----------------------------------------------------------------------
Hi.  What's the status of this bug.  Any improvement in later ALSA
releases?

----------------------------------------------------------------------
 rlrevell - 03-16-06 08:43 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-04 19:52 kompi          New Issue                                    
06-07-04 19:52 kompi          Distribution              => Gentoo Linux    
06-07-04 19:52 kompi          Kernel Version            => 2.6.7-rc2 (also
tested earlier stable versions)
08-30-05 12:17 jdthood        Note Added: 0005968                          
03-16-06 08:43 rlrevell       Status                   assigned => closed  
03-16-06 08:43 rlrevell       Note Added: 0008599                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
