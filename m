From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000926]: There is no source code for the functions mix_areas1() and mix_areas2() in the file pcm_dmix.c!
Date: Sun, 20 Feb 2005 03:18:09 +0100
Message-ID: <14408ca9f1d23b0921b3aebe402eab77@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B02B5223
	for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2005 03:18:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=926> 
======================================================================
Reported By:                jiyuan
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   926
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-20-2005 03:18 CET
Last Modified:              02-20-2005 03:18 CET
======================================================================
Summary:                    There is no source code for the functions
mix_areas1() and mix_areas2() in the file pcm_dmix.c!
Description: 
#warning Please, recode mix_areas1() routine to your architecture...
#warning Please, recode mix_areas2() routine to your architecture...
Therefore, when you using dmix under other architecture CPU, the dmix will
crash down, and make error segmentation fault.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-20-05 03:18 jiyuan         New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
