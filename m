From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000313]: Compilation error using 2.6.x kernel headers
Date: Fri, 25 Mar 2005 15:48:46 +0100
Message-ID: <13cd22d90682c215e5b435e60b22a9b3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 144EF223
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2005 15:48:46 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=313> 
======================================================================
Reported By:                nimster
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   313
Category:                   general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-29-2004 20:16 CEST
Last Modified:              03-25-2005 15:48 CET
======================================================================
Summary:                    Compilation error using 2.6.x kernel headers
Description: 
In my LFS (http://www.linuxfromscratch.org), I have a 2.6.6 kernel with
2.6.3 kernel headers. Compilation of ALSA-lib fails with (this is actually
1.0.5, but it failed with 1.0.4 too, with the same error).




======================================================================

----------------------------------------------------------------------
 nimster - 01-21-05 11:50 
----------------------------------------------------------------------
I imagine so, considering there's both a new ALSA version and a new kernel
version since then. I might try building it again sometime, and will let
you know definitely (For now I am using a different linux distribution).

Thank you very much,
-Nimster

----------------------------------------------------------------------
 tiwai - 01-21-05 21:18 
----------------------------------------------------------------------
This bug was known and already fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-04 20:16 nimster        New Issue                                    
01-21-05 00:31 jdthood        Note Added: 0003336                          
01-21-05 11:50 nimster        Note Added: 0003342                          
01-21-05 21:18 tiwai          Status                   new => resolved     
01-21-05 21:18 tiwai          Resolution               open => fixed       
01-21-05 21:18 tiwai          Assigned To               => tiwai           
01-21-05 21:18 tiwai          Note Added: 0003360                          
01-21-05 21:18 tiwai          Assigned To              tiwai =>            
03-25-05 15:48 jdthood        Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
