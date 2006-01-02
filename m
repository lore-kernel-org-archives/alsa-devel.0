From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001698]: Opening not-dmix pcm immediately after closing dmix-pcm fails.
Date: Mon, 2 Jan 2006 10:57:26 +0100
Message-ID: <2d822abf79a0a4bf0ee57b757242a078@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3FDD7156
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 10:57:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1698> 
======================================================================
Reported By:                skandalfo
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1698
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             01-02-2006 10:57 CET
Last Modified:              01-02-2006 10:57 CET
======================================================================
Summary:                    Opening not-dmix pcm immediately after closing
dmix-pcm fails.
Description: 
As reported additionally in closed
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001184 I'm having
problems with the
default configuration supplied for NFORCE cards when xine switches from
2.0 to 5.1 audio when playing DVD's.

See the report for the bug in xine-lib here:
https://sourceforge.net/tracker/index.php?func=detail&aid=1226595&group_id=9655&atid=109655

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-06 10:57 skandalfo      New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
