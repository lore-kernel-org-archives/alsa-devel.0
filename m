From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001608]: SB Audigy 2 ZS Video Editor won't work with usb2
Date: Wed, 30 Nov 2005 17:21:38 +0100
Message-ID: <4ba954ab8bd07aaa4ab360e502f8c32c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F0471192
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2005 17:21:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1608> 
======================================================================
Reported By:                dvalin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1608
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Mandriva Linux (cooker)
Kernel Version:             2.6.14.3
======================================================================
Date Submitted:             11-30-2005 17:21 CET
Last Modified:              11-30-2005 17:21 CET
======================================================================
Summary:                    SB Audigy 2 ZS Video Editor won't work with usb2
Description: 
When using SB Audigy 2 ZS Video Editor on usb2 it'll freeze the program
trying to play sound with program going into D process state and unable to
stop it, unload the drivers or anything resulting in the need of a reboot

With version 1.0.10rc2 it won't freeze, but the sound will just chop a
*LOT*, when updating to 1.0.10 it just froze
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-30-05 17:21 dvalin         New Issue                                    
11-30-05 17:21 dvalin         Distribution              => Mandriva Linux
(cooker)
11-30-05 17:21 dvalin         Kernel Version            => 2.6.14.3        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
