From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000466]: tumbler_init_client error after waking
Date: Wed, 22 Mar 2006 03:11:22 +0100
Message-ID: <cc82f859ab79d07f9d6ada5b67a76ea3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 557581A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:11:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=466> 
======================================================================
Reported By:                schwab
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   466
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-26-2004 22:36 CEST
Last Modified:              03-22-2006 03:11 CET
======================================================================
Summary:                    tumbler_init_client error after waking
Description: 
After waking up the driver is unable to restore the sound settings.  I have
to explicitly load the settings to make sound working again.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-14-05 15:56 
----------------------------------------------------------------------
Submitter: Is this problem fixed in more recent ALSA versions?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:11 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-26-04 22:36 schwab         New Issue                                    
08-27-04 19:37 tiwai          Note Added: 0001647                          
10-21-04 23:24 schwab         Note Added: 0002225                          
09-14-05 15:56 jdthood        Note Added: 0006164                          
09-14-05 15:56 jdthood        Summary                  tumbler_init_client error
=> tumbler_init_client error after waking
03-22-06 03:11 rlrevell       Status                   assigned => closed  
03-22-06 03:11 rlrevell       Note Added: 0008801                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
