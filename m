From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001597]: alsamixer does not work
Date: Fri, 25 Nov 2005 04:19:46 +0100
Message-ID: <636ebef9513576d374dc4db0ab3bd5f1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2D8EF1C1
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2005 04:19:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1597> 
======================================================================
Reported By:                lanewhoy
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1597
Category:                   simple mixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-25-2005 04:19 CET
Last Modified:              11-25-2005 04:19 CET
======================================================================
Summary:                    alsamixer does not work
Description: 
Any attempt to run a alsamixer or alsactl fails with the error:

ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback
Volume',0,140733193388032,46909632806912) appears twice or more

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-25-05 04:19 lanewhoy       New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
