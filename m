From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000613]: Getting configure error
Date: Tue, 22 Feb 2005 09:40:57 +0100
Message-ID: <acd32d14133ec1785adf7a2721e88d63@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E2D41174
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 09:40:57 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=613> 
======================================================================
Reported By:                glower0617
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   613
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Mandrake
Kernel Version:             2.6.8.1-10MDK
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-28-2004 07:22 CEST
Last Modified:              02-22-2005 09:40 CET
======================================================================
Summary:                    Getting configure error
Description: 
checking how to run the C++ preprocessor... /lib/cpp
configure: error: C++ preprocessor "/lib/cpp" fails sanity check
See `config.log' for more details.
make: *** No targets specified and no makefile found.  Stop.
make: *** No rule to make target `install'.  Stop.

======================================================================

----------------------------------------------------------------------
 perex - 02-22-05 09:40 
----------------------------------------------------------------------
Appearently, you don't have installed gcc package in your system.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-28-04 07:22 glower0617     New Issue                                    
10-28-04 07:22 glower0617     Distribution              => Mandrake        
10-28-04 07:22 glower0617     Kernel Version            => 2.6.8.1-10MDK   
02-22-05 09:40 perex          Status                   assigned => resolved
02-22-05 09:40 perex          Resolution               open => fixed       
02-22-05 09:40 perex          Note Added: 0003688                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
