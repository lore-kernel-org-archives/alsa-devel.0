From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000203]: Line-In is not working with
	ICH - Intel ICH5 Intel8x0
Date: Thu, 13 Jul 2006 20:02:29 +0200
Message-ID: <248b7a504f8904ee7a64d8ef8caae782@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B320F19D
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Jul 2006 20:02:29 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=203> 
======================================================================
Reported By:                dkg
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   203
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Crux Linux
Kernel Version:             2.6.5
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             04-12-2004 20:16 CEST
Last Modified:              07-13-2006 20:02 CEST
======================================================================
Summary:                    Line-In is not working with ICH - Intel ICH5
Intel8x0
Description: 
 Today I upgraded to 2.6.5 because I thought it may help me in solving my
problem with my soundcard. But it doesnt. It still exists. Mic and
Line-Out are ok. But my Line-In is not working. I need it to record sound
which comes from my turntables. Following are some informations about my
card. It would be great if someone could help me.
======================================================================

----------------------------------------------------------------------
 DavidALSA - 08-28-05 00:02 
----------------------------------------------------------------------
Using MEPIS Linux here with kernel 2.6.7 on laptop with Intel 8x0 audio
hardware, and cannot record from the mic input (laptop has no other
external sound inputs available). Would appreciate this being added to
ALSA.

----------------------------------------------------------------------
 rlrevell - 08-28-05 00:19 
----------------------------------------------------------------------
2.6.7 is way too old, does it work with a newer ALSA like 1.0.9b?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-04 20:16 dkg            New Issue                                    
04-12-04 20:16 dkg            Distribution              => Crux Linux      
04-12-04 20:16 dkg            Kernel Version            => 2.6.5           
04-13-04 10:51 Voluspa        Note Added: 0000787                          
04-13-04 10:53 Voluspa        Note Edited: 0000787                         
03-10-05 15:30 jdthood        Note Added: 0003865                          
08-28-05 00:02 DavidALSA      Note Added: 0005960                          
08-28-05 00:19 rlrevell       Note Added: 0005961                          
07-13-06 20:02 Adrian Bunk    Status                   new => closed       
07-13-06 20:02 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
