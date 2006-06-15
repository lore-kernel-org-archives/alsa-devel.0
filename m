From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002211]: No sound using snd-hda-intel
	drivers
Date: Thu, 15 Jun 2006 20:33:10 +0200
Message-ID: <ce3bd4130417a0b99910b7e06dc0fa62@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85765184
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jun 2006 20:33:10 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2211> 
======================================================================
Reported By:                jmclennan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2211
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2133_FC5smp
======================================================================
Date Submitted:             06-15-2006 20:33 CEST
Last Modified:              06-15-2006 20:33 CEST
======================================================================
Summary:                    No sound using snd-hda-intel drivers
Description: 
On a new HP DC7600 dual core Pentium D, sound card is detected, but no
sound from either the front jack, rear jack or even the system speaker.

kernel: 2.6.16-1.2133_FC5smp
alsa-driver version: 1.0.11

Everything is unmuted, alsamixer can turn the volume controls up and down
(all levels set to 100%.)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-06 20:33 jmclennan      New Issue                                    
06-15-06 20:33 jmclennan      File Added: scsound.log                      
06-15-06 20:33 jmclennan      Distribution              => Fedora Core 5   
06-15-06 20:33 jmclennan      Kernel Version            => 2.6.16-1.2133_FC5smp
======================================================================
