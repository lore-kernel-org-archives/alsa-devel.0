From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000256]: Support for SB Audigy LS?
Date: Sun, 3 Apr 2005 13:15:51 +0200
Message-ID: <d92641184373c5325926d86a8152f80c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5BD9A1F8
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 13:15:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=256> 
======================================================================
Reported By:                tpog
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   256
Category:                   PCI - emu10k1
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 not fixable
Fixed in Version:           
======================================================================
Date Submitted:             05-06-2004 14:47 CEST
Last Modified:              04-03-2005 13:15 CEST
======================================================================
Summary:                    Support for SB Audigy LS?
Description: 
I appreciate that the Audigy LS runs a different chip to the rest of the
Audigy series, are there any plans to try and support and is there
anything I can do to help? 
======================================================================

----------------------------------------------------------------------
 perex - 05-06-04 19:49 
----------------------------------------------------------------------
We have no documentation from Creative, so the only slow way is to do the
reverse-engineering of the Open Sound System driver.

----------------------------------------------------------------------
 jcdutton - 04-03-05 13:15 
----------------------------------------------------------------------
The Audigy LS is supported with the ALSA snd-ca0106 driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-04 14:47 tpog           New Issue                                    
05-06-04 14:47 tpog           Kernel Version            =>                 
05-06-04 19:49 perex          Note Added: 0001063                          
04-03-05 11:50 jdthood        Status                   new => acknowledged 
04-03-05 11:50 jdthood        Resolution               open => not fixable 
04-03-05 13:15 jcdutton       Status                   acknowledged => closed
04-03-05 13:15 jcdutton       Note Added: 0004306                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
