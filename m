From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001603]: via8235 no sound since kernel 2.6.13
Date: Sun, 27 Nov 2005 15:06:40 +0100
Message-ID: <9f97d0f63a7fdf4d1bc9962c001755cf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DD9C71D3
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2005 15:06:40 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1603> 
======================================================================
Reported By:                picobyte
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1603
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               slackware 10.2
Kernel Version:             2.6.13 - 2.6.14.2
======================================================================
Date Submitted:             11-27-2005 15:06 CET
Last Modified:              11-27-2005 15:06 CET
======================================================================
Summary:                    via8235 no sound since kernel 2.6.13
Description: 
I have no sound after a kernel upgrade. I seem to have lost it in 2.6.13.
Sound was available in 2.6.12. 2.6.14.2 didn't give sound either. The
problem is in 1.0.9b and 1.0.10. The modules are loaded as supposed
without error messages and alsamixer is set to volume.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-27-05 15:06 picobyte       New Issue                                    
11-27-05 15:06 picobyte       Distribution              => slackware 10.2  
11-27-05 15:06 picobyte       Kernel Version            => 2.6.13 - 2.6.14.2
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
