From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001173]: No sound from rear channels
Date: Wed, 8 Jun 2005 21:19:38 +0200
Message-ID: <d9efac7962e96e600a57ef9f60efa564@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 552AD196
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 21:19:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1173> 
======================================================================
Reported By:                rraptorr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1173
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware
Kernel Version:             2.6.11.11
======================================================================
Date Submitted:             06-08-2005 21:19 CEST
Last Modified:              06-08-2005 21:19 CEST
======================================================================
Summary:                    No sound from rear channels
Description: 
I was trying to get my surround setup working under Linux. Everything is
working fine under Windows so hardware is OK. But under Linux I was unable
to get any sound from Center/LFE. And the rear channels where controlled
by Center/LFE mixer. After changing routing in ICH4.conf (as in 1.0.8) I
have sound from Center/LFE which is controlled by correct mixer but now I
don't get any sound from Rear speakers. I've even tried some random mixer
settings (due to the fact, that oryginally Rear was controlled by Center)
but with no luck.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 21:19 rraptorr       New Issue                                    
06-08-05 21:19 rraptorr       Distribution              => Slackware       
06-08-05 21:19 rraptorr       Kernel Version            => 2.6.11.11       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
