From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001122]: Soudcard will not suspend due to white list incomplete
Date: Sat, 21 May 2005 16:11:00 +0200
Message-ID: <e25e9d773f28878098bd9aa04aff95ae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E6E5822F
	for <alsa-devel@alsa-project.org>; Sat, 21 May 2005 16:11:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1122> 
======================================================================
Reported By:                hiaslboy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1122
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.11 with 2.6.11.10 patch and softwaresuspend2
======================================================================
Date Submitted:             05-21-2005 16:10 CEST
Last Modified:              05-21-2005 16:11 CEST
======================================================================
Summary:                    Soudcard will not suspend due to white list
incomplete
Description: 
M soundcard will not suspend, even though it works perfectly adding the
vendor 1558 to the whitelist.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-21-05 16:10 hiaslboy       New Issue                                    
05-21-05 16:11 hiaslboy       File Added: es1968-matthias.patch                 
  
05-21-05 16:11 hiaslboy       Distribution              => Debian          
05-21-05 16:11 hiaslboy       Kernel Version            => 2.6.11 with 2.6.11.10
patch and softwaresuspend2
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
