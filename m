From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001033]: hda sound 82801FB/FBM/FR/FW/FRW (ICH6 Family)
Date: Sat, 24 Dec 2005 03:42:37 +0100
Message-ID: <0af2de3085e4b268ac3316a3b1e14f3d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1491F173
	for <alsa-devel@alsa-project.org>; Sat, 24 Dec 2005 03:42:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1033> 
======================================================================
Reported By:                sjankie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1033
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             04-03-2005 15:07 CEST
Last Modified:              12-24-2005 03:42 CET
======================================================================
Summary:                    hda sound 82801FB/FBM/FR/FW/FRW (ICH6 Family)
Description: 
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)

azx driver compliens about: NO AFG found.

alsmixer starts, but no sound.
======================================================================

----------------------------------------------------------------------
 crimsunkg - 10-05-05 04:48 
----------------------------------------------------------------------
slack_kid, have you tried a cvs checkout of alsa-kernel and alsa-driver?

----------------------------------------------------------------------
 slack_kid - 12-24-05 03:42 
----------------------------------------------------------------------
no i have not, i will checkout the alsa site to see how to do it.  thanks,
ill let you know how things turn out.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-05 15:07 sjankie        New Issue                                    
04-03-05 15:07 sjankie        Kernel Version            => 2.6.11.6        
04-03-05 15:08 sjankie        Issue Monitored: sjankie                     
04-03-05 15:08 sjankie        Issue End Monitor: sjankie                    
04-03-05 15:08 sjankie        Issue Monitored: sjankie                     
04-04-05 17:09 1g0R           Note Added: 0004328                          
04-05-05 14:52 sjankie        Note Added: 0004337                          
04-05-05 18:48 Thomas         Issue Monitored: Thomas                      
04-05-05 19:50 Thomas         Note Added: 0004339                          
04-08-05 21:08 Thomas         Note Added: 0004373                          
04-15-05 09:06 Thomas         Issue End Monitor: Thomas                    
09-29-05 21:59 slack_kid      Note Added: 0006424                          
09-29-05 22:13 slack_kid      Issue Monitored: slack_kid                    
10-05-05 04:48 crimsunkg      Note Added: 0006429                          
12-24-05 03:42 slack_kid      Note Added: 0007141                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
