From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0000944]: Uniquely identify Creative Soundblaster Live 5.1 and 7.1
Date: Wed, 8 Jun 2005 16:34:15 +0200
Message-ID: <79ccae356eab3b52a48760fcddadff8e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 66D7F1A8
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 16:34:15 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=944> 
======================================================================
Reported By:                drinky76
Assigned To:                perex
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   944
Category:                   soundcard matrix
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-26-2005 04:08 CET
Last Modified:              06-08-2005 16:34 CEST
======================================================================
Summary:                    Uniquely identify Creative Soundblaster Live 5.1 and
7.1
Description: 
The Creative Labs Soundblaster Live 5.1 card and Creative Labs Soundblaster
Live 24bit 7.1 cards use different drivers as they have different
chipsets.

This is not obvious from the matrix and led me (and it seems quite a few
others) to purchase the wrong card. The 5.1 uses the emu10k1 driver and
the 7.1 uses the audigyls driver. The Matrix only list the SB Live (no
version), SB Live PLatinum and SB Live Value. No distinction is made
between the SB Live 5.1 and SB Live 7.1
======================================================================

----------------------------------------------------------------------
 perex - 06-08-05 16:34 
----------------------------------------------------------------------
Corrected now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-26-05 04:08 drinky76       New Issue                                    
06-08-05 16:34 perex          Status                   new => resolved     
06-08-05 16:34 perex          Resolution               open => fixed       
06-08-05 16:34 perex          Assigned To               => perex           
06-08-05 16:34 perex          Note Added: 0004953                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
