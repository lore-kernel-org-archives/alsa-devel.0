From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000959]: After S3 resume: ali_stimer_read: stimer is not ready
Date: Thu, 3 Mar 2005 18:41:22 +0100
Message-ID: <da11573d4d8dcc766f349473bc35985a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A6C9C1E5
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2005 18:41:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=959> 
======================================================================
Reported By:                avuton
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   959
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11
======================================================================
Date Submitted:             03-03-2005 18:41 CET
Last Modified:              03-03-2005 18:41 CET
======================================================================
Summary:                    After S3 resume: ali_stimer_read: stimer is not
ready
Description: 
After S3 resume, 'ali_stimer_read: stimer is not ready.' repeats until I
reset/power down the computer.

Workaround is to stop all audio activity and unload the driver, which
works fine.

This happens on my Libretto L5.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-03-05 18:41 avuton         New Issue                                    
03-03-05 18:41 avuton         Distribution              => Gentoo          
03-03-05 18:41 avuton         Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
