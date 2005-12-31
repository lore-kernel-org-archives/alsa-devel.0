From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000441]: Master volume not doing anything
Date: Sat, 31 Dec 2005 04:05:58 +0100
Message-ID: <dfd3e5db2ce6d56fa961137eca9361f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10C2D15D
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 04:05:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=441> 
======================================================================
Reported By:                Simon
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   441
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Slackware
Kernel Version:             2.
======================================================================
Date Submitted:             08-14-2004 20:49 CEST
Last Modified:              12-31-2005 04:05 CET
======================================================================
Summary:                    Master volume not doing anything
Description: 
I have sound, everything works, but the master volume control doesn't have
any effect on the actual volume output.

Running Soundblaster Live! 5.1 dolby surround system
======================================================================

----------------------------------------------------------------------
 Simon - 07-16-05 21:20 
----------------------------------------------------------------------
It works now for only the subwoofer and the left front and rear... it's an
improvement

Current kernel version running:
2.6.8-24.16 or 2.6.11.9

Latest ALSA driver



----------------------------------------------------------------------
 rlrevell - 12-31-05 04:05 
----------------------------------------------------------------------
Do you consider the bug fixed?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-14-04 20:49 Simon          New Issue                                    
08-14-04 20:49 Simon          Distribution              => Slackware       
08-14-04 20:49 Simon          Kernel Version            => 2.              
07-16-05 17:14 jdthood        Note Added: 0005499                          
07-16-05 21:19 Simon          Note Added: 0005502                          
07-16-05 21:20 Simon          Note Edited: 0005502                         
08-03-05 12:24 perex          Category                 CORE - control => PCI -
emu10k1
12-31-05 04:05 rlrevell       Note Added: 0007336                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
