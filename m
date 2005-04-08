From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001040]: ice1724: Invalid EEPROM (size = 255)
Date: Fri, 8 Apr 2005 14:10:58 +0200
Message-ID: <a7ed9afdd2070d80e7feef373fa7a9aa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BE8C91FF
	for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2005 14:10:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1040> 
======================================================================
Reported By:                lorenb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1040
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11
======================================================================
Date Submitted:             04-08-2005 14:10 CEST
Last Modified:              04-08-2005 14:10 CEST
======================================================================
Summary:                    ice1724: Invalid EEPROM (size = 255)
Description: 
Have a Shuttle SN25P based system:
http://global.shuttle.com/Product/Barebone/SN25P.asp

It comes with VIA Envy24PT audio controller:
http://www.via.com.tw/en/products/audio/controllers/envy24pt/

Every time I tried and load the ice1724 driver I get an error about
invalid EEPROM size.

I saw this old bug:
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000142

Which indicated this issue was resolved in 1.0.5a.  I'm using v1.0.9rc2.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-08-05 14:10 lorenb         New Issue                                    
04-08-05 14:10 lorenb         Distribution              => Gentoo          
04-08-05 14:10 lorenb         Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
