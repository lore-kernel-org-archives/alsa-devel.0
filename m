From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001490]: unresolved symbol copy_to_user_fromio_R602c96f0 ; unresolved symbol copy_from_user_toio_Rce3ca308
Date: Fri, 21 Oct 2005 15:06:33 +0200
Message-ID: <3d1d7b366d67a7de0c7fe6ae2c766662@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1F1C9125
	for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2005 15:06:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1490> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1490
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             10-21-2005 15:06 CEST
Last Modified:              10-21-2005 15:06 CEST
======================================================================
Summary:                    unresolved symbol copy_to_user_fromio_R602c96f0 ;
unresolved symbol copy_from_user_toio_Rce3ca308
Description: 
Starting from alsa-1.0.10rc2 and CVS on kernel 2.4.22-1.2199.nptl

/etc/init.d/alsasound start

unresolved symbol copy_to_user_fromio_R602c96f0 

unresolved symbol copy_from_user_toio_Rce3ca308
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-05 15:06 Raymond        New Issue                                    
10-21-05 15:06 Raymond        Distribution              => Fedora Core 1   
10-21-05 15:06 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
