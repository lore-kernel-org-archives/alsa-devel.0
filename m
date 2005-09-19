From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000877]: balance problem with ALC880 (Intel HD Audio)
Date: Mon, 19 Sep 2005 09:58:43 +0200
Message-ID: <b349cffe254d6654fa0782a97950a537@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AEDCB148
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 09:58:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=877> 
======================================================================
Reported By:                alphacc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   877
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Scientific Linux 3.03 (close to Redhat ES 3)
Kernel Version:             2.4.21
======================================================================
Date Submitted:             02-02-2005 11:32 CET
Last Modified:              09-19-2005 09:58 CEST
======================================================================
Summary:                    balance problem with ALC880 (Intel HD Audio)
Description: 
module : snd-azx

When I try to change the Front balance (left/right), the Front volume is
going up or down randomly.
Tested with xmms, alsamixer, gnome-alsamixer.

Is it a known problem with other platforms / modules ?

======================================================================

----------------------------------------------------------------------
 jdthood - 09-19-05 09:58 
----------------------------------------------------------------------
alphacc: Is there any improvement in later ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-05 11:32 alphacc        New Issue                                    
02-02-05 11:32 alphacc        Distribution              => Scientific Linux 3.03
(close to Redhat ES 3)
02-02-05 11:32 alphacc        Kernel Version            => 2.4.21          
09-19-05 09:58 jdthood        Note Added: 0006278                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
