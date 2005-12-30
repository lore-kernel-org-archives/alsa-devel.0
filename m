From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001281]: Sound support for onboard ASUS P5GD1-VM sound?
Date: Fri, 30 Dec 2005 23:35:29 +0100
Message-ID: <464c1719ceec46f5f03b2fd1cfbbad72@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 871FD154
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:35:29 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1281> 
======================================================================
Reported By:                keith
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1281
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-26-2005 08:18 CEST
Last Modified:              12-30-2005 23:35 CET
======================================================================
Summary:                    Sound support for onboard ASUS P5GD1-VM sound?
Description: 
I've tried using the intel-8x0 drivers, but I cannot get sound working on
my ASUS P5GD1-VM mobo. I was wondering if anyone was working on making
sound available on this mobo.  It's a pretty serious issue to me, and it's
preventing a complete migration to the OS.
======================================================================

----------------------------------------------------------------------
 Grazy - 07-26-05 09:00 
----------------------------------------------------------------------
Try the intel-hda driver instead of the intel-8x0 one.

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:35 
----------------------------------------------------------------------
User was using wrong driver

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-26-05 08:18 keith          New Issue                                    
07-26-05 08:18 keith          Distribution              => Ubuntu          
07-26-05 09:00 Grazy          Note Added: 0005568                          
12-30-05 23:35 rlrevell       Status                   new => closed       
12-30-05 23:35 rlrevell       Note Added: 0007294                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
