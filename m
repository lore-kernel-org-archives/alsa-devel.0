From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001708]: Onboard sound using the intel-hda driver does not work on P5GD1-VM motherboards
Date: Wed, 4 Jan 2006 17:07:29 +0100
Message-ID: <ee7d74c8efe724ca0af08af189a99225@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 153CE184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 17:07:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1708> 
======================================================================
Reported By:                keith81
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1708
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-04-2006 10:57 CET
Last Modified:              01-04-2006 17:07 CET
======================================================================
Summary:                    Onboard sound using the intel-hda driver does not
work on P5GD1-VM motherboards
Description: 
I raised this issue back in July or August and received no helpful
feedback.  If you google the P5GD1-VMmobo name, along with alsa, you see
that many people with this mobo have not been able to get sound to work on
their installations of various distributions of linux.

Are there any future plans to include support for P5GD1-VM motherboards? 
No sound is a deal-breaker for me when it comes to migrating. 

I appreciate any feedback, whether it's getting sound to work on my
system, or someone saying support is in the pipes, or someone explaining
why support won't be coming.

Thanks!  Happy new year!
======================================================================

----------------------------------------------------------------------
 tiwai - 01-04-06 17:07 
----------------------------------------------------------------------
First, try the latest ALSA release (1.0.11rc2 o CVS version).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 10:57 keith81        New Issue                                    
01-04-06 17:07 tiwai          Note Added: 0007435                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
