From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001415]: No sound after adjustment of volume
Date: Mon, 19 Dec 2005 02:31:28 +0100
Message-ID: <7e64d959c1d1e6ee847a106b49bdc08c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F0DDC178
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2005 02:31:28 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1415> 
======================================================================
Reported By:                war0060
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1415
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.12-r10
======================================================================
Date Submitted:             09-12-2005 11:49 CEST
Last Modified:              12-19-2005 02:31 CET
======================================================================
Summary:                    No sound after adjustment of volume
Description: 
I'm using the snd-hda-intel driver, everything seems ok, but when I
adjusted the volume, there will be no sound anymore. After reboot, it
works again, the main problem is the volume cannot be adjusted.
======================================================================

----------------------------------------------------------------------
 war0060 - 09-20-05 05:19 
----------------------------------------------------------------------
I've tried 1.010rc1, still have the problem

----------------------------------------------------------------------
 rlrevell - 12-19-05 02:31 
----------------------------------------------------------------------
Try 1.0.11-rc1.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-12-05 11:49 war0060        New Issue                                    
09-12-05 11:49 war0060        Distribution              => Gentoo          
09-12-05 11:49 war0060        Kernel Version            => 2.6.12-r10      
09-12-05 16:24 tiwai          Note Added: 0006145                          
09-15-05 04:30 war0060        Note Added: 0006191                          
09-15-05 16:01 tiwai          Note Added: 0006210                          
09-20-05 05:19 war0060        Note Added: 0006310                          
12-13-05 21:18 dzi            Issue Monitored: dzi                         
12-19-05 02:31 rlrevell       Note Added: 0007085                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
