From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001473]: mic and line-in with very low volume
Date: Wed, 12 Oct 2005 09:21:41 +0200
Message-ID: <b315091dbf55b91e11005b1ab7d63cc3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 87BA618E
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 09:21:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1473> 
======================================================================
Reported By:                oka
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1473
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.13
======================================================================
Date Submitted:             10-12-2005 09:21 CEST
Last Modified:              10-12-2005 09:21 CEST
======================================================================
Summary:                    mic and line-in with very low volume
Description: 
Same issue like bug #1232 and #1346 but with Codec Analog Devices AD1986.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1346
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1346

Line-in and mic record only with very low volume. I have only rear jacks
and don't know how they are connected to the board (locked case :-( 
I've tried Alsa 1.0.9 and 1.0.10-rc1 with no success.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-12-05 09:21 oka            New Issue                                    
10-12-05 09:21 oka            File Added: asound.state                     
10-12-05 09:21 oka            Distribution              => Gentoo          
10-12-05 09:21 oka            Kernel Version            => 2.6.13          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
