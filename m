From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001635]: VIA 8237 with CMI9761 - master channel doesn't control volume
Date: Sat, 10 Dec 2005 11:10:59 +0100
Message-ID: <ddcb51d1d0925da5f6ef620fb118bafa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1C49018D
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2005 11:11:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1635> 
======================================================================
Reported By:                konmal
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1635
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SUSE 10
Kernel Version:             2.6.13-15.7-default
======================================================================
Date Submitted:             12-10-2005 11:10 CET
Last Modified:              12-10-2005 11:10 CET
======================================================================
Summary:                    VIA 8237 with CMI9761 - master channel doesn't
control volume
Description: 
Like in 
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1510
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1599

master control doesn't change volume. Muting master channel doesn't work
either.

I have kernel modules of 1.0.9b and utils/libs of 1.0.10
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 11:10 konmal         New Issue                                    
12-10-05 11:10 konmal         Distribution              => SUSE 10         
12-10-05 11:10 konmal         Kernel Version            => 2.6.13-15.7-default
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
