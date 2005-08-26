From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001022]: Cannot change volume (CMI9880)
Date: Fri, 26 Aug 2005 14:53:18 +0200
Message-ID: <8f285b39860254cdf53f77b174eec107@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 030531D6
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 14:53:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1022> 
======================================================================
Reported By:                gomera
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1022
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-29-2005 23:28 CEST
Last Modified:              08-26-2005 14:53 CEST
======================================================================
Summary:                    Cannot change volume (CMI9880)
Description: 
I have read some articles about this problem and i know that it's not
important to change the volume using PCM, but some people have written
that we have to use softvol (probably software volume). Somebody told me
that he's using sw mixer, so what does it mean and how can i change the
volume.
Thanks
======================================================================

----------------------------------------------------------------------
 tiwai - 08-26-05 14:53 
----------------------------------------------------------------------
Already fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-05 23:28 gomera         New Issue                                    
08-26-05 14:53 tiwai          Status                   new => resolved     
08-26-05 14:53 tiwai          Resolution               open => fixed       
08-26-05 14:53 tiwai          Assigned To               => tiwai           
08-26-05 14:53 tiwai          Note Added: 0005952                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
