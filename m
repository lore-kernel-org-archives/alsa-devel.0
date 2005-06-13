From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001183]: Details about known bug "Capture doesn't work"
Date: Mon, 13 Jun 2005 13:07:26 +0200
Message-ID: <0d9b693822775adc722aa1965dadd323@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4607A1C1
	for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2005 13:07:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1183> 
======================================================================
Reported By:                Jochen
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1183
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-11-2005 20:34 CEST
Last Modified:              06-13-2005 13:07 CEST
======================================================================
Summary:                    Details about known bug "Capture doesn't work"
Description: 
I'm experiencing the problem with es1968 not supporting capture described
in various places. This bug keeps me from using skype: the second it tries
to read from the OSS compatibility device it receives and EINVAL

using the old OSS maestro driver works thou.

apparently this is the known bug "capture doesn't work"

I'd like to ask for a little more information on this bug, and whether
it's possible to contribute here.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-13-05 13:07 
----------------------------------------------------------------------
Could you describe more "details" about the bug?
What exactly skype tells?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-05 20:34 Jochen         New Issue                                    
06-13-05 13:07 tiwai          Note Added: 0005007                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
