From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000688]: Errors in testing gcc and ld in the sparc and sparc64 sections of the configure file
Date: Sun, 28 Nov 2004 19:36:21 +0100
Message-ID: <ae99015b70ab00d269c33377b40b2712@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 35F9F26F
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 19:36:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=688> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   688
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-28-2004 19:36 CET
Last Modified:              11-28-2004 19:36 CET
======================================================================
Summary:                    Errors in testing gcc and ld in the sparc and
sparc64 sections of the configure file
Description: 
Here is a patch to fix the configure script so that it less incorrectly
tests gcc and ld functionality on sparc and sparc64.  You will want to fix
configure.in, of course.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 19:36 jdthood        New Issue                                    
11-28-04 19:36 jdthood        File Added:
alsa-driver-configure.jdth20041128.patch                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
