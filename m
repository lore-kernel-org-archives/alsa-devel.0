From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001302]: Clicking noise when using kphone with the ALSA AD1816A sound driver
Date: Tue, 2 Aug 2005 17:29:12 +0200
Message-ID: <8bd539c4fc82767b53f35b18c24350ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DA0051DF
	for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2005 17:29:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1302> 
======================================================================
Reported By:                tek01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1302
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             vanilla 2.6.11.12, vanilla 2.6.10, Debians 2.6.8-2
======================================================================
Date Submitted:             08-02-2005 17:29 CEST
Last Modified:              08-02-2005 17:29 CEST
======================================================================
Summary:                    Clicking noise when using kphone with the ALSA
AD1816A sound driver
Description: 
Using kphone (VoIP softphone) with the ALSA native API and the AD1816A
sound driver a continuous clicking noise is heard approximately 3 times
per second. Using the OSS AD1816 with kphone(OSS API) sound driver on the
same system and kernel audio is crystal clear. Also audio latency is much
higher (0.3-0.5s guessed) compared to the OSS AD1816 (<0.1s, also guessed)
sound driver.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-05 17:29 tek01          New Issue                                    
08-02-05 17:29 tek01          Distribution              => Debian Sarge    
08-02-05 17:29 tek01          Kernel Version            => vanilla 2.6.11.12,
vanilla 2.6.10, Debians 2.6.8-2
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
