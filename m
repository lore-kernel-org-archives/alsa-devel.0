From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000896]: hercules gamesurround 4 not supported
Date: Wed, 9 Feb 2005 13:28:55 +0100
Message-ID: <a1850372032f8b6b419de2d87c6cf55a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 08BCD25E
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 13:28:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=896> 
======================================================================
Reported By:                pompel55
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   896
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               libranet  --debian testing
Kernel Version:             tried 2.4.21, 26, 27 and 2.6.10
======================================================================
Date Submitted:             02-09-2005 13:28 CET
Last Modified:              02-09-2005 13:28 CET
======================================================================
Summary:                    hercules gamesurround 4 not supported
Description: 
Bought myself a FANTASTIC new soundcard but it does not seem to be
supported yet.
It's not listed yet either, there is support for hercules Game(surround)
up to
version III but it seems Gamesurround 4 is entirely new, a different, 24
bit chip.
-The chip is  recognized but the module installation gives this error:
"wrong eeprom", it seems linux thinks (autodetects it as envy24pt) this is
an integrated VIA chip. You get sound but
the mixer does not work and sound quality is low.
I suppose I'll have to wait until it's properly supported.

stein
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-05 13:28 pompel55       New Issue                                    
02-09-05 13:28 pompel55       Distribution              => libranet  --debian
testing
02-09-05 13:28 pompel55       Kernel Version            => tried 2.4.21, 26, 27
and 2.6.10
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
