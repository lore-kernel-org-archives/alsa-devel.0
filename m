From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001723]: Microphone is not functioning.
Date: Sat, 7 Jan 2006 15:35:24 +0100
Message-ID: <e136d70a9f5485177c043529361ffc5f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D5DB11B
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 15:35:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1723> 
======================================================================
Reported By:                rhaegal1337
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1723
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Slackware Linux
Kernel Version:             2.6.14.4
======================================================================
Date Submitted:             01-07-2006 04:24 CET
Last Modified:              01-07-2006 15:35 CET
======================================================================
Summary:                    Microphone is not functioning.
Description: 
Nothing can be recorded or heard by way of the microphone plug which is
part of the Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller integrated into a Dell B120 laptop.
======================================================================

----------------------------------------------------------------------
 hweigel - 01-07-06 15:35 
----------------------------------------------------------------------
This seems to be related to issue 0001713 that I reported earlier.
The sound card idenfication is the same. My Linux distribution is
Suse 10.0 (kernel 2.6.13) on a FSC S7020. All sound applications
tested so far work except for the microphone.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-06 04:24 rhaegal1337    New Issue                                    
01-07-06 04:24 rhaegal1337    Distribution              => Slackware Linux 
01-07-06 04:24 rhaegal1337    Kernel Version            => 2.6.14.4        
01-07-06 15:35 hweigel        Note Added: 0007514                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
