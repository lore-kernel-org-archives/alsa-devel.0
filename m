From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001485]: Sound disappears occasionally
Date: Thu, 20 Oct 2005 09:57:45 +0200
Message-ID: <430d7f8f51e5958fe78a358cf0a17bd0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5FD1C178
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2005 09:57:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1485> 
======================================================================
Reported By:                jza
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1485
Category:                   PCI - intel8x0
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.12
======================================================================
Date Submitted:             10-19-2005 20:56 CEST
Last Modified:              10-20-2005 09:57 CEST
======================================================================
Summary:                    Sound disappears occasionally
Description: 
Sound disappears completely when doing rapid consecutive seeks in
applications (gxine, xmms). Restarting the application a few times usually
helps, sometimes a complete system freeze is the result.
======================================================================

----------------------------------------------------------------------
 jza - 10-20-05 09:57 
----------------------------------------------------------------------
The problem seems not to occur when playing sound through OSS emulation.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-19-05 20:56 jza            New Issue                                    
10-19-05 20:56 jza            Distribution              => Debian          
10-19-05 20:56 jza            Kernel Version            => 2.6.12          
10-20-05 09:57 jza            Note Added: 0006499                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
