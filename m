From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001535]: The sound card is detected. No sound from the speakers or headphones.
Date: Mon, 19 Dec 2005 02:19:21 +0100
Message-ID: <236bef78f9518b82fb2f7fee8221477b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A80D5134
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2005 02:19:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1535> 
======================================================================
Reported By:                h4ndr3s
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1535
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware
Kernel Version:             2.6.13
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             11-08-2005 12:17 CET
Last Modified:              12-19-2005 02:19 CET
======================================================================
Summary:                    The sound card is detected. No sound from the
speakers or headphones.
Description: 
I have a Motherboard Intel D915GAV with a sound card Intel HDA onboard,
chipset Realtek ALC880. The Sound Card is detected, the modules are
loaded, but no sound come from the speakers or headphones. 
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-23-05 20:45 
----------------------------------------------------------------------
Probably the same issue as bug #1563, which may be fixed in CVS, please
test.

----------------------------------------------------------------------
 rlrevell - 12-19-05 02:19 
----------------------------------------------------------------------
No response from submitter.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 12:17 h4ndr3s        New Issue                                    
11-08-05 12:17 h4ndr3s        Distribution              => Slackware       
11-08-05 12:17 h4ndr3s        Kernel Version            => 2.6.13          
11-08-05 17:46 tiwai          Note Added: 0006627                          
11-09-05 12:18 h4ndr3s        Note Added: 0006645                          
11-09-05 12:24 h4ndr3s        Note Edited: 0006645                         
11-09-05 13:34 tiwai          Note Added: 0006648                          
11-09-05 14:22 h4ndr3s        Note Added: 0006653                          
11-10-05 16:00 jrgns          Note Added: 0006664                          
11-14-05 11:58 h4ndr3s        Note Added: 0006720                          
11-15-05 12:19 h4ndr3s        Note Edited: 0006720                         
11-23-05 20:45 rlrevell       Note Added: 0006831                          
12-19-05 02:19 rlrevell       Status                   assigned => closed  
12-19-05 02:19 rlrevell       Note Added: 0007079                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
