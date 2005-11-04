From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001527]: amixer fails to set right 'Capture Source' channel
Date: Fri, 4 Nov 2005 16:11:55 +0100
Message-ID: <7a53b2d1624773245134fefd86d422da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 88DF8190
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2005 16:11:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1527> 
======================================================================
Reported By:                tartif
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1527
Category:                   amixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-04-2005 16:11 CET
Last Modified:              11-04-2005 16:11 CET
======================================================================
Summary:                    amixer fails to set right 'Capture Source' channel
Description: 
I use the ice1724 driver (Prodigy 7.1 card), ALSA 1.0.10_rc2 (also happens
with 1.0.9).

amixer fails to set the 'capture source' for the right channel (left is
OK). Left channel is set to that requested, right channel always set to
0.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-04-05 16:11 tartif         New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
