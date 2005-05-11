From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001100]: Driver loaded, no sound card detected
Date: Wed, 11 May 2005 15:51:24 +0200
Message-ID: <e6b9114776ed98c6ae002110a7fbc618@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E6B0C1FD
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2005 15:51:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1100> 
======================================================================
Reported By:                dwatters
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1100
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux 9.2
Kernel Version:             2.6.8-14.24
======================================================================
Date Submitted:             05-11-2005 15:51 CEST
Last Modified:              05-11-2005 15:51 CEST
======================================================================
Summary:                    Driver loaded, no sound card detected
Description: 
In /var/log/message gives:
May 11 10:30:43 miro kernel: ACPI: PCI interrupt 0000:05:06.0[A] -> GSI 5
(level, low) -> IRQ 5
May 11 10:30:43 miro kernel: ice1724: No matching model found for ID
0x97123650
May 11 10:30:43 miro kernel: ice1724: Invalid EEPROM (size = 255)
May 11 10:30:43 miro kernel: ICE1724: probe of 0000:05:06.0 failed with
error -5


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-11-05 15:51 dwatters       New Issue                                    
05-11-05 15:51 dwatters       Distribution              => SuSE Linux 9.2  
05-11-05 15:51 dwatters       Kernel Version            => 2.6.8-14.24     
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
