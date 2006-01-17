From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001758]: Sound card won't work proper.
Date: Tue, 17 Jan 2006 08:02:06 +0100
Message-ID: <940815f334d154067fa8c63be723d17a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3A472114
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2006 08:02:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1758> 
======================================================================
Reported By:                terminal2000
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1758
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-17-2006 08:02 CET
Last Modified:              01-17-2006 08:02 CET
======================================================================
Summary:                    Sound card won't work proper.
Description: 
My sound card is a CT-4810 one using 5880 chip.
It's using ens1371 driver and everything seems to be OK look from the
screen.
But it makes a strange sound whenever it plays.
And i found if i play a sound file and at the same time drag another
window and keep moving, the strange sound became normal. Once i stoped,
it's back.
So I thought it will work when CPU load is heavy. So i tried play music
while compiling kernel and everything's OK.

It work just OK when the system is busy but makes strange sounds when it's
free.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-06 08:02 terminal2000   New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
