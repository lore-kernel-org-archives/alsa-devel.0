From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000716]: patch to enable Line In->Rear Out Switch on GA-8IEXP motherboard
Date: Tue, 11 Jan 2005 16:53:06 +0100
Message-ID: <dbfa83987142ecbb8e6869630452425c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C4A26290
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2005 16:53:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=716> 
======================================================================
Reported By:                wrx
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   716
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-08-2004 12:49 CET
Last Modified:              01-11-2005 16:53 CET
======================================================================
Summary:                    patch to enable Line In->Rear Out Switch on GA-8IEXP
motherboard
Description: 
Trivial patch to enable rear out selection for ens1373 on the Gigabyte
GA-8IEXP motherboard.

Signed-off-by: Andrew Dennison <andrew-lists@optusnet.com.au>

patch attached to this report
======================================================================

----------------------------------------------------------------------
 perex - 12-08-04 13:52 
----------------------------------------------------------------------
Applied to CVS. Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-08-04 12:49 wrx            New Issue                                    
12-08-04 12:49 wrx            File Added: ens1373_rear_ga-8iexp.patch           
        
12-08-04 13:47 perex          Status                   new => resolved     
12-08-04 13:47 perex          Resolution               open => fixed       
12-08-04 13:47 perex          Assigned To               => perex           
12-08-04 13:52 perex          Note Added: 0002785                          
01-11-05 16:53 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
