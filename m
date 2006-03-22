From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000415]: Terratec EWS88D and clockword sync (Ice1712)
Date: Wed, 22 Mar 2006 02:47:11 +0100
Message-ID: <1bef4f59626c0354a1dd22caab55193d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C3D4B18E
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 02:47:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=415> 
======================================================================
Reported By:                Michele Spinolo
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   415
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Suse
Kernel Version:             2.6.5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-30-2004 12:14 CEST
Last Modified:              03-22-2006 02:47 CET
======================================================================
Summary:                    Terratec EWS88D and clockword sync (Ice1712)
Description: 
Up to four Terratec EWS88D cards can be installed in one system, allowing
an internal connection to sync the clocks.
Using Envy24control "clockword sync" option is not present, so it is not
possible to internally sync multiple cards if s/pdif in/out is used for
other purposes.

======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 02:47 
----------------------------------------------------------------------
Fixed in recent versions

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-30-04 12:14 Michele SpinoloNew Issue                                    
07-30-04 12:14 Michele SpinoloDistribution              => Suse            
07-30-04 12:14 Michele SpinoloKernel Version            => 2.6.5           
11-24-04 19:12 Michele SpinoloIssue Monitored: Michele Spinolo                  
 
03-22-06 02:47 rlrevell       Status                   new => resolved     
03-22-06 02:47 rlrevell       Resolution               open => fixed       
03-22-06 02:47 rlrevell       Assigned To               => rlrevell        
03-22-06 02:47 rlrevell       Note Added: 0008786                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
