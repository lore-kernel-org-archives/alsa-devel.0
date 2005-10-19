From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001484]: Sound works only after volume change
Date: Wed, 19 Oct 2005 14:11:07 +0200
Message-ID: <9aaad7c0a3411c63d37cae000df2609c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0EF74161
	for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2005 14:11:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1484> 
======================================================================
Reported By:                kyromaster
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1484
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.13.2-2-default
======================================================================
Date Submitted:             10-19-2005 14:11 CEST
Last Modified:              10-19-2005 14:11 CEST
======================================================================
Summary:                    Sound works only after volume change
Description: 
Much information about this bug is available on
https://bugzilla.novell.com/show_bug.cgi?id=118711
but here is the report again.

I have a ES1988 Allegro-1 soundcard (reported by YaST). When I start my
system
the sound doesn´t work. But when I
change the volume via kmix or another ALSA mixer(no matter whether up or
down) sound starts to work
correctly until I shutdown my system.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-19-05 14:11 kyromaster     New Issue                                    
10-19-05 14:11 kyromaster     Kernel Version            => 2.6.13.2-2-default
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
