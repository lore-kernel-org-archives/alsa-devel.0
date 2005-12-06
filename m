From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000931]: Wish for M-Audio Revolution 5.1 Support
Date: Tue, 6 Dec 2005 15:58:43 +0100
Message-ID: <f5b462f15516637848038513ebbbf201@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9E7C1A9
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2005 15:58:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=931> 
======================================================================
Reported By:                Thinky
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   931
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-22-2005 10:40 CET
Last Modified:              12-06-2005 15:58 CET
======================================================================
Summary:                    Wish for M-Audio Revolution 5.1 Support
Description: 
Could you add support for that soundcard?
I hope parts of the ice1724/12 driver can be reused so that it is not a
too hard task.
======================================================================

----------------------------------------------------------------------
 cyan - 12-03-05 22:21 
----------------------------------------------------------------------
What about this:
http://www.mph.eclipse.co.uk/pub/linux/patches/ice1712_revo.patch
May it help you?

----------------------------------------------------------------------
 tiwai - 12-06-05 15:58 
----------------------------------------------------------------------
The partial implementation is on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-05 10:40 Thinky         New Issue                                    
02-22-05 10:40 Thinky         Distribution              => Debian unstable 
02-22-05 10:40 Thinky         Kernel Version            => 2.6.10          
02-22-05 10:53 perex          Note Added: 0003696                          
02-27-05 17:42 Thinky         Note Added: 0003742                          
03-02-05 17:40 Thinky         Note Added: 0003780                          
12-02-05 11:54 perex          Note Added: 0006888                          
12-03-05 22:21 cyan           Note Added: 0006904                          
12-03-05 22:36 cyan           Issue Monitored: cyan                        
12-06-05 15:58 tiwai          Note Added: 0006928                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
